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
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Issue %i", (int)number]];
    
    [attributeString addAttribute:NSUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:1]
                            range:(NSRange){0,[attributeString length]}];
    
    [self.issuesPreviewNumeroLabel setFont:LEITURA_ROMAN_3_19];
    [self.issuesPreviewNumeroLabel setTextColor:DARK_GREY];
    [self.issuesPreviewNumeroLabel setAttributedText:attributeString];
    
    // Heading related
    [self.issuesPreviewHeaderLabel setText:title];
    [self.issuesPreviewHeaderLabel setFont:LEITURA_ROMAN_3_35];
    [self.issuesPreviewHeaderLabel setTextColor:BLACK_COLOR];
    
    // Date issue related
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setLocale:EN_LOCALE];
    [dateFormat setDateFormat:@"MMMM yyyy"];
    
    NSAttributedString *attributedStringKerned = [[NSAttributedString alloc] initWithString:[dateFormat stringFromDate:date] attributes:@{NSKernAttributeName : @(0.75f)}];
    
    [self.issuesPreviewDateLabel setFont:LEITURA_ITALIC_1_15];
    [self.issuesPreviewDateLabel setTextColor:DARK_GREY];
    [self.issuesPreviewDateLabel setAttributedText:attributedStringKerned];
}

@end
