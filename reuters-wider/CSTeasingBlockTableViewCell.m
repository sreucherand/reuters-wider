//
//  CSTeasingBlockTableViewCell.m
//  reuters-wider
//
//  Created by Clément Bardon on 27/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSTeasingBlockTableViewCell.h"

@interface CSTeasingBlockTableViewCell ()

@property (weak, nonatomic) IBOutlet CSAttributedLabel *teasingText;

@end

@implementation CSTeasingBlockTableViewCell

- (void)awakeFromNib {
    self.teasingText.font = LEITURA_ROMAN_3_23;
    self.teasingText.textColor = DARK_GREY;
    self.teasingText.lineHeight = 30;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)switchToNightMode {
    [super switchToNightMode];
    self.teasingText.textColor = PURPLE_GREY;
}

- (void)hydrateWithContentData:(NSDictionary *)data {
    [super hydrateWithContentData:data];
    
    self.teasingText.text = self.content.text;
}

@end
