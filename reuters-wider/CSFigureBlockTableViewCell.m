//
//  CSFigureBlockTableViewCell.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 04/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSFigureBlockTableViewCell.h"
#import "CSGradientIndicatorView.h"

@interface CSFigureBlockTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *backgroundColorView;

@property (weak, nonatomic) IBOutlet UILabel *personLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet CSAttributedLabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *figureImageView;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *gradientIndicatorView;

@end

@implementation CSFigureBlockTableViewCell

- (void)awakeFromNib {
    self.backgroundColorView.backgroundColor = BLUE_GREY_COLOR;
    
    self.personLabel.font = LEITURA_ROMAN_2_32;
    self.personLabel.textColor = DARKEST_GREY_COLOR;
    
    self.dateLabel.font = LEITURA_ROMAN_3_16;
    self.dateLabel.textColor = DARKEST_GREY_COLOR;
    
    self.descriptionLabel.font = LEITURA_ROMAN_1_16;
    self.descriptionLabel.textColor = COOL_GREY_COLOR;
    self.descriptionLabel.lineHeight = 25;
    
    self.gradientIndicatorView.topColor = WIDER_DARK_BLUE_COLOR;
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
    
    self.personLabel.text = self.content.person;
    self.descriptionLabel.text = self.content.text;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setLocale:EN_LOCALE];
    [dateFormat setDateFormat:@"EEEE d LLLL"];
    
    self.dateLabel.text = [dateFormat stringFromDate:self.content.formattedDate];
    
    self.figureImageView.image = [UIImage imageNamed:self.content.image];
}

@end
