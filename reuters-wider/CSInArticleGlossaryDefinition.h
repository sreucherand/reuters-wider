//
//  CSTestDefinition.h
//  reuters-wider
//
//  Created by Sylvain Reucherand on 14/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CSAttributedLabel.h"
#import "CSGradientIndicatorView.h"

@interface CSInArticleGlossaryDefinition : UIView

@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *gradientIndicatorView;

- (void)setFrameForPoint:(CGPoint)point;
- (void)hydrateWithTitle:(NSString *)title andText:(NSString *)text;

@end
