//
//  CSHomeArticleTransition.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 28/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSHomeArticleTransition.h"
#import "CSArticlePartViewController.h"

@implementation CSHomeArticleTransition

- (void)perform {
    UIViewController *homeVC = self.sourceViewController;
    CSArticlePartViewController *articleVC = self.destinationViewController;
    
    articleVC.view.frame = CGRectOffset(articleVC.view.frame, 0, CGRectGetHeight(articleVC.view.frame));
    
    [homeVC.view addSubview:articleVC.view];
    
    [PRTween tween:0 from:CGRectGetMinY(articleVC.view.frame) to:0 duration:1.4 delay:0 timingFunction:PRTweenTimingFunctionExpoInOut updateBlock:^(PRTweenPeriod *period) {
        articleVC.view.frame = (CGRect){.origin=CGPointMake(articleVC.view.frame.origin.x, period.tweenedValue), .size=articleVC.view.frame.size};
    } completeBlock:^(BOOL finished) {
        if (finished) {
            [articleVC colorizeHeaderGradientIndicator];
            
            [homeVC.navigationController pushViewController:articleVC animated:NO];
        }
    }];
}

@end
