//
//  CSSummaryGlossaryTransition.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 01/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import "CSSummaryGlossaryTransition.h"
#import "CSSummaryViewController.h"

@implementation CSSummaryGlossaryTransition

#pragma marks - Gesture handler

- (void)didPanFromSourceViewControllerTransition:(UIPanGestureRecognizer *)recognizer {
    CGPoint velocity = [recognizer velocityInView:recognizer.view];
    
    velocity.y *= -1;
    
    [self performTransitionFromGestureRecognizer:recognizer velocity:velocity];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self.sourceViewController performSegueWithIdentifier:@"presentSummaryToGlossarySegueID" sender:nil];
    }
}

- (void)didTapFromSourceViewControllerTransition:(UITapGestureRecognizer *)recognizer {
    [self.sourceViewController performSegueWithIdentifier:@"presentSummaryToGlossarySegueID" sender:self];
}

- (void)didPanFromDestinationViewControllerTransition:(UIPanGestureRecognizer *)recognizer {
    [self performTransitionFromGestureRecognizer:recognizer velocity:[recognizer velocityInView:nil]];

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self.sourceViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didTapFromDestinationViewControllerTransition:(UITapGestureRecognizer *)recognizer {
    [self.sourceViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)performTransitionFromGestureRecognizer:(UIPanGestureRecognizer *)recognizer velocity:(CGPoint)velocity {
    CGPoint translation = [recognizer translationInView:nil];
    CGFloat offset = fabs(translation.y/CGRectGetHeight(self.sourceViewController.view.frame)*0.75);
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            _interactive = YES;
            break;
            
        case UIGestureRecognizerStateChanged:
            [self updateInteractiveTransition:offset];
            break;
            
        default:
            _interactive = NO;
            
            if (velocity.y < 0 || recognizer.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
    }
}

#pragma mark - Transitioning delegate

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *sourceViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *destinationViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect frame = [transitionContext initialFrameForViewController:sourceViewController];
    
    UIImage *image = [((CSSummaryViewController *)self.sourceViewController) glossaryToggleViewRenderImage];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), image.size.height)];
    
    imageView.image = image;
    
    if (_presenting) {
        destinationViewController.view.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(frame));
        imageView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(frame)-image.size.height);
        
        [[transitionContext containerView] addSubview:destinationViewController.view];
        [[transitionContext containerView] addSubview:imageView];
    } else {
        [[transitionContext containerView] insertSubview:destinationViewController.view belowSubview:sourceViewController.view];
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        if (_presenting) {
            destinationViewController.view.transform = CGAffineTransformIdentity;
            imageView.transform = CGAffineTransformMakeTranslation(0, -image.size.height);
        } else {
            sourceViewController.view.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(frame));
        }
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
