//
//  CSGradientIndicatorView.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 23/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSGradientIndicatorView.h"

@interface CSGradientIndicatorView () {
    UIColor *_queueTopColor;
    UIColor *_queueBottomColor;
}

@property (strong, nonatomic) CSTweenOperation *operation;

@property (assign, nonatomic) CGFloat progression;

@end

@implementation CSGradientIndicatorView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.topColor = [UIColor blackColor];
        self.bottomColor = [UIColor blackColor];
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGFloat locations[4];
    
    locations[0] = 0;
    locations[1] = self.progression;
    locations[2] = self.progression;
    locations[3] = 1;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    
    NSMutableArray *colors = [[NSMutableArray alloc] initWithCapacity:4];
    
    [colors addObject:(id)[self.bottomColor CGColor]];
    [colors addObject:(id)[self.bottomColor colorWithAlphaComponent:0].CGColor];
    [colors addObject:(id)self.topColor.CGColor];
    [colors addObject:(id)[self.topColor colorWithAlphaComponent:0].CGColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(space, (CFArrayRef)colors, locations);
    
    switch (self.direction) {
        case CSDirectionLeft:
            CGContextDrawLinearGradient(context, gradient, CGPointMake(CGRectGetWidth(rect), 0), CGPointZero, 0);
            break;
        case CSDirectionBottom:
            CGContextDrawLinearGradient(context, gradient, CGPointMake(0, CGRectGetHeight(rect)), CGPointZero, 0);
            break;
        case CSDirectionRight:
            CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(CGRectGetWidth(rect), 0), 0);
            break;
            
        default:
            CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(0, CGRectGetHeight(rect)), 0);
            break;
    }
    
    CGColorSpaceRelease(space);
    CGGradientRelease(gradient);
}

#pragma mark - Setters
- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    
    if (![_queueTopColor isEqual:self.topColor]) {
        _queueTopColor = self.topColor;
        
        [self setNeedsDisplay];
    }
    
    if (![_queueBottomColor isEqual:self.bottomColor]) {
        _queueBottomColor = self.bottomColor;
        
        [self setNeedsDisplay];
    }
}

- (void)setTopColor:(UIColor *)topColor {
    _topColor = topColor;
    
    [self setNeedsDisplay];
}

- (void)setBottomColor:(UIColor *)bottomColor {
    _bottomColor = bottomColor;
    
    [self setNeedsDisplay];
}

#pragma mark - Specific methos

- (void)interpolateBetweenColor:(UIColor *)topColor andColor:(UIColor *)bottomColor withProgression:(CGFloat)progression {
    if (![self.topColor isEqual:topColor] || ![self.bottomColor isEqual:bottomColor]) {
        self.topColor = topColor;
        self.bottomColor = bottomColor;
    }
    
    self.progression = progression;
    
    [self setNeedsDisplay];
}

- (void)animateWidthDuration:(CGFloat)duration delay:(CGFloat)delay completion:(void (^)())completion {
    [self animateWidthDuration:duration delay:delay timingFunction:CSTweenEaseLinear completion:completion];
}

- (void)animateWidthDuration:(CGFloat)duration delay:(CGFloat)delay timingFunction:(CSTweenTimingFunction)timingFunction completion:(void (^)())completion {
    [self clearAnimation];
    
    __block CSGradientIndicatorView *this = self;
    
    self.operation = [[CSTweenOperation alloc] init];
    
    self.operation.startValue = self.progression;
    self.operation.endValue = 1.0f;
    self.operation.duration = duration;
    self.operation.target = self;
    self.operation.timingFunction = timingFunction;
    self.operation.updateSelector = @selector(update:);
    self.operation.completeBlock = ^(BOOL finished){
        if (finished && completion) {
            completion();
            
            [this clearAnimation];
        }
    };
    
    [[CSTween sharedInstance] addTweenOperation:self.operation];
}

- (void)update:(CSTweenOperation *)operation {
    self.progression = operation.value;
    
    [self setNeedsDisplay];
}

- (void)clearAnimation {
    if (nil == self.operation) {
        return;
    }
    
    [[CSTween sharedInstance] removeTweenOperation:self.operation];
    
    self.operation = nil;
}

@end
