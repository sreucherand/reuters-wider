//
//  CSSummaryGlossaryTransition.h
//  reuters-wider
//
//  Created by Sylvain Reucherand on 01/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CSAbstractInteractiveTransition.h"

@interface CSSummaryGlossaryTransition : CSAbstractInteractiveTransition

- (void)didPanFromSourceViewControllerTransition:(UIPanGestureRecognizer *)recognizer;
- (void)didTapFromSourceViewControllerTransition:(UITapGestureRecognizer *)recognizer;

- (void)didPanFromDestinationViewControllerTransition:(UIPanGestureRecognizer *)recognizer;
- (void)didTapFromDestinationViewControllerTransition:(UITapGestureRecognizer *)recognizer;

@end
