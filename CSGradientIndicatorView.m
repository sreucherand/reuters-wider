//
//  CSGradientIndicatorView.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 23/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSGradientIndicatorView.h"

@interface CSGradientIndicatorView ()

@property (strong, nonatomic) UIColor *currentColor;
@property (strong, nonatomic) CAGradientLayer *gradientLayer;

@end

@implementation CSGradientIndicatorView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.currentColor = [UIColor blackColor];
        
        self.gradientLayer = [CAGradientLayer layer];
        
        self.gradientLayer.frame = self.bounds;
        self.gradientLayer.colors = @[(id)self.currentColor.CGColor, (id)[self.currentColor colorWithAlphaComponent:0].CGColor];
        self.gradientLayer.locations = @[[NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:1.0f]];
        
        [self.layer addSublayer:self.gradientLayer];
    }
    
    return self;
}

- (void)switchToGradientColor:(UIColor *)color {
    if (![self.currentColor isEqual:color]) {
        NSLog(@"switch color");
        
        self.currentColor = color;
    }
}

@end
