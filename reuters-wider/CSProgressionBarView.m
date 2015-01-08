//
//  CSProgressionBarView.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 04/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import "CSProgressionBarView.h"

@interface CSProgressionBarView ()

@property (strong, nonatomic) UIColor *foregroundColor;

@end

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readModeNeedsUpdate:) name:@"readModeUpdateNotification" object:nil];
    
    [self initStyle];
}

- (void)initStyle {
    self.backgroundColor = SECOND_PURPLE;
    self.foregroundColor = FIRST_PURPLE;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Setters

- (void)setProgression:(CGFloat)progression {
    _progression = progression;
    
    [self setNeedsDisplay];
}

#pragma mark - Switch read mode

- (void)readModeNeedsUpdate:(NSNotification *)sender {
    if ([[sender.userInfo objectForKey:@"mode"] isEqualToString:@"night"]) {
        self.backgroundColor = FIRST_PURPLE;
        self.foregroundColor = FOURTH_PURPLE;
    } else {
        [self initStyle];
    }
    
    [self setNeedsDisplay];
}

/*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation. */
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, self.foregroundColor.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)*self.progression));
}

@end
