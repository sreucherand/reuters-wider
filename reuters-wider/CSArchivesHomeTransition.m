//
//  CSArchivesViewBackTransition.m
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 14/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSArchivesHomeTransition.h"
#import "CSArchivesViewController.h"

@implementation CSArchivesHomeTransition

- (void)perform {
    CSArchivesViewController *archivesVC = self.sourceViewController;
    UIViewController *homeVC = self.destinationViewController;
    
    homeVC.view.userInteractionEnabled = NO;
    archivesVC.view.userInteractionEnabled = NO;
    
    [archivesVC.view.superview insertSubview:homeVC.view belowSubview:archivesVC.view];
    
    [archivesVC closeWith:^{
        [archivesVC dismissViewControllerAnimated:NO completion:nil];
        
        homeVC.view.userInteractionEnabled = YES;
        archivesVC.view.userInteractionEnabled = YES;
    }];
}

@end
