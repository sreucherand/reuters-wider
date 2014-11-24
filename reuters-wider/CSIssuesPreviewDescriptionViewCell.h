//
//  CSIssuePreviewDescriptionViewCell.h
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 24/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSIssuesPreviewDescriptionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *issuesPreviewNumeroLabel;
@property (weak, nonatomic) IBOutlet UILabel *issuesPreviewHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *issuesPreviewDateLabel;

@end
