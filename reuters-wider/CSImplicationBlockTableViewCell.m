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

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *reactionCityLabel;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *firstGradientView;
@property (weak, nonatomic) IBOutlet UILabel *firstQuoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *quoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondQuoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *secondGradientView;

@end

@implementation CSImplicationBlockTableViewCell

- (void)awakeFromNib {
    self.mainView.backgroundColor = FIRST_PURPLE;
    self.reactionCityLabel.font = CALIBRE_MEDIUM_16;
    self.reactionCityLabel.textColor = WHITE_COLOR;
    self.firstGradientView.topColor = WHITE_DIMMED_COLOR;
    self.firstQuoteLabel.font = LEITURA_ROMAN_4_36;
    self.firstQuoteLabel.textColor = LIGHT_GREY;
    self.firstQuoteLabel.text = @"“";
    self.quoteLabel.font = LEITURA_ROMAN_1_24;
    self.quoteLabel.textColor = WHITE_COLOR;
    self.secondQuoteLabel.font = LEITURA_ROMAN_4_36;
    self.secondQuoteLabel.textColor = LIGHT_GREY;
    self.secondQuoteLabel.text = @"”";
    self.sourceLabel.font = CALIBRE_REG_17;
    self.sourceLabel.textColor = LIGHT_GREY;
    self.secondGradientView.topColor = WHITE_DIMMED_COLOR;
    self.secondGradientView.direction = CSDirectionBottom;
}

- (void)hydrateWithContentData:(NSDictionary *)data {
    [super hydrateWithContentData:data];
    self.reactionCityLabel.text = [NSString stringWithFormat:@"%@ reacting", self.content.city];
    self.quoteLabel.text = self.content.quote;
    self.sourceLabel.text = self.content.source;
}

@end
