//
//  CSPOVBlockTableViewCell.m
//  reuters-wider
//
//  Created by Clément Bardon on 27/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSPovBlockTableViewCell.h"

@interface CSPovBlockTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UILabel *mainMetaLabel;
@property (weak, nonatomic) IBOutlet CSAttributedLabel *mainTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *comparedMetaLabel;
@property (weak, nonatomic) IBOutlet CSAttributedLabel *comparedTextLabel;

@end

@implementation CSPovBlockTableViewCell

- (void)awakeFromNib {
    self.mainView.backgroundColor = MIDDLE_BLUE_COLOR;
    
    self.mainMetaLabel.font = CALIBRE_LIGHT_14;
    self.mainMetaLabel.textColor = WHITE_COLOR;
    
    self.mainTextLabel.font = LEITURA_ROMAN_2_23;
    self.mainTextLabel.textColor = WHITE_COLOR;
    self.mainTextLabel.lineHeight = 28;
    
    self.comparedMetaLabel.font = CALIBRE_LIGHT_14;
    self.comparedMetaLabel.textColor = BLUE_COLOR;
    
    self.comparedTextLabel.font = ARCHER_THIN_38;
    self.comparedTextLabel.lineHeight = 34;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.mainTextLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.mainTextLabel.frame);
    self.comparedTextLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.comparedTextLabel.frame);
}

- (void)setNeedsLayout {
    [super setNeedsLayout];
    
    self.comparedTextLabel.textColor = [UIColor colorWithPatternImage:[self gradient]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)hydrateWithContentData:(NSDictionary *)data {
    [super hydrateWithContentData:data];
    
    self.mainMetaLabel.text = [NSString stringWithFormat:@"%@, by %@", [self.content.views[0] date], [self.content.views[0] author]];
    self.mainTextLabel.text = [self.content.views[0] text];
    
    self.comparedMetaLabel.text = [NSString stringWithFormat:@"By %@", [self.content.views[1] author]];
    self.comparedTextLabel.text = [self.content.views[1] text];
}

- (UIImage *)gradient {
    CGSize size = self.comparedTextLabel.frame.size;
    
    UIGraphicsBeginImageContext(size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIGraphicsPushContext(context);
    
    CGFloat locations[2];
    
    locations[0] = 0;
    locations[1] = 1;
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    
    NSMutableArray *colors = [[NSMutableArray alloc] initWithCapacity:4];
    
    [colors addObject:(id)[TEXT_GRADIENT_BLUE_COLOR CGColor]];
    [colors addObject:(id)[TEXT_GRADIENT_ORANGE_COLOR CGColor]];
    
    CGGradientRef gradient = CGGradientCreateWithColors(space, (CFArrayRef)colors, locations);
    
    CGPoint topCenter = CGPointMake(0, 0);
    CGPoint bottomCenter = CGPointMake(0, size.height);
    
    CGContextDrawLinearGradient(context, gradient, topCenter, bottomCenter, 0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(space);
    
    UIGraphicsPopContext();
    
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return gradientImage;
}

@end
