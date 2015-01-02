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
@property (weak, nonatomic) IBOutlet UILabel *glossaryToggleViewLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *glossaryToggleViewLabelConstraint;

@property (strong, nonatomic) CSSummaryGlossaryTransition *transition;

@end

@implementation CSSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.transition = [[CSSummaryGlossaryTransition alloc] init];
    self.transition.sourceViewController = self;
    
    self.glossaryToggleView.backgroundColor = WHITE_COLOR;
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanOnGlossaryToggleBottomView:)];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnGlossaryToggleBottomView:)];
    
    [self.glossaryToggleView addGestureRecognizer:tapGestureRecognizer];
    [self.glossaryToggleView addGestureRecognizer:panGestureRecognizer];
    
    self.glossaryToggleViewLabel.font = CALIBRE_LIGHT_17;
    self.glossaryToggleViewLabel.textColor = DARK_GREY_TOGGLE_COLOR;
    
    CALayer *topBorder = [CALayer layer];
    
    topBorder.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 1);
    topBorder.backgroundColor = LIGHT_GREY_BORDER_COLOR.CGColor;
    
    [self.glossaryToggleView.layer addSublayer:topBorder];
    
    [self.glossaryToggleViewLabel setNeedsLayout];
    [self.glossaryToggleViewLabel layoutIfNeeded];
    
    self.glossaryToggleViewLabelConstraint.constant =(CGRectGetWidth(self.glossaryToggleViewLabel.frame) + 27)/2;
}

#pragma mark - Specific methods

- (UIImage *)glossaryToggleViewRenderImage {
    UIGraphicsBeginImageContextWithOptions(self.glossaryToggleView.frame.size, YES, 0.0f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.glossaryToggleView.layer renderInContext:context];
    
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return snapshot;
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
