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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *readDurationCenterAlignmentConstraint;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *gradientImageView;
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *articleImageHeightConstraint;

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

- (void)setNeedsLayout {
    [super setNeedsLayout];
    
    self.articleImageHeightConstraint.constant = CGRectGetWidth(self.frame);
}

- (void)hydrateWithHeadingData:(NSDictionary *)data {
    [super hydrateWithHeadingData:data];
    
    self.partNumberLabel.text = [NSString stringWithFormat:@"Part 0%i", self.heading.id+1];
    self.readDurationLabel.text = [NSString stringWithFormat:@"%i min", self.heading.duration];
    self.titleLabel.text = self.heading.title;
    
    self.articleImage.image = [UIImage imageNamed:self.heading.image];
    
    self.readDurationCenterAlignmentConstraint.constant = (24 + [self.readDurationLabel.text sizeWithAttributes:@{NSFontAttributeName: CALIBRE_LIGHT_16}].width)/2 - 24;
}

@end
