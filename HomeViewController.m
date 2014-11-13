//
//  HomeViewController.m
//  reuters-wider
//
//  Created by BARDON Clement on 12/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "HomeViewController.h"
#import "Variables.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize filterButton;
@synthesize issueLabel;
@synthesize headingLabel;
@synthesize issueDateLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    // Issue number related
    [issueLabel setFont:LEITURA_ROMAN_2];
    [issueLabel setTextColor:ISSUE_NR_COLOR];
    issueLabel.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"Issue 31"];
    [attributeString addAttribute:NSUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:1]
                            range:(NSRange){0,[attributeString length]}];
    
    issueLabel.attributedText = [attributeString copy];
    
    // Heading related
    [headingLabel setFont:LEITURA_ROMAN_3_34];
    [headingLabel setTextColor:BLACK_COLOR];
    headingLabel.textAlignment = NSTextAlignmentCenter;
    headingLabel.text = @"Hong-Kong for democracy";
    
    // Date issue related
    [issueDateLabel setFont:LEITURA_ITALIC_1_15];
    [issueDateLabel setTextColor:ISSUE_NR_COLOR];
    issueDateLabel.textAlignment = NSTextAlignmentCenter;
    
    NSAttributedString *attributedStringKerned = [[NSAttributedString alloc] initWithString:@"October 2014" attributes:@{NSKernAttributeName : @(0.75f)}];

    issueDateLabel.attributedText = attributedStringKerned;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
