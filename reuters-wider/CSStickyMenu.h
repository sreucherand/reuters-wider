//
//  CSStickyMenu.h
//  reuters-wider
//
//  Created by Sylvain Reucherand on 30/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CSStickyMenuDelegate;

@interface CSStickyMenu : UIView

@property (weak, nonatomic) IBOutlet UIButton *titleButton;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (assign, nonatomic) id <CSStickyMenuDelegate> delegate;

- (void)enable;
- (void)disable;
- (void)open;
- (void)close;
- (void)toggle;

@end

@protocol CSStickyMenuDelegate <NSObject>
@optional;

- (void)nightModeButtonDidPress;
- (void)titleButtonDidPress;
- (void)backToTopButtonDidPress;

@end
