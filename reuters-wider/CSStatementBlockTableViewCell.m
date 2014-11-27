//
//  CSStatementBlockTableViewCell.m
//  reuters-wider
//
//  Created by Clément Bardon on 27/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSStatementBlockTableViewCell.h"
#import "CSGradientIndicatorView.h"

@interface CSStatementBlockTableViewCell ()

@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *gradientView;
@property (weak, nonatomic) IBOutlet UITextView *statementTextView;

@end

@implementation CSStatementBlockTableViewCell

-(void)awakeFromNib{
    self.gradientView.topColor = LIGHT_BLUE_COLOR;
    self.statementTextView.font = LEITURA_ITALIC_2_20;
    self.statementTextView.textColor = BLUE_COLOR;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
