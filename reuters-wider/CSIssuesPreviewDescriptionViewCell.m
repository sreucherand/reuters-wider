//
//  CSIssuePreviewDescriptionViewCell.m
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 24/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSIssuesPreviewDescriptionViewCell.h"

@interface CSIssuesPreviewDescriptionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *issuesPreviewNumeroLabel;
@property (weak, nonatomic) IBOutlet UILabel *issuesPreviewHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *issuesPreviewDateLabel;

@end

@implementation CSIssuesPreviewDescriptionViewCell

- (void)hydrateWidthNumber:(NSInteger)number title:(NSString *)title date:(NSDate *)date {
    // Numero related
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Issue %ld", number]];
    
    [attributeString addAttribute:NSUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:1]
                            range:(NSRange){0,[attributeString length]}];
    
    [self.issuesPreviewNumeroLabel setFont:LEITURA_ROMAN_2];
    [self.issuesPreviewNumeroLabel setTextColor:ISSUE_NR_COLOR];
    [self.issuesPreviewNumeroLabel setAttributedText:attributeString];
    
    // Heading related
    [self.issuesPreviewHeaderLabel setText:title];
    [self.issuesPreviewHeaderLabel setFont:LEITURA_ROMAN_3_34];
    [self.issuesPreviewHeaderLabel setTextColor:BLACK_COLOR];
    
    // Date issue related
    NSAttributedString *attributedStringKerned = [[NSAttributedString alloc] initWithString:@"October 2014" attributes:@{NSKernAttributeName : @(0.75f)}];
    
    [self.issuesPreviewDateLabel setFont:LEITURA_ITALIC_1_15];
    [self.issuesPreviewDateLabel setTextColor:ISSUE_NR_COLOR];
    [self.issuesPreviewDateLabel setAttributedText:attributedStringKerned];
}

@end