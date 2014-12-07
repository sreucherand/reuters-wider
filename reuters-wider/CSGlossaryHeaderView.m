//
//  CSGlossaryHeaderView.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 07/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSGlossaryHeaderView.h"

@interface CSGlossaryHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *titleHeaderLabel;

@end

@implementation CSGlossaryHeaderView

- (void)awakeFromNib {
    self.titleHeaderLabel.font = LEITURA_ROMAN_2_23;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
