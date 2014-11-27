//
//  CSHeadingBlockTableViewCell.m
//  reuters-wider
//
//  Created by Clément Bardon on 27/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSHeadingBlockTableViewCell.h"
#import "CSGradientIndicatorView.h"

@interface CSHeadingBlockTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *partNumberLabel;
@property (weak, nonatomic) IBOutlet UIView *rectanglePartNumberView;
@property (weak, nonatomic) IBOutlet UILabel *readDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *gradientImageView;
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;

@end

@implementation CSHeadingBlockTableViewCell
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    self.partNumberLabel.font = CALIBRE_REG;
    self.partNumberLabel.textColor = BLUE_COLOR;
    
    self.rectanglePartNumberView.backgroundColor = BLUE_COLOR;
    
    self.readDurationLabel.font = CALIBRE_LIGHT_16;
    self.readDurationLabel.textColor = BLUE_COLOR;
    
    self.titleLabel.font = LEITURA_ROMAN_3_36;
    self.titleLabel.textColor = DARKEST_GREY_COLOR;
    
    self.gradientImageView.topColor = WIDER_DARK_BLUE_COLOR;
    
}

@end
