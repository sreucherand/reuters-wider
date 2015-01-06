//
//  CSTransitionBlockTableViewCell.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 31/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSTransitionBlockTableViewCell.h"

@interface CSTransitionBlockTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *topPartView;
@property (weak, nonatomic) IBOutlet UILabel *titleTopPart;
@property (weak, nonatomic) IBOutlet UILabel *subtitleTopPart;
@property (weak, nonatomic) IBOutlet UIView *bottomPartView;
@property (weak, nonatomic) IBOutlet UILabel *subtitleBottomPart;
@property (weak, nonatomic) IBOutlet UILabel *titleBottomPart;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *topPartGradient;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *bottomPartGradient;

@end

@implementation CSTransitionBlockTableViewCell

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)awakeFromNib {
    // Top part related
    self.topPartView.backgroundColor = THIRD_PURPLE;
    
    self.titleTopPart.font = LEITURA_ITALIC_2_38;
    self.titleTopPart.textColor = DARK_BLUE;
    
    self.subtitleTopPart.font = CALIBRE_LIGHT_16;
    self.subtitleTopPart.textColor = DARK_BLUE;
    
    self.topPartGradient.topColor = DARK_BLUE;
    
    // Bottom part related
    self.bottomPartView.backgroundColor = FIRST_PURPLE;
    
    self.titleBottomPart.font = LEITURA_ITALIC_2_38;
    self.titleBottomPart.textColor = WHITE_COLOR;
    
    self.subtitleBottomPart.font = CALIBRE_LIGHT_16;
    self.subtitleBottomPart.textColor = WHITE_COLOR;
    
    self.bottomPartGradient.topColor = WHITE_COLOR;
    self.bottomPartGradient.direction = CSDirectionBottom;
}

- (void)hydrateWithContentData:(NSDictionary *)data {
    [super hydrateWithContentData:data];
    
    self.titleTopPart.text = [self.content.transitions[0] title];
    self.subtitleTopPart.text = [self.content.transitions[0] teasing];
    
    self.titleBottomPart.text = [self.content.transitions[1] title];
    self.subtitleBottomPart.text = [self.content.transitions[1] teasing];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
