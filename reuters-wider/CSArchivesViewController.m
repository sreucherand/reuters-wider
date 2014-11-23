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
@property (strong, nonatomic) NSLayoutConstraint *topViewHeightConstraint;

@property (strong, nonatomic) NSLayoutConstraint *bottomViewLeftConstraint;
@property (strong, nonatomic) NSLayoutConstraint *bottomViewRightConstraint;
@property (strong, nonatomic) NSLayoutConstraint *bottomViewTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *bottomViewBottomConstraint;

@end

@implementation CSArchivesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.topView = [[UIView alloc] initWithFrame:CGRectZero];
    self.bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.topView.backgroundColor = [UIColor redColor];
    self.bottomView.backgroundColor = [UIColor blueColor];
    
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
    self.topViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.topView
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1
                                                                 constant:200];
    
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
    self.bottomViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.bottomView
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.topView
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1
                                                                 constant:0];
    self.bottomViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.bottomView
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1
                                                                    constant:0];
    
    [self.view addConstraints:@[self.topViewLeftConstraint, self.topViewRightConstraint, self.topViewTopConstraint, self.topViewHeightConstraint]];
    [self.view addConstraints:@[self.bottomViewLeftConstraint, self.bottomViewRightConstraint, self.bottomViewTopConstraint, self.bottomViewBottomConstraint]];
    
    [self.topView layoutIfNeeded];
    [self.bottomView layoutIfNeeded];
}

#pragma marks - IBActions

- (IBAction)returnToHome:(id)sender {
    [self performSegueWithIdentifier:@"UnwindToHomeSegueIdentifier" sender:self];
}

#pragma marks - Transitions

- (void)openWith:(void (^)())completion {
    [self.topView setEasingFunction:easeInOutExpo forKeyPath:@"center"];
    [self.bottomView setEasingFunction:easeInOutExpo forKeyPath:@"center"];
    
    self.topViewLeftConstraint.constant = 0;
    self.topViewRightConstraint.constant = 0;
    
    self.bottomViewLeftConstraint.constant = 0;
    self.bottomViewRightConstraint.constant = 0;
    
    [UIView animateWithDuration:1 animations:^{
        [self.topView layoutIfNeeded];
        [self.bottomView layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished && completion) {
            completion();
        }
    }];
}

- (void)closeWith:(void (^)())completion {
    self.topViewLeftConstraint.constant = -CGRectGetWidth(self.view.frame);
    self.topViewRightConstraint.constant = -CGRectGetWidth(self.view.frame);
    
    self.bottomViewLeftConstraint.constant = CGRectGetWidth(self.view.frame);
    self.bottomViewRightConstraint.constant = CGRectGetWidth(self.view.frame);
    
    [UIView animateWithDuration:1 animations:^{
        [self.topView layoutIfNeeded];
        [self.bottomView layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            completion();
        }
        
        [self.topView removeEasingFunctionForKeyPath:@"center"];
        [self.bottomView removeEasingFunctionForKeyPath:@"center"];
    }];
}

@end
