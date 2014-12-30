//
//  CSTweenTimingFunctions.m
//  Tween
//
//  Created by Sylvain Reucherand on 30/12/2014.
//  Copyright (c) 2014 Sylvain Reucherand. All rights reserved.
//

#import "CSTweenTimingFunctions.h"

CGFloat CSTweenEaseLinear (CGFloat time, CGFloat begin, CGFloat change, CGFloat duration) {
    return change * time / duration + begin;
}

CGFloat CSTweenEaseInBack (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    CGFloat s = 1.70158;
    t/=d;
    return c*t*t*((s+1)*t - s) + b;
}
CGFloat CSTweenEaseOutBack (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    CGFloat s = 1.70158;
    t=t/d-1;
    return c*(t*t*((s+1)*t + s) + 1) + b;
}
CGFloat CSTweenEaseInOutBack (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    CGFloat s = 1.70158;
    if ((t/=d/2) < 1) {
        s*=(1.525);
        return c/2*(t*t*((s+1)*t - s)) + b;
    }
    t-=2;
    s*=(1.525);
    return c/2*(t*t*((s+1)*t + s) + 2) + b;
}

CGFloat CSTweenEaseInBounce (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    return c - CSTweenEaseOutBounce(d-t, 0, c, d) + b;
}
CGFloat CSTweenEaseOutBounce (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    if ((t/=d) < (1/2.75)) {
        return c*(7.5625*t*t) + b;
    } else if (t < (2/2.75)) {
        t-=(1.5/2.75);
        return c*(7.5625*t*t + .75) + b;
    } else if (t < (2.5/2.75)) {
        t-=(2.25/2.75);
        return c*(7.5625*t*t + .9375) + b;
    } else {
        t-=(2.625/2.75);
        return c*(7.5625*t*t + .984375) + b;
    }
}
CGFloat CSTweenEaseInOutBounce (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    if (t < d/2) return CSTweenEaseInBounce(t*2, 0, c, d) * .5 + b;
    else return CSTweenEaseInBounce(t*2-d, 0, c, d) * .5 + c*.5 + b;
}

CGFloat CSTweenEaseInCirc (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    t/=d;
    return -c * (sqrt(1 - t*t) - 1) + b;
}
CGFloat CSTweenEaseOutCirc (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    t=t/d-1;
    return c * sqrt(1 - t*t) + b;
}
CGFloat CSTweenEaseInOutCirc (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    if ((t/=d/2) < 1) return -c/2 * (sqrt(1 - t*t) - 1) + b;
    t-=2;
    return c/2 * (sqrt(1 - t*t) + 1) + b;
}

CGFloat CSTweenEaseInCubic (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    t/=d;
    return c*t*t*t + b;
}
CGFloat CSTweenEaseOutCubic (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    t=t/d-1;
    return c*(t*t*t + 1) + b;
}
CGFloat CSTweenEaseInOutCubic (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    if ((t/=d/2) < 1) return c/2*t*t*t + b;
    t-=2;
    return c/2*(t*t*t + 2) + b;
}

CGFloat CSTweenEaseInElastic (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    CGFloat p = d*.3;
    CGFloat s, a = .0;
    if (t==0) return b;  if ((t/=d)==1) return b+c;
    if (!a || a < ABS(c)) { a=c; s=p/4; }
    else s = p/(2*M_PI) * asin (c/a);
    t-=1;
    return -(a*pow(2,10*t) * sin( (t*d-s)*(2*M_PI)/p )) + b;
}
CGFloat CSTweenEaseOutElastic (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    CGFloat p = d*.3;
    CGFloat s, a = .0;
    if (t==0) return b;  if ((t/=d)==1) return b+c;
    if (!a || a < ABS(c)) { a=c; s=p/4; }
    else s = p/(2*M_PI) * asin (c/a);
    return (a*pow(2,-10*t) * sin( (t*d-s)*(2*M_PI)/p ) + c + b);
}
CGFloat CSTweenEaseInOutElastic (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    CGFloat p = d*(.3*1.5);
    CGFloat s, a = .0;
    if (t==0) return b;  if ((t/=d/2)==2) return b+c;
    if (!a || a < ABS(c)) { a=c; s=p/4; }
    else s = p/(2*M_PI) * asin (c/a);
    if (t < 1) {
        t-=1;
        return -.5*(a*pow(2,10*t) * sin( (t*d-s)*(2*M_PI)/p )) + b;
    }
    t-=1;
    return a*pow(2,-10*t) * sin( (t*d-s)*(2*M_PI)/p )*.5 + c + b;
}

CGFloat CSTweenEaseInExpo (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    return (t==0) ? b : c * pow(2, 10 * (t/d - 1)) + b;
}
CGFloat CSTweenEaseOutExpo (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    return (t==d) ? b+c : c * (-pow(2, -10 * t/d) + 1) + b;
}
CGFloat CSTweenEaseInOutExpo (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    if (t==0) return b;
    if (t==d) return b+c;
    if ((t/=d/2) < 1) return c/2 * pow(2, 10 * (t - 1)) + b;
    return c/2 * (-pow(2, -10 * --t) + 2) + b;
}

CGFloat CSTweenEaseInQuad (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    t/=d;
    return c*t*t + b;
}
CGFloat CSTweenEaseOutQuad (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    t/=d;
    return -c *t*(t-2) + b;
}
CGFloat CSTweenEaseInOutQuad (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    if ((t/=d/2) < 1) return c/2*t*t + b;
    t--;
    return -c/2 * (t*(t-2) - 1) + b;
}

CGFloat CSTweenEaseInQuart (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    t/=d;
    return c*t*t*t*t + b;
}
CGFloat CSTweenEaseOutQuart (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    t=t/d-1;
    return -c * (t*t*t*t - 1) + b;
}
CGFloat CSTweenEaseInOutQuart (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    if ((t/=d/2) < 1) return c/2*t*t*t*t + b;
    t-=2;
    return -c/2 * (t*t*t*t - 2) + b;
}

CGFloat CSTweenEaseInQuint (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    t/=d;
    return c*t*t*t*t*t + b;
}
CGFloat CSTweenEaseOutQuint (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    t=t/d-1;
    return c*(t*t*t*t*t + 1) + b;
}
CGFloat CSTweenEaseInOutQuint (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    if ((t/=d/2) < 1) return c/2*t*t*t*t*t + b;
    t-=2;
    return c/2*(t*t*t*t*t + 2) + b;
}

CGFloat CSTweenEaseInSine (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    return -c * cos(t/d * (M_PI/2)) + c + b;
}
CGFloat CSTweenEaseOutSine (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    return c * sin(t/d * (M_PI/2)) + b;
}
CGFloat CSTweenEaseInOutSine (CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    return -c/2 * (cos(M_PI*t/d) - 1) + b;
}
