//
//  CSTransitionBlockTableViewCell.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 31/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSTransitionBlockTableViewCell.h"

@interface CSTransitionBlockTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *topPartView;
@property (weak, nonatomic) IBOutlet UILabel *titleTopPart;
@property (weak, nonatomic) IBOutlet CSAttributedLabel *subtitleTopPart;
@property (weak, nonatomic) IBOutlet UIView *bottomPartView;
@property (weak, nonatomic) IBOutlet CSAttributedLabel *subtitleBottomPart;
@property (weak, nonatomic) IBOutlet UILabel *titleBottomPart;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *topPartGradient;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *bottomPartGradient;

@property (strong, nonatomic) NSNumber *state;

@end

@implementation CSTransitionBlockTableViewCell

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)awakeFromNib {
    // Top part related
    self.topPartView.backgroundColor = THIRD_PURPLE;
    
    self.titleTopPart.font = LEITURA_ITALIC_3_35;
    self.titleTopPart.textColor = DARK_BLUE;
    
    self.subtitleTopPart.font = CALIBRE_LIGHT_16;
    self.subtitleTopPart.textColor = DARK_BLUE;
    self.subtitleTopPart.lineHeight = 18;
    
    // Bottom part related
    self.bottomPartView.backgroundColor = FIRST_PURPLE;
    
    self.titleBottomPart.font = LEITURA_ITALIC_3_35;
    self.titleBottomPart.textColor = WHITE_COLOR;
    
    self.subtitleBottomPart.font = CALIBRE_LIGHT_16;
    self.subtitleBottomPart.textColor = WHITE_COLOR;
    self.subtitleBottomPart.lineHeight = 18;
    
    self.bottomPartGradient.direction = CSDirectionBottom;
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
    
    self.titleTopPart.text = [self.content.transitions[0] title];
    self.subtitleTopPart.text = [self.content.transitions[0] teasing];
    
    self.titleBottomPart.text = [self.content.transitions[1] title];
    self.subtitleBottomPart.text = [self.content.transitions[1] teasing];
}

- (void)hydrateWithContentData:(NSDictionary *)data forState:(NSNumber *)state {
    [super hydrateWithContentData:data forState:state];
    
    self.state = state;
    
    if ([state intValue] == 2) {
        self.titleTopPart.alpha = 1;
        self.subtitleTopPart.alpha = 1;
        
        self.titleBottomPart.alpha = 1;
        self.subtitleBottomPart.alpha = 1;
        
        self.topPartGradient.topColor = DARK_BLUE;
        self.bottomPartGradient.topColor = WHITE_COLOR;
    } else {
        self.titleTopPart.alpha = 0;
        self.subtitleTopPart.alpha = 0;
        
        self.titleBottomPart.alpha = 0;
        self.subtitleBottomPart.alpha = 0;
        
        [self.topPartGradient clearAnimation];
        [self.topPartGradient interpolateBetweenColor:[UIColor clearColor] andColor:DARK_BLUE withProgression:0];
        
        [self.bottomPartGradient clearAnimation];
        [self.bottomPartGradient interpolateBetweenColor:[UIColor clearColor] andColor:WHITE_COLOR withProgression:0];
    }
}

- (void)enter {
    if ([self.state intValue] == 2) {
        return;
    }
    
    [CSTween tweenFrom:0 to:1 duration:1 delay:1 timingFunction:CSTweenEaseOutExpo updateBlock:^(CSTweenOperation *operation) {
        self.titleTopPart.alpha = operation.value;
    } completeBlock:nil];
    [CSTween tweenFrom:0 to:1 duration:1 delay:1.5 timingFunction:CSTweenEaseOutExpo updateBlock:^(CSTweenOperation *operation) {
        self.subtitleTopPart.alpha = operation.value;
    } completeBlock:nil];
    [self.topPartGradient animateWidthDuration:1 delay:2 timingFunction:CSTweenEaseOutExpo completion:nil];
    
    [self.bottomPartGradient animateWidthDuration:1 delay:2.5 timingFunction:CSTweenEaseOutExpo completion:nil];
    [CSTween tweenFrom:0 to:1 duration:1 delay:3 timingFunction:CSTweenEaseOutExpo updateBlock:^(CSTweenOperation *operation) {
        self.subtitleBottomPart.alpha = operation.value;
    } completeBlock:nil];
    [CSTween tweenFrom:0 to:1 duration:1 delay:3.5 timingFunction:CSTweenEaseOutExpo updateBlock:^(CSTweenOperation *operation) {
        self.titleBottomPart.alpha = operation.value;
    } completeBlock:^(BOOL finished) {
        if (finished) {
            if ([self.delegate respondsToSelector:@selector(tableViewCell:rowNeedsPersistentState:)]) {
                [self.delegate performSelector:@selector(tableViewCell:rowNeedsPersistentState:) withObject:self withObject:[NSNumber numberWithInt:2]];
            }
        }
    }];
}

@end
