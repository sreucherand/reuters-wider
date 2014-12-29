//
//  CSArticleTableHeaderView.h
//  reuters-wider
//
//  Created by Sylvain Reucherand on 07/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CSGradientIndicatorView.h"

@interface CSArticleTableHeaderView : UIView

@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *gradientIndicatorView;

- (void)hydrateWithHeadingData:(NSDictionary *)data;

@end
