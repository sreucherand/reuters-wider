//
//  CSArticleHomeTransition.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 30/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSArticleHomeTransition.h"
#import "CSArticlePartViewController.h"

@implementation CSArticleHomeTransition

- (void)perform {
    CSArticlePartViewController *articleVC = self.sourceViewController;
    UIViewController *homeVC = self.destinationViewController;
    
    [articleVC.view.superview insertSubview:homeVC.view belowSubview:articleVC.view];
    
    [articleVC closeWith:^{
        [articleVC.navigationController popToViewController:homeVC animated:NO];
    }];
}

@end
