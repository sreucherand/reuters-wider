//
//  CSArchivesViewController.h
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 10/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSArchivesViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewLeftConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewRightConstant;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewLeftConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewRightConstant;

@end
