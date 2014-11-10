//
//  CSViewController.m
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 10/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSViewController.h"
#import "CSArchivesTransition.h"
#import "CSArchivesViewController.h"

@interface CSViewController ()

@end

@implementation CSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    CSArchivesViewController *destinationViewController = [segue destinationViewController];
    
    ((CSArchivesTransition *)segue).width = CGRectGetWidth(destinationViewController.view.frame);
}


@end
