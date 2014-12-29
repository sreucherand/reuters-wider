//
//  CSArchivesViewController.m
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 10/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSArchivesViewController.h"

@interface CSArchivesViewController ()

@property (strong, nonatomic) NSLayoutConstraint *topViewLeftConstraint;
@property (strong, nonatomic) NSLayoutConstraint *topViewRightConstraint;
@property (strong, nonatomic) NSLayoutConstraint *topViewTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *topViewBottomConstraint;

@property (strong, nonatomic) NSLayoutConstraint *bottomViewLeftConstraint;
@property (strong, nonatomic) NSLayoutConstraint *bottomViewRightConstraint;
@property (strong, nonatomic) NSLayoutConstraint *bottomViewBottomConstraint;
@property (strong, nonatomic) NSLayoutConstraint *bottomViewHeightConstraint;

@property (strong, nonatomic) UIButton *backButton;

@end

@implementation CSArchivesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.topView = [[UIView alloc] initWithFrame:CGRectZero];
    self.bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.topView.backgroundColor = [UIColor colorWithRed:74.0/255.0 green:76.0/255.0 blue:158.0/255.0 alpha:1];
    self.bottomView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];
    
    [self.view insertSubview:self.topView atIndex:0];
    [self.view insertSubview:self.bottomView atIndex:0];
    
    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.topViewLeftConstraint = [NSLayoutConstraint constraintWithItem:self.topView
                                                                 attribute:NSLayoutAttributeLeft
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeLeft
                                                                multiplier:1
                                                                  constant:-CGRectGetWidth(self.view.frame)];
    self.topViewRightConstraint = [NSLayoutConstraint constraintWithItem:self.topView
                                                                  attribute:NSLayoutAttributeRight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view
                                                                  attribute:NSLayoutAttributeRight
                                                                 multiplier:1
                                                                   constant:-CGRectGetWidth(self.view.frame)];
    self.topViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.topView
                                                                   attribute:NSLayoutAttributeTop
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeTop
                                                                  multiplier:1
                                                                    constant:0];
    self.topViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.topView
                                                                attribute:NSLayoutAttributeBottom
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.bottomView
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1
                                                                 constant:0];
    
    self.bottomViewLeftConstraint = [NSLayoutConstraint constraintWithItem:self.bottomView
                                                                 attribute:NSLayoutAttributeLeft
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeLeft
                                                                multiplier:1
                                                                  constant:CGRectGetWidth(self.view.frame)];
    self.bottomViewRightConstraint = [NSLayoutConstraint constraintWithItem:self.bottomView
                                                                  attribute:NSLayoutAttributeRight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view
                                                                  attribute:NSLayoutAttributeRight
                                                                 multiplier:1
                                                                   constant:CGRectGetWidth(self.view.frame)];
    self.bottomViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.bottomView
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1
                                                                 constant:CGRectGetWidth(self.view.frame)];
    self.bottomViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.bottomView
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1
                                                                    constant:0];
    
    [self.view addConstraints:@[self.topViewLeftConstraint, self.topViewRightConstraint, self.topViewTopConstraint, self.topViewBottomConstraint]];
    [self.view addConstraints:@[self.bottomViewLeftConstraint, self.bottomViewRightConstraint, self.bottomViewHeightConstraint, self.bottomViewBottomConstraint]];
    
    [self.topView layoutIfNeeded];
    [self.bottomView layoutIfNeeded];
    
    self.backButton = [[UIButton alloc] init];
    [self.backButton addTarget:self action:@selector(returnToHome:) forControlEvents:UIControlEventTouchUpInside];
    [self.backButton setImage:[UIImage imageNamed:@"iconBack"] forState:UIControlStateNormal];
    [self.backButton setImage:[UIImage imageNamed:@"iconBackOnpress"] forState:UIControlStateHighlighted];
    self.backButton.frame = CGRectMake(10.0, 20.0, 40.0, 40.0);
    [self.topView addSubview:self.backButton];
}

#pragma marks - IBActions

- (void)returnToHome:(id)sender {
    [self.backButton setSelected:!self.backButton.selected];
    [self performSegueWithIdentifier:@"unwindArchivesToHomeSegueID" sender:self];
}

#pragma marks - Transitions

- (void)openWith:(void (^)())completion {
    [PRTween tween:0 from:CGRectGetWidth(self.view.frame) to:0 duration:1 delay:0 timingFunction:PRTweenTimingFunctionExpoInOut updateBlock:^(PRTweenPeriod *period) {
        self.topViewLeftConstraint.constant = -period.tweenedValue;
        self.topViewRightConstraint.constant = -period.tweenedValue;
        
        self.bottomViewLeftConstraint.constant = period.tweenedValue;
        self.bottomViewRightConstraint.constant = period.tweenedValue;
    } completeBlock:^(BOOL finished) {
        if (finished && completion) {
            completion();
        }
    }];
}

- (void)closeWith:(void (^)())completion {
    [PRTween tween:0 from:0 to:CGRectGetWidth(self.view.frame) duration:1 delay:0 timingFunction:PRTweenTimingFunctionExpoInOut updateBlock:^(PRTweenPeriod *period) {
        self.topViewLeftConstraint.constant = -period.tweenedValue;
        self.topViewRightConstraint.constant = -period.tweenedValue;
        
        self.bottomViewLeftConstraint.constant = period.tweenedValue;
        self.bottomViewRightConstraint.constant = period.tweenedValue;
    } completeBlock:^(BOOL finished) {
        if (finished && completion) {
            completion();
        }
    }];
}

@end
