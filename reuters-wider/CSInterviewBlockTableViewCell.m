//
//  CSInterviewBlockTableViewCell.m
//  reuters-wider
//
//  Created by Clément Bardon on 05/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import "CSInterviewBlockTableViewCell.h"
#import "CSGradientIndicatorView.h"

@interface CSInterviewBlockTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *interviewViewBackground;
@property (weak, nonatomic) IBOutlet UILabel *interviewTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *interviewedNameLabel;
@property (weak, nonatomic) IBOutlet CSAttributedLabel *keyphraseLabel;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *gradientView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundImageViewHeightConstrint;

@end

@implementation CSInterviewBlockTableViewCell

- (void)awakeFromNib {
    self.interviewViewBackground.backgroundColor = FIRST_DIMMED_PURPLE;
    
    self.interviewTitleLabel.font = LEITURA_ROMAN_3_19;
    self.interviewTitleLabel.textColor = DARK_GREY;
    
    self.interviewedNameLabel.font = CALIBRE_LIGHT_16;
    self.interviewedNameLabel.textColor = FIRST_PURPLE;
    
    self.gradientView.topColor = DARK_BLUE;
    
    self.keyphraseLabel.font = LEITURA_ROMAN_1_19;
    self.keyphraseLabel.textColor = DARK_GREY;
    self.keyphraseLabel.lineHeight = 25;
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
    
    self.interviewTitleLabel.text = self.content.title;
    self.interviewedNameLabel.text = self.content.person;
    self.keyphraseLabel.text = self.content.subject;
    
    UIImage *image = [UIImage imageNamed:self.content.thumbnail];
    
    CGFloat ratio = image.size.height/image.size.width;
    
    self.backgroundImageView.image = image;
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImageViewHeightConstrint.constant = CGRectGetWidth(self.frame)*ratio;
}

@end
