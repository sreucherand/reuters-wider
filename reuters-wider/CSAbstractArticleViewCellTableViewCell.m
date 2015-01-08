//
//  CSAbstractArticleViewCellTableViewCell.m
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 27/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSAbstractArticleViewCellTableViewCell.h"

@implementation CSAbstractArticleViewCellTableViewCell

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        _marginRight = 8;
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView layoutIfNeeded];
}

- (void)setFrame:(CGRect)frame {
    frame.size.width = fmax(frame.size.width - self.marginRight, CGRectGetWidth(self.tableView.frame) - self.marginRight);
    
    [super setFrame:frame];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)hydrateWithContentData:(NSDictionary *)data {
    CSBlockModel *obj = (CSBlockModel *)data;
    
    self.content = obj.content;
}

- (void)hydrateWithContentData:(NSDictionary *)data forState:(NSNumber *)state {
    [self hydrateWithContentData:data];
}

@end
