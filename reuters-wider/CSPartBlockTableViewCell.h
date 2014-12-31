//
//  CSArticleTableHeaderView.h
//  reuters-wider
//
//  Created by Sylvain Reucherand on 07/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSAbstractArticleViewCellTableViewCell.h"
#import "CSGradientIndicatorView.h"

@interface CSPartBlockTableViewCell : CSAbstractArticleViewCellTableViewCell

@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *gradientIndicatorView;

@end
