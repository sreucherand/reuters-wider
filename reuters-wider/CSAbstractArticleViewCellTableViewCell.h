//
//  CSAbstractArticleViewCellTableViewCell.h
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 27/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CSAttributedLabel.h"

@protocol CSAbstractArticleViewCellTableViewCellDelegate;

@interface CSAbstractArticleViewCellTableViewCell : UITableViewCell

@property (strong, nonatomic) CSBlockContentModel *content;
@property (strong, nonatomic) id<CSAbstractArticleViewCellTableViewCellDelegate> delegate;

- (void)hydrateWithContentData:(NSDictionary *)data;

@end

@protocol CSAbstractArticleViewCellTableViewCellDelegate <NSObject>

- (void)didSelectLinkWithURL:(NSURL *)url;

@end
