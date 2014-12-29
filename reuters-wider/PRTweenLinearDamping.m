//  Created by Chris Harding on 06/05/2014.
//  Copyright (c) 2014 Chris Harding. All rights reserved.
//

#import "PRTweenLinearDamping.h"

#define DAMPING_RATIO 0.6
#define NATURAL_FREQUENCY 15.0

CGFloat PRTweenTimingFunctionLinearDamping (CGFloat t, CGFloat b, CGFloat c, CGFloat d)
{
    /*
     Solution obtained from http://mathworld.wolfram.com/DampedSimpleHarmonicMotionOverdamping.html
     
     x(t) = Ae^{\gamma_+ t} + Be^{\gamma_- t}
     
     where ''A'' and ''B'' are determined by the initial conditions of the system:
     
     A = x(0)+\frac{\gamma_+x(0)-\dot{x}(0)}{\gamma_--\gamma_+}
     B = -\frac{\gamma_+x(0)-\dot{x}(0)}{\gamma_--\gamma_+}
     
     For our system, the inital conditions are:
     
     x(0) = -c
     
     After calculating x(t), the return value required is:
     
     b + c + x(t)
     
     Note that duration is ignored - the system is instead determined by its damping ratio and natural frequency.
     
     */
    
    // Input vars (these should be variable)
    CGFloat dampingRatio = DAMPING_RATIO;
    CGFloat naturalFrequency = NATURAL_FREQUENCY;
    
    // Shorthand
    CGFloat w0 = naturalFrequency;
    CGFloat L = dampingRatio;
    
    // Constants
    const CGFloat epsilon = 0.0001;
    
    // Return value
    CGFloat x;
    
    /*
     If dampingRatio >1.0 then the system is over-damped. We do not currently handle this case since its value in an animation is limited.
     */
    if (dampingRatio > 1.0 + epsilon) x = 0;
    
    
    /*
     If dampingRatio == 1.0 then the system is critically damped. A critically damped system converges to zero as fast as possible without oscillating.
     
     Solution for x(t) :
     
     x(t) = (A+Bt)\,e^{-\omega_0 t}
     
     A = x(0)
     B = \dot{x}(0)+\omega_0x(0)
     
     */
    else if (dampingRatio > 1.0 - epsilon) {
        
        CGFloat w0t = w0 * t;
        x = -c * (1 + w0t) * exp(-w0t);
    }
    
    
    /*
     If dampingRatio < 1.0 then the system is under-damped. In this situation, the system will oscillate at the natural damped frequency:
     
     \omega_\mathrm{d} = \omega_0 \sqrt{1 - \zeta^2 }
     
     Solution for x(t) :
     
     x(t) = e^{- \zeta \omega_0 t} (A \cos\,(\omega_\mathrm{d}\,t) + B \sin\,(\omega_\mathrm{d}\,t ))
     
     A = x(0)
     B = \frac{1}{\omega_\mathrm{d}}(\zeta\omega_0x(0)+\dot{x}(0))
     
     */
    else {
        
        
        CGFloat dampedFrequency = w0 * sqrt(1.0 - L*L);
        CGFloat wd = dampedFrequency;
        CGFloat wdt = wd * t;
        
        CGFloat A = -c;
        CGFloat B = (L * w0 * -c) / wd;
        
        x = exp(-L * w0 * t) * (A*cos(wdt) + B*sin(wdt));
        
    }
    
    /*
     To ensure the function ends correctly, we snap it to the final value once it reches a certain threshold.
     */
    if (fabs(x) < epsilon) x = 0.0;
    
    /*
     After calculating x(t), the return value required is: b + c + x(t)
     */
    return b + c + x;
};


