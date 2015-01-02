//
//  CSAbstractInteractiveTransition.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 01/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import "CSAbstractInteractiveTransition.h"

@implementation CSAbstractInteractiveTransition

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _interactive = NO;
    }
    
    return self;
}

#pragma mark - Transitioning delegate

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    _presenting = YES;
    
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _presenting = NO;
    
    return self;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    return _interactive ? self : nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return _interactive ? self : nil;
}

@end
