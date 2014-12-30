//
//  CSIssuesPreviewPictureCollectionViewCell.m
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 26/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSIssuesPreviewPictureViewCell.h"
#import "CSScrollViewNavigationControl.h"

@interface CSIssuesPreviewPictureViewCell () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) CSScrollViewNavigationControl *bottomNavigationControl;

@end

@implementation CSIssuesPreviewPictureViewCell

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.clipsToBounds = NO;
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        self.pictureImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        self.scrollView.backgroundColor = WHITE_COLOR;
        self.scrollView.alwaysBounceVertical = YES;
        self.scrollView.delegate = self;
        self.scrollView.clipsToBounds = NO;
        
        [self addSubview:self.scrollView];
        
        [self.scrollView addSubview:self.pictureImageView];
        
        self.bottomNavigationControl = [[CSScrollViewNavigationControl alloc] initWithPosition:UINavigationControlPositionBottom];
        
        [self.bottomNavigationControl setScrollView:self.scrollView];
        [self.bottomNavigationControl setLabelText:@"Read"];
        [self.bottomNavigationControl addTarget:self action:@selector(scrollViewDidPullForTransition) forControlEvents:UIControlEventValueChanged];
        
        [self.scrollView addSubview:self.bottomNavigationControl];
    }
    
    return self;
}

- (void)layoutSubviews {
    self.scrollView.frame = (CGRect){.origin=CGPointZero, .size=self.frame.size};
    self.scrollView.contentSize = self.frame.size;
    
    self.pictureImageView.frame = (CGRect){.origin=CGPointZero, .size=self.frame.size};
    
    self.bottomNavigationControl.frame = CGRectMake(0, CGRectGetHeight(self.scrollView.frame), CGRectGetWidth(self.frame), 60);
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [self.bottomNavigationControl containingScrollViewDidEndDragging];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 0)];
    }
    
    [self.bottomNavigationControl containingScrollViewDidScroll];
    
    if ([self.delegate respondsToSelector:@selector(didPictureScroll:)]) {
        [self.delegate performSelector:@selector(didPictureScroll:) withObject:[NSNumber numberWithFloat:scrollView.contentOffset.y/CGRectGetHeight(self.bottomNavigationControl.frame)]];
    }
}

- (void)scrollViewDidPullForTransition {
    CGFloat totalHeight = CGRectGetHeight(self.superview.superview.frame);
    CGFloat startValue = totalHeight - CGRectGetWidth(self.frame) - CGRectGetHeight(self.bottomNavigationControl.frame);
    CGFloat endValue = startValue - totalHeight;
    
    CGRect rect = (CGRect){.origin=CGPointZero, .size=CGSizeMake(CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame) + CGRectGetHeight(self.bottomNavigationControl.frame))};
    
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.scrollView.layer renderInContext:context];
    
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageView *transitionView = [[UIImageView alloc] initWithFrame:(CGRect){.origin=CGPointMake(0, startValue), .size=rect.size}];
    
    transitionView.image = snapshot;
    
    [self.superview.superview addSubview:transitionView];
    
    [self.scrollView setOpaque:YES];
    
    [CSTween tweenFrom:startValue to:endValue duration:1.4 timingFunction:CSTweenEaseInOutExpo updateBlock:^(CSTweenOperation *operation) {
        transitionView.frame = (CGRect){.origin=CGPointMake(0, operation.value), .size=transitionView.frame.size};
    } completeBlock:^(BOOL finished) {
        if (finished) {
            [transitionView removeFromSuperview];
            
            [self.scrollView setScrollEnabled:YES];
            [self.scrollView setOpaque:NO];
        }
    }];
    
    if ([self.delegate respondsToSelector:@selector(didReleasePicture:)]) {
        [self.delegate performSelector:@selector(didReleasePicture:) withObject:[NSNumber numberWithFloat:1.0f]];
    }
}

@end
