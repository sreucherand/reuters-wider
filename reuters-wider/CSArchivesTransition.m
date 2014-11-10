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
//
//    destinationViewController.topViewLeftConstant.constant = -self.width;
//    destinationViewController.topViewRightConstant.constant = self.width;
//    [destinationViewController.topView layoutIfNeeded];
////    
////    destinationViewController.bottomViewLeftConstant.constant = 50;
////    [destinationViewController.bottomView layoutIfNeeded];
//    
//    [UIView animateWithDuration:1 animations:^{
//        destinationViewController.topViewLeftConstant.constant = 0;
//        destinationViewController.topViewRightConstant.constant = 0;
//        
////        destinationViewController.bottomViewLeftConstant.constant = 0;
////        destinationViewController.bottomViewRightConstant.constant = 0;
//        
//        [destinationViewController.topView layoutIfNeeded];
//        [destinationViewController.bottomView layoutIfNeeded];
//    } completion:^(BOOL finished) {
//        NSLog(@"Coucou");
//    }];
}

@end
