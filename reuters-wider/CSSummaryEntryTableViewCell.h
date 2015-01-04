//
//  CSSummaryEntryTableViewCell.h
//  reuters-wider
//
//  Created by Sylvain Reucherand on 03/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CSSummaryEntryTableViewCellDelegate;

@interface CSSummaryEntryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *partNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *partTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *partSubtitleLabel;

@property (assign, nonatomic) id <CSSummaryEntryTableViewCellDelegate> delegate;

- (void)switchTableViewCellIntoLightMode;
- (void)switchTableViewCellIntoDarkMode;

@end

@protocol CSSummaryEntryTableViewCellDelegate <NSObject>
@optional

- (void)didTapOnSummaryEntryCell:(NSIndexPath *)indexPath;

@end
