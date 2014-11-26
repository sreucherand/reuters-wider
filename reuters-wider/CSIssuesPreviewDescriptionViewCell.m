//
//  CSIssuePreviewDescriptionViewCell.m
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 24/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSIssuesPreviewDescriptionViewCell.h"

@implementation CSIssuesPreviewDescriptionViewCell

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Numero related
    [self.issuesPreviewNumeroLabel setFont:LEITURA_ROMAN_2];
    [self.issuesPreviewNumeroLabel setTextColor:ISSUE_NR_COLOR];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"Issue 31"];
    
    [attributeString addAttribute:NSUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:1]
                            range:(NSRange){0,[attributeString length]}];
    
    self.issuesPreviewNumeroLabel.attributedText = [attributeString copy];
    
    // Heading related
    [self.issuesPreviewHeaderLabel setFont:LEITURA_ROMAN_3_34];
    [self.issuesPreviewHeaderLabel setTextColor:BLACK_COLOR];
    
    // Date issue related
    [self.issuesPreviewDateLabel setFont:LEITURA_ITALIC_1_15];
    [self.issuesPreviewDateLabel setTextColor:ISSUE_NR_COLOR];
    
    NSAttributedString *attributedStringKerned = [[NSAttributedString alloc] initWithString:@"October 2014" attributes:@{NSKernAttributeName : @(0.75f)}];
    
    self.issuesPreviewDateLabel.attributedText = attributedStringKerned;
}

@end
