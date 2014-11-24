//
//  CSGradientIndicatorView.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 23/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSGradientIndicatorView.h"

@interface CSGradientIndicatorView ()

@property (assign, nonatomic) CGFloat progression;

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

@end
