//
//  CSGradientIndicatorView.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 23/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSGradientIndicatorView.h"

@interface CSGradientIndicatorView ()

@property (strong, nonatomic) NSTimer *timer;

@property (assign, nonatomic) CGFloat progression;
@property (assign, nonatomic) CGFloat startTime;
@property (assign, nonatomic) CGFloat startValue;
@property (assign, nonatomic) CGFloat endValue;
@property (assign, nonatomic) CGFloat delay;
@property (assign, nonatomic) CGFloat duration;

@property (copy)void (^doStuff)(void);

@end

@implementation CSGradientIndicatorView

- (void)awakeFromNib {
    self.topColor = [UIColor blackColor];
    self.bottomColor = [UIColor blackColor];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGFloat locations[4];
    
    locations[0] = 0;
    locations[1] = self.progression;
    locations[2] = self.progression;
    locations[3] = 1;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    
    NSMutableArray *colors = [[NSMutableArray alloc] initWithCapacity:4];
    
    [colors addObject:(id)[self.bottomColor CGColor]];
    [colors addObject:(id)[self.bottomColor colorWithAlphaComponent:0].CGColor];
    [colors addObject:(id)self.topColor.CGColor];
    [colors addObject:(id)[self.topColor colorWithAlphaComponent:0].CGColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(space, (CFArrayRef)colors, locations);
    
    CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(0, CGRectGetHeight(self.bounds)), 0);
    
    CGColorSpaceRelease(space);
}

- (void)interpolateBetweenColor:(UIColor *)topColor andColor:(UIColor *)bottomColor withProgression:(CGFloat)progression {
    if (![self.topColor isEqual:topColor] || ![self.bottomColor isEqual:bottomColor]) {
        self.topColor = topColor;
        self.bottomColor = bottomColor;
    }
    
    self.progression = progression;
    
    [self setNeedsDisplay];
}

- (void)animateWidthDuration:(CGFloat)duration delay:(CGFloat)delay completion:(void (^)())completion {
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1/6
                                                      target:self
                                                    selector:@selector(updateAnimation)
                                                    userInfo:nil
                                                     repeats:YES];
        
        self.delay = delay;
        self.duration = duration;
        self.startTime = CACurrentMediaTime();
        self.startValue = self.progression;
        self.endValue = 1.0;
        self.doStuff = completion;
    }
}

- (void)updateAnimation {
    CGFloat currentTime = CACurrentMediaTime();
    
    if (currentTime > self.startTime+self.delay+self.duration) {
        if (self.doStuff != nil) {
            self.doStuff();
        }
        
        [self clearAnimation];
        
        return;
    }
    
    self.progression = PRTweenTimingFunctionLinear(currentTime - self.delay - self.startTime, self.startValue, self.endValue - self.startValue, self.duration);
    
    [self setNeedsDisplay];
}

- (void)clearAnimation {
    [self.timer invalidate];
    self.timer = nil;
}

@end
