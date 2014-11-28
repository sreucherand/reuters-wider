//
//  CSTeasingBlockTableViewCell.m
//  reuters-wider
//
//  Created by Clément Bardon on 27/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSTeasingBlockTableViewCell.h"

@interface CSTeasingBlockTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *teasingText;

@end

@implementation CSTeasingBlockTableViewCell

- (void)awakeFromNib {
    self.teasingText.font = LEITURA_ROMAN_3_23;
    self.teasingText.textColor = DARKEST_GREY_COLOR;
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
    
    self.teasingText.text = self.content.text;
    self.teasingText.font = LEITURA_ROMAN_3_23;
    self.teasingText.textColor = DARKEST_GREY_COLOR;
}

@end
