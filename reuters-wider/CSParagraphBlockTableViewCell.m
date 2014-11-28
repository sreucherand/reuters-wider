//
//  CSParagraphBlockTableViewCell.m
//  reuters-wider
//
//  Created by Clément Bardon on 27/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSParagraphBlockTableViewCell.h"

@interface CSParagraphBlockTableViewCell ()

@property (weak, nonatomic) IBOutlet UITextView *paragraphTextView;

@end

@implementation CSParagraphBlockTableViewCell

-(void)awakeFromNib {
    self.paragraphTextView.font = LEITURA_ROMAN_1_16;
    self.paragraphTextView.textColor = GREY_COLOR;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
