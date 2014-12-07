//
//  CSParagraphBlockTableViewCell.m
//  reuters-wider
//
//  Created by Clément Bardon on 27/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSParagraphBlockTableViewCell.h"

@interface CSParagraphBlockTableViewCell () <CSAttributedLabelDelegate>

@property (weak, nonatomic) IBOutlet CSAttributedLabel *paragraphTextLabel;

@end

@implementation CSParagraphBlockTableViewCell

-(void)awakeFromNib {
    self.paragraphTextLabel.font = LEITURA_ROMAN_1_16;
    self.paragraphTextLabel.textColor = GREY_COLOR;
    self.paragraphTextLabel.lineHeight = 25;
    self.paragraphTextLabel.delegate = self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)hydrateWithContentData:(NSDictionary *)data {
    [super hydrateWithContentData:data];
    
    self.paragraphTextLabel.text = self.content.text;
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    if ([self.delegate respondsToSelector:@selector(didSelectLinkWithURL:)]) {
        [self.delegate performSelector:@selector(didSelectLinkWithURL:) withObject:url];
    }
}

@end
