//
//  CSKeywordsBlockTableViewCell.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 31/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSKeywordsBlockTableViewCell.h"

@interface CSKeywordsBlockTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *mainSuperView;


@end


@implementation CSKeywordsBlockTableViewCell
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    CALayer *topBorder = [CALayer layer];
    
    topBorder.frame = CGRectMake(20, 0, (CGRectGetWidth(self.mainSuperView.frame) - 50), 1);
    topBorder.backgroundColor = LIGHT_DIMMED_GREY.CGColor;
    
    [self.mainSuperView.layer addSublayer:topBorder];
}

- (void)hydrateWithContentData:(NSDictionary *)data {
    [super hydrateWithContentData:data];
    
    NSInteger fullSize = 0;
    NSTextAttachment *icon = [[NSTextAttachment alloc] init];
    icon.image = [UIImage imageNamed:@"iconBullet"];
    
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:icon];
    
    [self.mainView layoutIfNeeded];
    
    for(int i = 0; i < [self.content.keywords count]; i++) {
        NSMutableAttributedString *stringWithIcon= [[NSMutableAttributedString alloc] initWithAttributedString:attachmentString];
        NSAttributedString *currentKeywordText = [[NSMutableAttributedString alloc] initWithString:[self.content.keywords[i] text]];
        [stringWithIcon appendAttributedString:currentKeywordText];
        
        CGRect labelRect = CGRectMake (fullSize, 0, 80, CGRectGetHeight(self.mainView.frame));  // location of label in the window
        UILabel *keywordLabel = [[UILabel alloc] initWithFrame: labelRect];
        
        keywordLabel.attributedText = stringWithIcon;
        keywordLabel.clipsToBounds=YES;
        keywordLabel.font = CALIBRE_REG_15;
        keywordLabel.textColor = FIRST_PURPLE;
        
        [self.mainView addSubview: keywordLabel];
        
        CGSize textSize = [[keywordLabel text] sizeWithAttributes:@{NSFontAttributeName:[keywordLabel font]}];
        fullSize += textSize.width + 32;
    }
}

@end
