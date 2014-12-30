//
//  CSTestDefinition.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 14/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSInArticleGlossaryDefinition.h"

@interface CSInArticleGlossaryDefinition ()

@property (weak, nonatomic) IBOutlet CSAttributedLabel *titleDefinitionLabel;
@property (weak, nonatomic) IBOutlet CSAttributedLabel *textDefinitionLabel;

@end

@implementation CSInArticleGlossaryDefinition

- (void)awakeFromNib {
    self.titleDefinitionLabel.font = LEITURA_ROMAN_1_17;
    self.titleDefinitionLabel.textColor = GREY_COLOR;
    self.textDefinitionLabel.font = CALIBRE_REG_14;
    self.textDefinitionLabel.textColor = LIGHT_BLUE_TEXT;
    self.textDefinitionLabel.lineHeight = 18;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setFrameForPoint:(CGPoint)point {
    self.frame = (CGRect){.origin=CGPointMake(point.x, point.y), .size=self.frame.size};
}

- (void)hydrateWithTitle:(NSString *)title andText:(NSString *)text {
    self.titleDefinitionLabel.text = title;
    self.textDefinitionLabel.text = text;
    
    self.frame = (CGRect){.origin=self.frame.origin, .size=[self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize]};
}

@end