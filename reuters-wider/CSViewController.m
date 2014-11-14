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
#import "CSArchivesViewBackTransition.h"

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

-(IBAction)returnedFromSegue:(UIStoryboardSegue*)sender
{
    NSLog(@"unwound from custom segue controller");
}

- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier {
    
    if ([identifier isEqualToString:@"UnwindToHomeSegueIdentifier"]) {
        CSArchivesViewBackTransition *segue = [[CSArchivesViewBackTransition alloc] initWithIdentifier:identifier source:fromViewController destination:toViewController];
        return segue;
    }
    
    return [super segueForUnwindingToViewController:toViewController fromViewController:fromViewController identifier:identifier];
}


@end
