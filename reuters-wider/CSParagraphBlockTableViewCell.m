//
//  CSParagraphBlockTableViewCell.m
//  reuters-wider
//
//  Created by Clément Bardon on 27/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSParagraphBlockTableViewCell.h"

@interface CSParagraphBlockTableViewCell () <UIGestureRecognizerDelegate, CSAttributedLabelDelegate>
{
    CGPoint linkPoint;
}

@property (weak, nonatomic) IBOutlet CSAttributedLabel *paragraphTextLabel;

@end

@implementation CSParagraphBlockTableViewCell

-(void)awakeFromNib {
    self.paragraphTextLabel.font = LEITURA_ROMAN_1_16;
    self.paragraphTextLabel.textColor = GREY_COLOR;
    self.paragraphTextLabel.lineHeight = 25;
    self.paragraphTextLabel.delegate = self;
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] init];
    
    gestureRecognizer.delegate = self;
    
    [self.paragraphTextLabel addGestureRecognizer:gestureRecognizer];
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

#pragma mark - Gesture delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([self.paragraphTextLabel containslinkAtPoint:[touch locationInView:self.paragraphTextLabel]]) {
        linkPoint = [touch locationInView:self.superview]; // Content view
        
        return NO;
    }
    
    return YES;
}

#pragma mark - Attributed label delegate

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    if ([self.delegate respondsToSelector:@selector(didSelectLinkWithURL:atPoint:)]) {
        [self.delegate performSelector:@selector(didSelectLinkWithURL:atPoint:) withObject:url withObject:[NSValue valueWithCGPoint:linkPoint]];
    }
}

@end
