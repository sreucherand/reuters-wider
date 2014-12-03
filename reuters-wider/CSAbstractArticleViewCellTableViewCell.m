//
//  CSAbstractArticleViewCellTableViewCell.m
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 27/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSAbstractArticleViewCellTableViewCell.h"

@interface CSAbstractArticleViewCellTableViewCell ()

@end

@implementation CSAbstractArticleViewCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)hydrateWithHeadingData:(NSDictionary *)data {
    CSPartModel *obj = (CSPartModel *)data;
    
    self.heading = obj;
}

- (void)hydrateWithContentData:(NSDictionary *)data {
    CSBlockModel *obj = (CSBlockModel *)data;
    
    self.content = obj.content;
}

- (void)attributedLabel:(NIAttributedLabel *)attributedLabel didSelectTextCheckingResult:(NSTextCheckingResult *)result atPoint:(CGPoint)point {
    NSLog(@"CSAttributedLabel delegate dispatch");
}

- (BOOL)attributedLabel:(NIAttributedLabel *)attributedLabel shouldPresentActionSheet:(UIActionSheet *)actionSheet withTextCheckingResult:(NSTextCheckingResult *)result atPoint:(CGPoint)point {
    return NO;
}

@end
