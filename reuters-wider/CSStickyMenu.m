//
//  CSStickyMenu.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 30/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSStickyMenu.h"

@interface CSStickyMenu () {
    BOOL _visible;
    BOOL _enabled;
}

@property (weak, nonatomic) IBOutlet UIButton *backToTopButton;
@property (weak, nonatomic) IBOutlet UIButton *nightModeButton;

@property (strong, nonatomic) CALayer *bottomBorderLayer;
@property (strong, nonatomic) CSTweenOperation *operation;

@end

@implementation CSStickyMenu

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readModeNeedsUpdate:) name:@"readModeUpdateNotification" object:nil];
        
        self.hidden = YES;
        
        _visible = NO;
        _enabled = YES;
        
        self.bottomBorderLayer = [CALayer layer];
        
        [self.layer addSublayer:self.bottomBorderLayer];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = WHITE_COLOR;
    
    [self.titleButton setTitleColor:FIRST_PURPLE forState:UIControlStateNormal];
    
    self.titleButton.titleLabel.font = CALIBRE_LIGHT_16;
    self.titleButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.bottomBorderLayer.backgroundColor = LIGHT_DIMMED_GREY.CGColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bottomBorderLayer.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 1, CGRectGetWidth(self.frame), 1);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Setters

- (void)setScrollView:(UIScrollView *)scrollView {
    _scrollView = scrollView;
    
    [_scrollView layoutIfNeeded];
    
    self.frame = CGRectMake(0, -CGRectGetHeight(self.frame), CGRectGetWidth(scrollView.frame), CGRectGetHeight(self.frame));
}

#pragma mark - Specific methods

- (void)enable {
    _enabled = YES;
}

- (void)disable {
    [self close];
    
    _enabled = NO;
}

- (void)open {
    if (!_enabled) {
        return;
    }
    
    if (!_visible) {
        if (self.scrollView.contentOffset.y < CGRectGetHeight(self.frame)) {
            return;
        }
        
        self.hidden = NO;
        
        _visible = YES;
        
        if (self.operation) {
            [[CSTween sharedInstance] removeTweenOperation:self.operation];
            
            [self clearAnimation];
        }
        
        self.operation = [[CSTweenOperation alloc] init];
        
        self.operation.startValue = CGRectGetMinY(self.frame);
        self.operation.endValue = 0;
        self.operation.duration = 0.2;
        self.operation.target = self;
        self.operation.updateSelector = @selector(updateFrame:);
        self.operation.completeSelector = @selector(clearAnimation);
        
        [[CSTween sharedInstance] addTweenOperation:self.operation];
    }
}

- (void)toggle {
    if (!_enabled) {
        return;
    }
    
    if (_visible) {
        [self close];
    } else {
        [self open];
    }
}

- (void)close {
    if (!_enabled) {
        return;
    }
    
    if (_visible) {
        _visible = NO;
        
        if (self.operation) {
            [[CSTween sharedInstance] removeTweenOperation:self.operation];
            
            [self clearAnimation];
        }
        
        self.operation = [[CSTweenOperation alloc] init];
        
        self.operation.startValue = CGRectGetMinY(self.frame);
        self.operation.endValue = -CGRectGetHeight(self.frame);
        self.operation.duration = 0.2;
        self.operation.target = self;
        self.operation.updateSelector = @selector(updateFrame:);
        self.operation.completeSelector = @selector(clearAnimation);
        
        [[CSTween sharedInstance] addTweenOperation:self.operation];
    }
}

- (void)updateFrame:(CSTweenOperation *)operation {
    self.frame = (CGRect){.origin=CGPointMake(self.frame.origin.x, operation.value), .size=self.frame.size};
}

- (void)clearAnimation {
    self.operation = nil;
    
    if (!_visible) {
        self.hidden = YES;
    }
}

#pragma mark - Switch read mode

- (void)readModeNeedsUpdate:(NSNotification *)sender {
    if ([[sender.userInfo objectForKey:@"mode"] isEqualToString:@"night"]) {
        self.backgroundColor = THIRD_PURPLE;
        
        self.bottomBorderLayer.backgroundColor = FIRST_PURPLE.CGColor;
    } else {
        [self awakeFromNib];
    }
}

#pragma mark - Events

- (IBAction)backToTopButtonDidPress:(id)sender {
    if ([self.delegate respondsToSelector:@selector(backToTopButtonDidPress)]) {
        [self.delegate performSelector:@selector(backToTopButtonDidPress)];
    }
}

- (IBAction)titleButtonDidPress:(id)sender {
    if ([self.delegate respondsToSelector:@selector(titleButtonDidPress)]) {
        [self.delegate performSelector:@selector(titleButtonDidPress)];
    }
}

- (IBAction)nightModeButtonDidPress:(id)sender {
    if ([self.delegate respondsToSelector:@selector(nightModeButtonDidPress)]) {
        [self.delegate performSelector:@selector(nightModeButtonDidPress)];
    }
}

@end
