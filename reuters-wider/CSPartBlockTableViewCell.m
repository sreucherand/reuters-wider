//
//  CSArticleTableHeaderView.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 07/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSPartBlockTableViewCell.h"

@interface CSPartBlockTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *partNumberLabel;
@property (weak, nonatomic) IBOutlet UIView *rectanglePartNumberView;
@property (weak, nonatomic) IBOutlet UILabel *readDurationLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *readDurationCenterAlignmentConstraint;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelCenterVerticalAlignmentConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;

@end

@implementation CSPartBlockTableViewCell

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.marginRight = 0;
    }
    
    return self;
}

- (void)awakeFromNib {
    self.partNumberLabel.font = CALIBRE_REGULAR_21;
    self.partNumberLabel.textColor = FIRST_PURPLE;
    
    self.rectanglePartNumberView.backgroundColor = FIRST_PURPLE;
    
    self.readDurationLabel.font = CALIBRE_LIGHT_16;
    self.readDurationLabel.textColor = FIRST_PURPLE;
    
    self.titleLabel.font = LEITURA_ROMAN_3_35;
    self.titleLabel.textColor = BLACK_COLOR;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.gradientIndicatorView.topColor = DARK_BLUE;
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
    
    self.partNumberLabel.text = [NSString stringWithFormat:@"Part 0%i", self.content.part];
    self.readDurationLabel.text = [NSString stringWithFormat:@"%i min", self.content.duration];
    self.titleLabel.text = self.content.title;
    
    self.articleImage.image = [UIImage imageNamed:self.content.image];
    
    self.readDurationCenterAlignmentConstraint.constant = (24 + [self.readDurationLabel.text sizeWithAttributes:@{NSFontAttributeName: CALIBRE_LIGHT_16}].width)/2 - 24;
}

- (void)switchToNightMode {
    [super switchToNightMode];
    
    self.rectanglePartNumberView.backgroundColor = FIRST_PURPLE;
    
    self.partNumberLabel.textColor = FIRST_PURPLE;
    self.readDurationLabel.textColor = FIRST_PURPLE;
    
    self.titleLabel.textColor = PURPLE_GREY;
    
    self.gradientIndicatorView.topColor = WHITE_COLOR;
}

@end
