//
//  CSAsideBlockTableCellID.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 04/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSAsideBlockTableViewCell.h"

@interface CSAsideBlockTableViewCell ()

@property (weak, nonatomic) IBOutlet CSAttributedLabel *asideLabel;

@end

@implementation CSAsideBlockTableViewCell

- (void)awakeFromNib {
    self.asideLabel.font = CALIBRE_LIGHT_17;
    self.asideLabel.textColor = BLUE_COLOR;
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
    
    self.asideLabel.text = self.content.text;
}

@end
