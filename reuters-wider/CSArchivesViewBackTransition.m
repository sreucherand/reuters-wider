//
//  CSArchivesViewBackTransition.m
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 14/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSArchivesViewBackTransition.h"
#import "CSArchivesViewController.h"

@implementation CSArchivesViewBackTransition

- (void)perform {
    CSArchivesViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
    [sourceViewController.view.superview insertSubview:destinationViewController.view belowSubview:sourceViewController.view];
    
    [sourceViewController closeWith:^{
        [sourceViewController dismissViewControllerAnimated:NO completion:nil];
    }];
}

@end
