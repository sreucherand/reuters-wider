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
    [super awakeFromNib];
    self.metaLabel.font = CALIBRE_LIGHT_14;
    self.metaLabel.textColor = FIRST_PURPLE;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 */

- (void)switchToNightMode {
    [super switchToNightMode];
    self.metaLabel.textColor = FIRST_PURPLE;
}

- (void)hydrateWithContentData:(NSDictionary *)data {
    [super hydrateWithContentData:data];
    
    self.metaLabel.text = [[NSString stringWithFormat:@"By %@ - %@", self.content.author, self.content.category] uppercaseString];
}

@end
