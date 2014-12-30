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
    
    [homeVC.view addSubview:articleVC.view];
    
    [articleVC openWith:^{
        [homeVC.navigationController pushViewController:articleVC animated:NO];
    }];
}

@end
