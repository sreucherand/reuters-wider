//
//  CSBoucingView.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 07/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import "CSBoucingView.h"

static CGFloat rubberBandDistance(CGFloat offset, CGFloat dimension) {
    const CGFloat constant = 0.55f;
    
    CGFloat result = (constant * abs(offset) * dimension) / (dimension + constant * abs(offset));
    
    return offset < 0.0f ? -result : result;
}

@interface CSDynamicItem : NSObject <UIDynamicItem>

@property (nonatomic, readwrite) CGPoint center;
@property (nonatomic, readonly) CGRect bounds;
@property (nonatomic, readwrite) CGAffineTransform transform;

@end

@implementation CSDynamicItem

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _bounds = CGRectMake(0, 0, 1, 1);
    }
    
    return self;
}

@end

@interface CSBoucingView () {
    BOOL _decelerating;
}

@property CGRect startFrame;

@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (weak, nonatomic) UIDynamicItemBehavior *decelerationBehavior;
@property (weak, nonatomic) UIAttachmentBehavior *springBehavior;

@property (strong, nonatomic) CSDynamicItem *dynamicItem;
@property (strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@end

@implementation CSBoucingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        _direction = CSDirectionLeft;
        _scrollEnabled = YES;
        _decelerating = NO;
        
        self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        
        [self addGestureRecognizer:self.panGestureRecognizer];
        
        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        self.dynamicItem = [[CSDynamicItem alloc] init];
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    if (self.decelerationBehavior && !self.springBehavior) {
        UIAttachmentBehavior *springBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.dynamicItem attachedToAnchor:self.startFrame.origin];
        
        springBehavior.length = 0;
        springBehavior.damping = 1;
        springBehavior.frequency = 2;
        
        __weak typeof(self)weakSelf = self;
        
        springBehavior.action = ^{
            if (!_decelerating) {
                _decelerating = YES;
                
                if ([weakSelf.delegate respondsToSelector:@selector(boucingViewWillBeginDecelarating:)]) {
                    [weakSelf.delegate performSelector:@selector(boucingViewWillBeginDecelarating:) withObject:self];
                }
            }
        };
        
        [self.animator addBehavior:springBehavior];
        
        self.springBehavior = springBehavior;
    }
    
    self.contentOffset = CGPointMake(frame.origin.x - self.startFrame.origin.x, 0);
    
    if (self.scrollEnabled && [self.delegate respondsToSelector:@selector(boucingViewDidScroll:)]) {
        [self.delegate performSelector:@selector(boucingViewDidScroll:) withObject:self];
    }
}

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    if (scrollEnabled) {
        [self addGestureRecognizer:self.panGestureRecognizer];
    } else {
        [self removeGestureRecognizer:self.panGestureRecognizer];
    }
    
    if (_scrollEnabled != scrollEnabled) {
        _scrollEnabled = scrollEnabled;
        
        [self.animator removeAllBehaviors];
        
        self.frame = _startFrame;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Gesture

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGestureRecognizer {
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            if (CGRectEqualToRect(self.startFrame, CGRectZero)) {
                self.startFrame = self.frame;
            }
            _decelerating = NO;
            
            [self.animator removeAllBehaviors];
            break;
        }
        
        case UIGestureRecognizerStateChanged: {
            CGPoint translation = [panGestureRecognizer translationInView:panGestureRecognizer.view];
            
            CGRect frame = self.startFrame;
            CGPoint position = CGPointMake(frame.origin.x + translation.x, 0);
            
            position.x = rubberBandDistance(position.x - frame.origin.x, CGRectGetWidth(self.bounds));
            
            frame.origin.x = frame.origin.x + position.x;
            
            self.frame = frame;
            break;
        }
        
        case UIGestureRecognizerStateEnded: {
            CGPoint velocity = [panGestureRecognizer velocityInView:panGestureRecognizer.view];
            
            velocity.y = 0;
            
            self.dynamicItem.center = self.frame.origin;
            
            UIDynamicItemBehavior *decelerationBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.dynamicItem]];
            
            [decelerationBehavior addLinearVelocity:velocity forItem:self.dynamicItem];
            [decelerationBehavior setResistance:2];
            
            __weak typeof(self)weakSelf = self;
            
            decelerationBehavior.action = ^{
                CGRect bounds = weakSelf.frame;
                
                bounds.origin = weakSelf.dynamicItem.center;
                weakSelf.frame = bounds;
            };
            
            [self.animator addBehavior:decelerationBehavior];
            
            self.decelerationBehavior = decelerationBehavior;
            break;
        }
        
        default:
            break;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isEqual:self.panGestureRecognizer]) {
        CGPoint velocity = [((UIPanGestureRecognizer *)gestureRecognizer) velocityInView:gestureRecognizer.view];
        
        return fabs(velocity.x) > fabs(velocity.y);
    }
    
    return YES;
}

@end
