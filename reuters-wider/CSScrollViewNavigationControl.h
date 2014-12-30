//
//  CSScrollViewNavigationControl.h
//  reuters-wider
//
//  Created by Sylvain Reucherand on 29/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSScrollViewNavigationControl : UIControl

- (instancetype)initWithFrame:(CGRect)frame scrollView:(UIScrollView *)scrollView;
- (instancetype)initWithPosition:(UINavigationControlPosition)position;

@property (retain, nonatomic) UIScrollView *scrollView;

@property (assign, nonatomic) UINavigationControlPosition position;

- (void)setLabelText:(NSString *)text;

- (void)containingScrollViewDidScroll;
- (void)containingScrollViewDidEndDragging;

@end
