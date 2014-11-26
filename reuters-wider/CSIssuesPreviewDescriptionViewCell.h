//
//  CSIssuePreviewDescriptionViewCell.h
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 24/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSIssuesPreviewDescriptionViewCell : UICollectionViewCell

- (void)hydrateWidthNumber:(NSInteger)number title:(NSString *)title date:(NSDate *)date;

@end
