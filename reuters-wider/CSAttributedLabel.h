//
//  CSAttributedLabel.h
//  reuters-wider
//
//  Created by Sylvain Reucherand on 02/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CSAttributedLabelDelegate;

@interface CSAttributedLabel : TTTAttributedLabel

@property (assign, nonatomic) CGFloat lineHeight;

@end

@protocol CSAttributedLabelDelegate <TTTAttributedLabelDelegate>

@end