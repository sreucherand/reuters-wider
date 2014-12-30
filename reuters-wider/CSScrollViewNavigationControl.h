//
//  CSScrollViewNavigationControl.h
//  reuters-wider
//
//  Created by Sylvain Reucherand on 29/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSScrollViewNavigationControl : UIControl

- (instancetype)initWithPosition:(UINavigationControlPosition)position;

@property (assign, nonatomic) UINavigationControlPosition position;

- (void)setLabelText:(NSString *)text;

- (void)containingScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)containingScrollViewDidEndDragging:(UIScrollView *)scrollView;

@end
