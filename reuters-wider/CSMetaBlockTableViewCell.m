//
//  CSMetaBlockTableViewCell.m
//  reuters-wider
//
//  Created by Clément Bardon on 27/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSMetaBlockTableViewCell.h"

@interface CSMetaBlockTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *metaLabel;

@end

@implementation CSMetaBlockTableViewCell

- (void)awakeFromNib {
    self.metaLabel.font = CALIBRE_REG_11;
    self.metaLabel.textColor = LIGHT_BLUE_COLOR;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
