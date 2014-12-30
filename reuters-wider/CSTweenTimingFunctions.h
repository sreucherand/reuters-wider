//
//  CSTweenTimingFunctions.h
//  Tween
//
//  Created by Sylvain Reucherand on 30/12/2014.
//  Copyright (c) 2014 Sylvain Reucherand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

CGFloat CSTweenEaseLinear (CGFloat, CGFloat, CGFloat, CGFloat);

CGFloat CSTweenEaseInBack (CGFloat, CGFloat, CGFloat, CGFloat);
CGFloat CSTweenEaseOutBack (CGFloat, CGFloat, CGFloat, CGFloat);
CGFloat CSTweenEaseInOutBack (CGFloat, CGFloat, CGFloat, CGFloat);

CGFloat CSTweenEaseInBounce (CGFloat, CGFloat, CGFloat, CGFloat);
CGFloat CSTweenEaseOutBounce (CGFloat, CGFloat, CGFloat, CGFloat);
CGFloat CSTweenEaseInOutBounce (CGFloat, CGFloat, CGFloat, CGFloat);

CGFloat CSTweenEaseInCirc (CGFloat, CGFloat, CGFloat, CGFloat);
CGFloat CSTweenEaseOutCirc (CGFloat, CGFloat, CGFloat, CGFloat);
CGFloat CSTweenEaseInOutCirc (CGFloat, CGFloat, CGFloat, CGFloat);

CGFloat CSTweenEaseInCubic (CGFloat, CGFloat, CGFloat, CGFloat);
CGFloat CSTweenEaseOutCubic (CGFloat, CGFloat, CGFloat, CGFloat);
CGFloat CSTweenEaseInOutCubic (CGFloat, CGFloat, CGFloat, CGFloat);

CGFloat CSTweenEaseInElastic (CGFloat, CGFloat, CGFloat, CGFloat);
CGFloat CSTweenEaseOutElastic (CGFloat, CGFloat, CGFloat, CGFloat);
CGFloat CSTweenEaseInOutElastic (CGFloat, CGFloat, CGFloat, CGFloat);

CGFloat CSTweenEaseInExpo (CGFloat, CGFloat, CGFloat, CGFloat);
CGFloat CSTweenEaseOutExpo (CGFloat, CGFloat, CGFloat, CGFloat);
CGFloat CSTweenEaseInOutExpo (CGFloat, CGFloat, CGFloat, CGFloat);

CGFloat CSTweenEaseInQuad (CGFloat, CGFloat, CGFloat, CGFloat);
CGFloat CSTweenEaseOutQuad (CGFloat, CGFloat, CGFloat, CGFloat);
CGFloat CSTweenEaseInOutQuad (CGFloat, CGFloat, CGFloat, CGFloat);

CGFloat CSTweenEaseInQuart (CGFloat, CGFloat, CGFloat, CGFloat);
CGFloat CSTweenEaseOutQuart (CGFloat, CGFloat, CGFloat, CGFloat);
CGFloat CSTweenEaseInOutQuart (CGFloat, CGFloat, CGFloat, CGFloat);

CGFloat CSTweenEaseInQuint (CGFloat, CGFloat, CGFloat, CGFloat);
CGFloat CSTweenEaseOutQuint (CGFloat, CGFloat, CGFloat, CGFloat);
CGFloat CSTweenEaseInOutQuint (CGFloat, CGFloat, CGFloat, CGFloat);

CGFloat CSTweenEaseInSine (CGFloat, CGFloat, CGFloat, CGFloat);
CGFloat CSTweenEaseOutSine (CGFloat, CGFloat, CGFloat, CGFloat);
CGFloat CSTweenEaseInOutSine (CGFloat, CGFloat, CGFloat, CGFloat);

CGFloat (*CSTweenEaseCACustom(CAMediaTimingFunction *timingFunction))(CGFloat, CGFloat, CGFloat, CGFloat);
