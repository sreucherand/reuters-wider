//
//  CSImplicationBlockTableViewCell.m
//  reuters-wider
//
//  Created by Clément Bardon on 06/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import "CSImplicationBlockTableViewCell.h"
#import "CSGradientIndicatorView.h"

@interface CSImplicationBlockTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *localisationView;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *reactionCityLabel;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *firstGradientView;
@property (weak, nonatomic) IBOutlet UILabel *firstQuoteLabel;
@property (weak, nonatomic) IBOutlet CSAttributedLabel *quoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondQuoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *secondGradientView;

@property (weak, nonatomic) IBOutlet UIView *ctaView;
@property (weak, nonatomic) IBOutlet UILabel *ctaTitle;
@property (weak, nonatomic) IBOutlet UIButton *ctaButton;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *ctaGradient;
@end

@implementation CSImplicationBlockTableViewCell

- (void)awakeFromNib {
    // Location view
    self.mainView.backgroundColor = FIRST_PURPLE;
    
    self.reactionCityLabel.font = CALIBRE_LIGHT_16;
    self.reactionCityLabel.textColor = WHITE_COLOR;
    
    self.firstGradientView.topColor = WHITE_DIMMED_COLOR;
    
    self.firstQuoteLabel.font = LEITURA_ROMAN_3_23;
    self.firstQuoteLabel.textColor = LIGHT_GREY;
    self.firstQuoteLabel.text = @"“";
    
    self.quoteLabel.font = LEITURA_ROMAN_3_23;
    self.quoteLabel.textColor = WHITE_COLOR;
    self.quoteLabel.lineHeight = 30;
    
    self.secondQuoteLabel.font = LEITURA_ROMAN_3_23;
    self.secondQuoteLabel.textColor = LIGHT_GREY;
    self.secondQuoteLabel.text = @"”";
    
    self.sourceLabel.font = CALIBRE_LIGHT_16;
    self.sourceLabel.textColor = LIGHT_GREY;
    
    self.secondGradientView.topColor = WHITE_DIMMED_COLOR;
    self.secondGradientView.direction = CSDirectionBottom;
    
    self.ctaView.backgroundColor = FIRST_PURPLE;
    
    self.ctaTitle.font = LEITURA_ROMAN_2_25;
    self.ctaTitle.textColor = WHITE_COLOR;
    self.ctaTitle.text = @"See the reactions\nin your country";
    
    self.ctaGradient.topColor = WHITE_COLOR;
    
    [self.ctaButton setTitle:@"Locate me" forState:UIControlStateNormal];
    [self.ctaButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    self.ctaButton.titleLabel.font = CALIBRE_REGULAR_21;
    
}
- (IBAction)ctaButtonDidPress:(id)sender {
//    self.ctaView.hidden = YES;
    [CSTween tweenFrom:1 to:0 duration:1 timingFunction:CSTweenEaseInOutExpo updateBlock:^(CSTweenOperation *operation) {
        self.ctaView.alpha = operation.value;
    } completeBlock:^(BOOL finished) {
        if (finished) {
            [self.ctaView removeFromSuperview];
        }
    }];
}


- (void)hydrateWithContentData:(NSDictionary *)data {
    [super hydrateWithContentData:data];
    
    self.reactionCityLabel.text = [NSString stringWithFormat:@"%@ reacting", self.content.city];
    
    self.quoteLabel.text = self.content.quote;
    self.sourceLabel.text = self.content.source;
    
    self.backgroundImageView.image = [UIImage imageNamed:self.content.image];
    self.backgroundImageView.alpha = 0.2;
    self.backgroundImageView.clipsToBounds = YES;
}

- (void)switchToNightMode {
    [super switchToNightMode];
    
    self.mainView.backgroundColor = FOURTH_PURPLE;
}

@end
