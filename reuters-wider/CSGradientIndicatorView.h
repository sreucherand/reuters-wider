//
//  CSGradientIndicatorView.h
//  reuters-wider
//
//  Created by Sylvain Reucherand on 23/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSGradientIndicatorView : UIView

@property (strong, nonatomic) UIColor *topColor;
@property (strong, nonatomic) UIColor *bottomColor;

- (void)interpolateBetweenColor:(UIColor *)topColor andColor:(UIColor *)bottomColor withProgression:(CGFloat)progression;
- (void)animateWidthDuration:(CGFloat)duration delay:(CGFloat)delay completion:(void(^)())completion;
- (void)clearAnimation;

@end
