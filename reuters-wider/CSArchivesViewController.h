//
//  CSArchivesViewController.h
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 10/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSArchivesViewController : UIViewController

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIView *bottomView;

- (void)openWith:(void(^)())completion;
- (void)closeWith:(void(^)())completion;

@end
