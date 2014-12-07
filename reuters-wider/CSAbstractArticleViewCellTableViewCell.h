//
//  CSAbstractArticleViewCellTableViewCell.h
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 27/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CSAttributedLabel.h"

@interface CSAbstractArticleViewCellTableViewCell : UITableViewCell

@property (strong, nonatomic) CSBlockContentModel *content;

- (void)hydrateWithContentData:(NSDictionary *)data;

@end
