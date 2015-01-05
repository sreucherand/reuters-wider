//
//  CSStickyMenu.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 30/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSStickyMenu.h"

@interface CSStickyMenu () {
    BOOL visible;
}

@property (strong, nonatomic) CSTweenOperation *operation;

@end

@implementation CSStickyMenu

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.hidden = YES;
    
    visible = NO;
    
    self.backgroundColor = WHITE_COLOR;
    
    [self.titleButton setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    
    self.titleButton.titleLabel.font = CALIBRE_REG_15;
    self.titleButton.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setScrollView:(UIScrollView *)scrollView {
    _scrollView = scrollView;
    
    [_scrollView layoutIfNeeded];
    
    self.frame = CGRectMake(0, -CGRectGetHeight(self.frame), CGRectGetWidth(scrollView.frame), CGRectGetHeight(self.frame));
}

- (void)open {
    if (!visible) {
        if (self.scrollView.contentOffset.y < CGRectGetHeight(self.frame)) {
            return;
        }
        
        self.hidden = NO;
        
        visible = YES;
        
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

- (void)containingScrollViewDidScroll {
    if (visible) {
        visible = NO;
        
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
    
    if (!visible) {
        self.hidden = YES;
    }
}

#pragma mark - Events

- (IBAction)titleButtonDidPress:(id)sender {
    if ([self.delegate respondsToSelector:@selector(titleButtonDidPress)]) {
        [self.delegate performSelector:@selector(titleButtonDidPress)];
    }
}

- (IBAction)backToTopButtonDidPress:(id)sender {
    if ([self.delegate respondsToSelector:@selector(backToTopButtonDidPress)]) {
        [self.delegate performSelector:@selector(backToTopButtonDidPress)];
    }
}

@end
