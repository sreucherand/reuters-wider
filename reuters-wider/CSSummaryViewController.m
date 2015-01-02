//
//  CSSummaryViewController.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 01/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import "CSSummaryViewController.h"
#import "CSSummaryGlossaryTransition.h"

@interface CSSummaryViewController ()

@property (strong, nonatomic) IBOutlet UIView *glossaryToggleView;

@property (strong, nonatomic) CSSummaryGlossaryTransition *transition;

@end

@implementation CSSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.transition = [[CSSummaryGlossaryTransition alloc] init];
    self.transition.sourceViewController = self;
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanOnGlossaryToggleBottomView:)];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnGlossaryToggleBottomView:)];
    
    [self.glossaryToggleView addGestureRecognizer:tapGestureRecognizer];
    [self.glossaryToggleView addGestureRecognizer:panGestureRecognizer];
}

#pragma mark - Gesture

- (void)didPanOnGlossaryToggleBottomView:(UIPanGestureRecognizer *)recognizer {
    [self.transition didPanFromSourceViewControllerTransition:recognizer];
}

- (void)didTapOnGlossaryToggleBottomView:(UITapGestureRecognizer *)recognizer {
    [self.transition didTapFromSourceViewControllerTransition:recognizer];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destinationViewController = segue.destinationViewController;
    
    self.transition.destinationViewController = destinationViewController;
    
    destinationViewController.transitioningDelegate = self.transition;
}

@end
