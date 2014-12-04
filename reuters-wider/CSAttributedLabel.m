//
//  CSAttributedLabel.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 02/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSAttributedLabel.h"

@implementation CSAttributedLabel

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
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\[(.*?)\\]\\((\\S+)(\\s+(\"|\')(.*?)(\"|\'))?\\)" options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *results = [regex matchesInString:self.text options:0 range:NSMakeRange(0, ((NSString *)self.text).length)];
    
    for (NSTextCheckingResult *result in results) {
        NSString *title = [self.text substringWithRange:[result rangeAtIndex:1]];
        NSString *url = [self.text substringWithRange:[result rangeAtIndex:2]];
        
        [string replaceCharactersInRange:result.range withString:title];
        
        self.attributedText = [string copy];
        
        [self addLinkToURL:[NSURL URLWithString:url] withRange:NSMakeRange(result.range.location, [result rangeAtIndex:1].length)];
    }
}

- (void)setLineHeight:(CGFloat)lineHeight {
    [self setLineSpacing:lineHeight - self.font.lineHeight];
}

@end