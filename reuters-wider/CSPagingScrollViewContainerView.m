//
//  CStestView.m
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 06/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import "CSPagingScrollViewContainerView.h"

@implementation CSPagingScrollViewContainerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return [self pointInside:point withEvent:event] ? self.scrollView : nil;
}

@end
