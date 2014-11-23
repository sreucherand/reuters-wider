//
//  CSArchivesTransition.m
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 10/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSHomeArchivesTransition.h"
#import "CSArchivesViewController.h"

@implementation CSHomeArchivesTransition

- (void)perform {
    UIViewController *homeVC = self.sourceViewController;
    CSArchivesViewController *archivesVC = self.destinationViewController;
    
    [homeVC.view addSubview:archivesVC.view];
    
    [archivesVC openWith:^{
        [homeVC presentViewController:archivesVC animated:NO completion:nil];
    }];
}

@end
