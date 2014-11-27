//
//  CSAbstractArticleViewCellTableViewCell.h
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 27/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSAbstractArticleViewCellTableViewCell : UITableViewCell

@property (strong, nonatomic) CSPartModel *heading;
@property (strong, nonatomic) CSBlockContentModel *content;

- (void)hydrateWithHeadingData:(NSDictionary *)data;
- (void)hydrateWithContentData:(NSDictionary *)data;

@end
