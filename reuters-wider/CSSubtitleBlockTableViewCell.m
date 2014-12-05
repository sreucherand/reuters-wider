//
//  CSSubtitleBlockTableViewCell.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 03/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSSubtitleBlockTableViewCell.h"

@interface CSSubtitleBlockTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end

@implementation CSSubtitleBlockTableViewCell

- (void)awakeFromNib {
    self.subtitleLabel.font = LEITURA_ROMAN_3_19;
    self.subtitleLabel.textColor = DARKEST_GREY_COLOR;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.subtitleLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.subtitleLabel.frame);
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
    
    self.subtitleLabel.text = self.content.text;
}

@end