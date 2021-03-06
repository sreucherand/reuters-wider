//
//  CSGlossaryDefinitionTableViewCell.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 07/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSGlossaryDefinitionTableViewCell.h"

@implementation CSGlossaryDefinitionTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.letterLabel.font = LEITURA_ROMAN_3_35;
    self.letterLabel.textColor = DARK_BLUE;
    
    self.titleDefinitionLabel.font = LEITURA_ROMAN_3_19;
    
    self.definitionLabel.font = CALIBRE_LIGHT_16;
    self.definitionLabel.textColor = DARK_GREY;
    self.definitionLabel.lineHeight = 20;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView layoutIfNeeded];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)hydrateWithDefinition:(CSDefinitionModel *)definition forIndexPath:(NSIndexPath *)indexPath {
    self.letterLabel.text = [[definition.title substringWithRange:NSMakeRange(0, 1)] uppercaseString];
    self.titleDefinitionLabel.text = definition.title;
    self.definitionLabel.text = definition.text;
    
    if (indexPath.row > 0) {
        self.letterLabel.textColor = [UIColor clearColor];
    }
}

@end
