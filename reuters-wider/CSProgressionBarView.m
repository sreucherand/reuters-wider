//
//  CSProgressionBarView.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 04/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import "CSProgressionBarView.h"

@implementation CSProgressionBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.backgroundColor = BLUE_PROGRESSION_BAR_COLOR;
}

#pragma mark - Setters

- (void)setProgression:(CGFloat)progression {
    _progression = progression;
    
    [self setNeedsDisplay];
}

/*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation. */
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, BLUE_COLOR.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)*self.progression));
}

@end
