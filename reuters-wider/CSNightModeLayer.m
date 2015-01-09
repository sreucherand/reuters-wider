//
//  CSNightModeLayer.m
//  reuters-wider
//
//  Created by Clément Bardon on 07/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import "CSNightModeLayer.h"
#import "CSGradientIndicatorView.h"

@interface CSNightModeLayer () {
    CGFloat _progression;
}

@property (weak, nonatomic) IBOutlet UILabel *nightModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *teasingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *moonIconImageView;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *gradientIndicatorView;

@end

@implementation CSNightModeLayer

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.nightModeLabel.font = LEITURA_ROMAN_2_25;
    self.nightModeLabel.textColor = WHITE_COLOR;
    self.nightModeLabel.text = @"Night mode";
    self.nightModeLabel.alpha = 0;
    
    self.teasingLabel.font = CALIBRE_LIGHT_16;
    self.teasingLabel.textColor = WHITE_COLOR;
    self.teasingLabel.text = @"Are you in a dark environment ?\nYou can activate the night mode,\njust tap on your screen and on the moon.";
    self.teasingLabel.alpha = 0;
    
    [self.dismissButton setTitle:@"OK" forState:UIControlStateNormal];
    [self.dismissButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    self.dismissButton.titleLabel.font = CALIBRE_LIGHT_16;
    self.dismissButton.alpha = 0;
    self.dismissButton.userInteractionEnabled = NO;
    
    self.moonIconImageView.alpha = 0;
    
    [self.gradientIndicatorView clearAnimation];
    [self.gradientIndicatorView interpolateBetweenColor:[UIColor clearColor] andColor:WHITE_COLOR withProgression:0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
- (void)drawRect:(CGRect)rect {
    CGFloat locations[2];
    
    locations[0] = 0;
    locations[1] = 1;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    
    NSMutableArray *colors = [[NSMutableArray alloc] initWithCapacity:2];
    
    [colors addObject:(id)FIRST_PURPLE.CGColor];
    [colors addObject:(id)[FIRST_PURPLE colorWithAlphaComponent:0].CGColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(space, (CFArrayRef)colors, locations);
    
    CGContextSetFillColorWithColor(context, FIRST_PURPLE.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, CGRectGetWidth(rect), (CGRectGetHeight(rect)/2)*_progression));
    
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, (CGRectGetHeight(rect)/2)*_progression - 1), CGPointMake(0, CGRectGetHeight(rect)*_progression), 0);
    
    CGColorSpaceRelease(space);
    CGGradientRelease(gradient);
}

- (void)animate {
    [CSTween tweenFrom:0 to:1 duration:1.5 timingFunction:CSTweenEaseInOutExpo updateBlock:^(CSTweenOperation *operation) {
        _progression = operation.value;
        
        [self setNeedsDisplay];
    } completeBlock:nil];
    
    [CSTween tweenFrom:0 to:1 duration:1.5 delay:1 timingFunction:CSTweenEaseOutExpo updateBlock:^(CSTweenOperation *operation) {
        self.nightModeLabel.alpha = operation.value;
        self.teasingLabel.alpha = operation.value;
        self.dismissButton.alpha = operation.value;
        self.moonIconImageView.alpha = operation.value;
    } completeBlock:^(BOOL finished) {
        if (finished) {
            self.dismissButton.userInteractionEnabled = YES;
        }
    }];
    
    [self.gradientIndicatorView animateWidthDuration:1 delay:1.5 timingFunction:CSTweenEaseOutExpo completion:nil];
}

- (IBAction)dismissButtonDidPress:(id)sender {
    [CSTween tweenFrom:1 to:0 duration:1 timingFunction:CSTweenEaseInOutExpo updateBlock:^(CSTweenOperation *operation) {
        self.alpha = operation.value;
    } completeBlock:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

@end
