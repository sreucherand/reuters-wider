//
//  CSScrollViewNavigationControl.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 29/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSScrollViewNavigationControl.h"

@interface CSScrollViewNavigationControl ()

@property (strong, nonatomic) UILabel *pullLabel;

@end

@implementation CSScrollViewNavigationControl

- (instancetype)initWithPosition:(UINavigationControlPosition)position {
    self = [super init];
    
    if (self) {
        [self setup];
        
        self.position = position;
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame scrollView:(UIScrollView *)scrollView {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setup];
        
        self.scrollView = scrollView;
    }
    
    return self;
}

- (void)initStyle {
    self.backgroundColor = WHITE_COLOR;
}

- (void)setup {
    self.position = UINavigationControlPositionTop;
    
    [self initStyle];
}

- (void)dealloc {
    if (self.allowNightMode) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

#pragma mark - Setters

- (void)setAllowNightMode:(BOOL)allowNightMode {
    _allowNightMode = allowNightMode;
    
    if (_allowNightMode) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readModeNeedsUpdate:) name:@"readModeUpdateNotification" object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (void)setScrollView:(UIScrollView *)scrollView {
    _scrollView = scrollView;
    
    scrollView.bounces = YES;
    
    [self updateFrame];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    if (self.pullLabel == nil) {
        self.pullLabel = [[UILabel alloc] init];
        
        self.pullLabel.textColor = FIRST_PURPLE;
        self.pullLabel.font = CALIBRE_LIGHT_16;
        self.pullLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.pullLabel];
    }
    
    self.pullLabel.frame = (CGRect){.origin=CGPointZero, .size=frame.size};
}

- (void)updateFrame {
    if (self.position == UINavigationControlPositionBottom) {
        self.frame = (CGRect){.origin=CGPointMake(self.frame.origin.x, self.scrollView.contentSize.height), .size=self.frame.size};
    } else {
        self.frame = (CGRect){.origin=CGPointMake(self.frame.origin.x, -CGRectGetHeight(self.frame)), .size=self.frame.size};
    }
}

#pragma mark - Pull Label

- (void)setLabelText:(NSString *)text {
    self.pullLabel.text = text;
}

#pragma mark - Logic

- (void)containingScrollViewDidScroll {
    if (nil == self.scrollView) {
        return;
    }
    
    [self updateFrame];
    
    if (self.position == UINavigationControlPositionBottom && self.scrollView.contentOffset.y > self.scrollView.contentSize.height - CGRectGetHeight(self.scrollView.frame) + CGRectGetHeight(self.frame)) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentSize.height - CGRectGetHeight(self.scrollView.frame) + CGRectGetHeight(self.frame))];
    } else if (self.scrollView.contentOffset.y < -CGRectGetHeight(self.frame)) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, -CGRectGetHeight(self.frame))];
    }
}

- (void)containingScrollViewDidEndDragging {
    if (nil == self.scrollView) {
        return;
    }
    
    if (self.position == UINavigationControlPositionBottom && self.scrollView.contentOffset.y >= self.scrollView.contentSize.height - CGRectGetHeight(self.scrollView.frame) + CGRectGetHeight(self.frame)) {
        [self.scrollView setScrollEnabled:NO];
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentSize.height - CGRectGetHeight(self.scrollView.frame) + CGRectGetHeight(self.frame)) animated:NO];
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    } else if (self.position == UINavigationControlPositionTop && self.scrollView.contentOffset.y <= -CGRectGetHeight(self.frame)) {
        [self.scrollView setScrollEnabled:NO];
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, -CGRectGetHeight(self.frame)) animated:NO];
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

#pragma mark - Switch read mode

- (void)readModeNeedsUpdate:(NSNotification *)sender {
    if ([[sender.userInfo objectForKey:@"mode"] isEqualToString:@"night"]) {
        self.backgroundColor = NIGHT_BLUE;
    } else {
        [self initStyle];
    }
}

@end
