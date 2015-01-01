//
//  CSArticleSummaryTransition.h
//  reuters-wider
//
//  Created by Sylvain Reucherand on 01/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSArticleSummaryTransition : UIPercentDrivenInteractiveTransition<UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) UIViewController *sourceViewController;
@property (strong, nonatomic) UIViewController *destinationViewController;

@end
