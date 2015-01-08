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

@property (assign, nonatomic) CGFloat marginRight;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSIndexPath *indexPath;

@property (strong, nonatomic) CSBlockContentModel *content;
@property (strong, nonatomic) id<CSAbstractArticleViewCellTableViewCellDelegate> delegate;

- (void)hydrateWithContentData:(NSDictionary *)data;
- (void)hydrateWithContentData:(NSDictionary *)data forState:(NSNumber *)state;

@end

@protocol CSAbstractArticleViewCellTableViewCellDelegate <NSObject>
@optional;

- (void)tableViewCell:(CSAbstractArticleViewCellTableViewCell *)cell rowNeedsPersistentState:(NSNumber *)state;
- (void)didSelectLinkWithURL:(NSURL *)url atPoint:(NSValue *)point;

@end
