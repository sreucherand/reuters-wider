//
//  CSAttributedLabel.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 02/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSAttributedLabel.h"

@interface CSAttributedLabel ()

@property (strong, nonatomic) UIColor *topGradientColor;
@property (strong, nonatomic) UIColor *bottomGradientColor;

@end

@implementation CSAttributedLabel

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.preferredMaxLayoutWidth = CGRectGetWidth(self.bounds);
    
    [super layoutSubviews];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setText:(NSString *)text {
    [super setText:text];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\[(.*?)\\]\\((\\S+)(\\s+(\"|\')(.*?)(\"|\'))?\\)" options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *results = [regex matchesInString:self.text options:0 range:NSMakeRange(0, ((NSString *)self.text).length)];
    
    style.alignment = self.textAlignment;
    style.lineSpacing = 0.0f;
    style.minimumLineHeight = self.lineHeight;
    style.maximumLineHeight = self.lineHeight;
    
    [string addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, string.length)];
    
    self.attributedText = string;
    
    for (NSTextCheckingResult *result in results) {
        NSString *title = [self.text substringWithRange:[result rangeAtIndex:1]];
        NSString *url = [self.text substringWithRange:[result rangeAtIndex:2]];
        
        [string replaceCharactersInRange:result.range withString:title];
        
        self.attributedText = [string copy];
        
        [self addLinkToURL:[NSURL URLWithString:url] withRange:NSMakeRange(result.range.location, [result rangeAtIndex:1].length)];
    }
}

- (void)setLineHeight:(CGFloat)lineHeight {
    _lineHeight = lineHeight;
}

- (void)textColorWithGradienFromColor:(UIColor *)topColor toColor:(UIColor *)bottomColor {
    self.topGradientColor = topColor;
    self.bottomGradientColor = bottomColor;
}

- (UIColor *)colorGradientFromContextValue {
    CGSize size = self.frame.size;
    
    UIGraphicsBeginImageContext(size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIGraphicsPushContext(context);
    
    CGFloat locations[2];
    
    locations[0] = 0;
    locations[1] = 1;
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    
    NSMutableArray *colors = [[NSMutableArray alloc] initWithCapacity:4];
    
    [colors addObject:(id)[self.topGradientColor CGColor]];
    [colors addObject:(id)[self.bottomGradientColor CGColor]];
    
    CGGradientRef gradient = CGGradientCreateWithColors(space, (CFArrayRef)colors, locations);
    
    CGPoint topCenter = CGPointMake(0, 0);
    CGPoint bottomCenter = CGPointMake(0, size.height);
    
    CGContextDrawLinearGradient(context, gradient, topCenter, bottomCenter, 0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(space);
    
    UIGraphicsPopContext();
    
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:gradientImage];
}

@end