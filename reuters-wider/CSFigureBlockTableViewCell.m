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
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet CSAttributedLabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *figureImageView;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *gradientIndicatorView;

@end

@implementation CSFigureBlockTableViewCell

- (void)awakeFromNib {
    self.backgroundColorView.backgroundColor = FIRST_DIMMED_PURPLE;
    
    self.personLabel.font = LEITURA_ROMAN_2_32;
    self.personLabel.textColor = DARK_GREY;
    
    self.subtitleLabel.font = LEITURA_ROMAN_3_19;
    self.subtitleLabel.textColor = DARK_GREY;
    
    self.descriptionLabel.font = LEITURA_ROMAN_1_16;
    self.descriptionLabel.textColor = DARK_GREY;
    self.descriptionLabel.lineHeight = 25;
    
    self.gradientIndicatorView.topColor = DARK_BLUE;
    
    self.figureImageView.alpha = 1;
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
    
    self.backgroundColorView.backgroundColor = DARK_NIGHT_BLUE;
    
    self.personLabel.textColor = PURPLE_GREY;
    self.subtitleLabel.textColor = PURPLE_GREY;
    self.descriptionLabel.textColor = PURPLE_GREY;
    
    self.gradientIndicatorView.topColor = WHITE_COLOR;
    
    self.figureImageView.alpha = 0.4;
}

- (void)hydrateWithContentData:(NSDictionary *)data {
    [super hydrateWithContentData:data];
    
    self.personLabel.text = self.content.person;
    self.descriptionLabel.text = self.content.text;
    
    self.figureImageView.image = [UIImage imageNamed:self.content.image];
    
    if (self.content.date) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        
        [dateFormat setLocale:EN_LOCALE];
        [dateFormat setDateFormat:@"EEEE d LLLL"];
        
        self.subtitleLabel.text = [dateFormat stringFromDate:self.content.formattedDate];
    } else {
        self.subtitleLabel.text = self.content.title;
    }
}

@end
