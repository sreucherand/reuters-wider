//
//  CSArticleTableHeaderView.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 07/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSArticleTableHeaderView.h"

@interface CSArticleTableHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *partNumberLabel;
@property (weak, nonatomic) IBOutlet UIView *rectanglePartNumberView;
@property (weak, nonatomic) IBOutlet UILabel *readDurationLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *readDurationCenterAlignmentConstraint;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *articleImageHeightConstraint;

@end

@implementation CSArticleTableHeaderView

- (void)awakeFromNib {
    self.partNumberLabel.font = CALIBRE_REG;
    self.partNumberLabel.textColor = BLUE_COLOR;
    
    self.rectanglePartNumberView.backgroundColor = BLUE_COLOR;
    
    self.readDurationLabel.font = CALIBRE_LIGHT_16;
    self.readDurationLabel.textColor = BLUE_COLOR;
    
    self.titleLabel.font = LEITURA_ROMAN_3_36;
    self.titleLabel.textColor = DARKEST_GREY_COLOR;
    
    self.articleImageHeightConstraint.constant = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    
    self.gradientIndicatorView.topColor = [UIColor clearColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)hydrateWithHeadingData:(NSDictionary *)data {
    CSPartModel *part = (CSPartModel *)data;
    
    self.partNumberLabel.text = [NSString stringWithFormat:@"Part 0%i", part.id+1];
    self.readDurationLabel.text = [NSString stringWithFormat:@"%i min", part.duration];
    self.titleLabel.text = part.title;
    
    self.articleImage.image = [UIImage imageNamed:part.image];
    
    self.readDurationCenterAlignmentConstraint.constant = (24 + [self.readDurationLabel.text sizeWithAttributes:@{NSFontAttributeName: CALIBRE_LIGHT_16}].width)/2 - 24;
}

@end
