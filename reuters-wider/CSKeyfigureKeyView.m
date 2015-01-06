//
//  CSKeyfigureKeyView.m
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 06/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import "CSKeyfigureKeyView.h"

@implementation CSKeyfigureKeyView

- (void)awakeFromNib {
    self.valueLabel.font = CALIBRE_MEDIUM_60;
    self.valueLabel.textColor = LIGHT_BLUE_COLOR;
    
    self.labelLabel.font = LEITURA_ROMAN_1_17;
    self.labelLabel.textColor = WHITE_COLOR;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
