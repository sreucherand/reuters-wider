//
//  CSBoucingView.h
//  reuters-wider
//
//  Created by Sylvain Reucherand on 07/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CSBoucingViewDelegate;

@interface CSBoucingView : UIView

@property (assign, nonatomic) BOOL muted;
@property (assign, nonatomic) CGPoint contentOffset;
@property (assign, nonatomic) id <CSBoucingViewDelegate> delegate;

@end

@protocol CSBoucingViewDelegate <NSObject>
@optional

- (void)boucingViewDidScroll:(CSBoucingView *)boucingView;
- (void)boucingViewWillBeginDecelarating:(CSBoucingView *)boucingView;

@end
