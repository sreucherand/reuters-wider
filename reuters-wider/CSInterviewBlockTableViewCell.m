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

@end

@implementation CSInterviewBlockTableViewCell

- (void)awakeFromNib {
    self.interviewViewBackground.backgroundColor = BLUE_GREY_COLOR;
    
    self.interviewTitleLabel.font = LEITURA_ROMAN_3_19;
    self.interviewTitleLabel.textColor = DARK_GREY_TOGGLE_COLOR;
    
    self.interviewedNameLabel.font = CALIBRE_REG_15;
    self.interviewedNameLabel.textColor = LIGHT_BLUE_COLOR;
    
    self.gradientView.topColor = LIGHT_BLUE_COLOR;
    
    self.keyphraseLabel.font = LEITURA_ROMAN_1_19;
    self.keyphraseLabel.textColor = DARK_GREY_TOGGLE_COLOR;
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
}

@end
