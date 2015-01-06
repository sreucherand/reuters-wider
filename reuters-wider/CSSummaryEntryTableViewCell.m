//
//  CSSummaryEntryTableViewCell.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 03/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import "CSSummaryEntryTableViewCell.h"
#import "CSGradientIndicatorView.h"

@interface CSSummaryEntryTableViewCell ()

@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *gradientIndicatorView;

@end

@implementation CSSummaryEntryTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.backgroundColor = [UIColor clearColor];
    
    self.partNumberLabel.font = CALIBRE_REG_11;
    self.partTitleLabel.font = LEITURA_ROMAN_1_17;
    self.partSubtitleLabel.font = CALIBRE_LIGHT_17;
    
    [self switchTableViewCellIntoLightMode];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnCell:)];
    
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Modes

- (void)switchTableViewCellIntoLightMode {
    self.partNumberLabel.textColor = DARK_BLUE;
    self.partTitleLabel.textColor = DARK_GREY;
    self.partSubtitleLabel.textColor = LIGHT_GREY;
    
    self.gradientIndicatorView.topColor = DARK_BLUE;
}

- (void)switchTableViewCellIntoDarkMode {
    self.partNumberLabel.textColor = WHITE_COLOR;
    self.partTitleLabel.textColor = WHITE_COLOR;
    self.partSubtitleLabel.textColor = WHITE_COLOR;
    
    self.gradientIndicatorView.topColor = WHITE_COLOR;
}

#pragma mark - Gesture

- (void)didTapOnCell:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:recognizer.view];
    
    if (location.y < CGRectGetMaxY(self.partSubtitleLabel.frame)) {
        if ([self.delegate respondsToSelector:@selector(didTapOnSummaryEntryCell:)]) {
            [self.delegate performSelector:@selector(didTapOnSummaryEntryCell:) withObject:[NSIndexPath indexPathForRow:[self.partNumberLabel.text intValue] - 1 inSection:0]];
        }
    }
}

@end
