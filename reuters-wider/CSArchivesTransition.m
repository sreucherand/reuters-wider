//
//  CSArchivesTransition.m
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 10/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSArchivesTransition.h"
#import "CSArchivesViewController.h"

@implementation CSArchivesTransition

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    CSArchivesViewController *destinationViewController = self.destinationViewController;
    
    [sourceViewController.view addSubview:destinationViewController.view];
    
    [destinationViewController openWith:^{
        [sourceViewController presentViewController:destinationViewController animated:NO completion:nil];
    }];
}

@end
