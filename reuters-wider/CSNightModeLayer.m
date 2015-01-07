//
//  CSNightModeLayer.m
//  reuters-wider
//
//  Created by Clément Bardon on 07/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import "CSNightModeLayer.h"
#import "CSGradientIndicatorView.h"

@interface CSNightModeLayer ()
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
    
    self.nightModeLabel.font = LEITURA_ROMAN_2_23;
    self.nightModeLabel.textColor = WHITE_COLOR;
    self.nightModeLabel.text = @"Night mode";
    
    self.teasingLabel.font = CALIBRE_REG_15;
    self.teasingLabel.textColor = WHITE_COLOR;
    self.teasingLabel.text = @"Are you in a dark environment ?\nYou can activate the night mode,\njust tap on your screen and on the moon.";
    
    [self.dismissButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    self.dismissButton.titleLabel.font = CALIBRE_REG_15;
    
    self.gradientIndicatorView.topColor = WHITE_COLOR;
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
    CGContextFillRect(context, CGRectMake(0, 0, CGRectGetWidth(rect), (CGRectGetHeight(rect)/2)));
    
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, (CGRectGetHeight(rect)/2)), CGPointMake(0, CGRectGetHeight(rect)), 0);
    
    CGColorSpaceRelease(space);
    CGGradientRelease(gradient);
}

@end
