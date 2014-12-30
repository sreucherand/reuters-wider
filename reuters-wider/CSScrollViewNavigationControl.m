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

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.position = UINavigationControlPositionTop;
    }
    
    return self;
}

- (instancetype)initWithPosition:(UINavigationControlPosition)position {
    self = [super init];
    
    if (self) {
        self.position = position;
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    if (self.pullLabel == nil) {
        self.pullLabel = [[UILabel alloc] init];
        
        self.pullLabel.textColor = BLUE_COLOR;
        self.pullLabel.font = CALIBRE_REG_15;
        self.pullLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.pullLabel];
    }
    
    self.pullLabel.frame = (CGRect){.origin=CGPointZero, .size=frame.size};
}

#pragma mark - Pull Label

- (void)setLabelText:(NSString *)text {
    self.pullLabel.text = text;
}

#pragma mark - Logic

- (void)containingScrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.position == UINavigationControlPositionBottom && scrollView.contentOffset.y > scrollView.contentSize.height + CGRectGetHeight(self.frame)) {
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, scrollView.contentSize.height + CGRectGetHeight(self.frame))];
    } else if (scrollView.contentOffset.y < -CGRectGetHeight(self.frame)) {
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, -CGRectGetHeight(self.frame))];
    }
}

- (void)containingScrollViewDidEndDragging:(UIScrollView *)scrollView {
    if (self.position == UINavigationControlPositionBottom && scrollView.contentOffset.y >= scrollView.contentSize.height + CGRectGetHeight(self.frame)) {
        [scrollView setScrollEnabled:NO];
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, scrollView.contentSize.height + CGRectGetHeight(self.frame)) animated:NO];
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    } else if (scrollView.contentOffset.y <= -CGRectGetHeight(self.frame)) {
        [scrollView setScrollEnabled:NO];
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, -CGRectGetHeight(self.frame)) animated:NO];
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

@end
