//
//  CSArticleSummaryTransition.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 01/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import "CSArticleSummaryTransition.h"

@interface CSArticleSummaryTransition () {
    BOOL _interactive;
    BOOL _presenting;
}

@end

@implementation CSArticleSummaryTransition

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _interactive = NO;
    }
    
    return self;
}

#pragma mark - Setters

- (void)setSourceViewController:(UIViewController *)sourceViewController {
    _sourceViewController = sourceViewController;
    
    UIScreenEdgePanGestureRecognizer *gestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(didRightPan:)];
    
    gestureRecognizer.edges = UIRectEdgeRight;
    
    [self.sourceViewController.view addGestureRecognizer:gestureRecognizer];
}

- (void)setDestinationViewController:(UIViewController *)destinationViewController {
    _destinationViewController = destinationViewController;
    
    UIScreenEdgePanGestureRecognizer *gestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(didLeftPan:)];
    
    gestureRecognizer.edges = UIRectEdgeLeft;
    
    [self.destinationViewController.view addGestureRecognizer:gestureRecognizer];
}

#pragma marks - Gesture handler

- (void)didLeftPan:(UIScreenEdgePanGestureRecognizer *)recognizer {
    CGPoint velocity = [recognizer velocityInView:recognizer.view];
    
    velocity.x *= -1;
    
    [self performTransitionFromGestureRecognizer:recognizer velocity:velocity];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self.sourceViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didRightPan:(UIScreenEdgePanGestureRecognizer *)recognizer {
    [self performTransitionFromGestureRecognizer:recognizer velocity:[recognizer velocityInView:recognizer.view]];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self.sourceViewController performSegueWithIdentifier:@"presentHomeToGlossarySegueID" sender:self];
    }
}

- (void)performTransitionFromGestureRecognizer:(UIScreenEdgePanGestureRecognizer *)recognizer velocity:(CGPoint)velocity {
    CGPoint translation = [recognizer translationInView:recognizer.view];
    CGFloat offset =  fabs(translation.x/CGRectGetWidth(recognizer.view.bounds)*0.75);
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            _interactive = YES;
            break;
            
        case UIGestureRecognizerStateChanged:
            [self updateInteractiveTransition:offset];
            break;
            
        default:
            _interactive = NO;
            
            if (velocity.x > 0 || recognizer.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
    }
}

#pragma mark - Transitioning delegate

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *sourceViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *destinationViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect frame = [transitionContext initialFrameForViewController:sourceViewController];
    
    [[transitionContext containerView] addSubview:destinationViewController.view];
    
    if (_presenting) {
        destinationViewController.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(frame), 0);
    } else {
        destinationViewController.view.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(frame), 0);
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        if (_presenting) {
            sourceViewController.view.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(frame), 0);
        } else {
            sourceViewController.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(frame), 0);
        }
        
        destinationViewController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

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
