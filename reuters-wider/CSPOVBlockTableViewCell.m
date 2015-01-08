//
//  CSPOVBlockTableViewCell.m
//  reuters-wider
//
//  Created by Clément Bardon on 27/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSPovBlockTableViewCell.h"
#import "CSGradientIndicatorView.h"
#import "CSBoucingView.h"

@interface CSPovBlockTableViewCell () <CSBoucingViewDelegate> {
    CGFloat _initialLeftQuoteConstraintConstant;
    CGFloat _initialRightQuoteConstraintConstant;
    
    CGFloat _expandedLeftQuoteConstraintConstant;
    CGFloat _expandedRightQuoteConstraintConstant;
    
    CGFloat _multiplier;
}

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UILabel *mainMetaLabel;
@property (weak, nonatomic) IBOutlet CSAttributedLabel *mainQuoteLabel;

@property (weak, nonatomic) IBOutlet UILabel *comparedMetaLabel;
@property (weak, nonatomic) IBOutlet CSAttributedLabel *comparedQuoteLabel;
@property (weak, nonatomic) IBOutlet CSAttributedLabel *comparedTextLabel;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *horizontalGradientIndicatorView;
@property (weak, nonatomic) IBOutlet UIView *horizontalDashView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *comparedQuoteLabelLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *comparedQuoteLabelRightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *comparedTextLabelLeftConstraint;

@property (strong, nonatomic) CSBoucingView *bouncingView;

@end

@implementation CSPovBlockTableViewCell

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        _initialLeftQuoteConstraintConstant = 145;
        _initialRightQuoteConstraintConstant = 95;
        
        _expandedLeftQuoteConstraintConstant = 25;
        _expandedRightQuoteConstraintConstant = -25;
        
        _multiplier = 1.5;
    }
    
    return self;
}

- (void)awakeFromNib {
    self.clipsToBounds = YES;
    
    self.mainView.backgroundColor = FIRST_PURPLE;
    
    self.mainMetaLabel.font = CALIBRE_LIGHT_14;
    self.mainMetaLabel.textColor = WHITE_DIMMED_COLOR;
    
    self.mainQuoteLabel.font = LEITURA_ROMAN_3_23;
    self.mainQuoteLabel.textColor = WHITE_COLOR;
    self.mainQuoteLabel.lineHeight = 28;
    
    self.comparedMetaLabel.font = CALIBRE_LIGHT_14;
    self.comparedMetaLabel.textColor = FIRST_PURPLE;
    
    self.comparedQuoteLabel.font = ARCHER_THIN_38;
    self.comparedQuoteLabel.lineHeight = 38;
    
    self.comparedTextLabel.font = LEITURA_ROMAN_1_16;
    self.comparedTextLabel.textColor = RED_ORANGE;
    self.comparedTextLabel.lineHeight = 25;
    
    self.horizontalDashView.backgroundColor = [RED_ORANGE colorWithAlphaComponent:0.2];
    
    self.horizontalGradientIndicatorView.topColor = [DARK_BLUE colorWithAlphaComponent:0.2];
    self.horizontalGradientIndicatorView.direction = CSDirectionLeft;
}

- (void)switchToNormalMode {
    [super switchToNormalMode];
    
    self.comparedQuoteLabel.textColor = [UIColor colorWithPatternImage:[self imageGradient:self.comparedQuoteLabel.bounds topColor:FIRST_PURPLE bottomColor:RED_ORANGE]];
}

- (void)switchToNightMode {
    [super switchToNightMode];
    
    self.mainView.backgroundColor = FOURTH_PURPLE;
    self.mainMetaLabel.textColor = PURPLE_GREY;
    self.mainQuoteLabel.textColor = WHITE_COLOR;
    self.comparedMetaLabel.textColor = FIRST_PURPLE;
    self.comparedQuoteLabel.textColor = [UIColor colorWithPatternImage:[self imageGradient:self.comparedQuoteLabel.bounds topColor:WHITE_COLOR bottomColor:RED_ORANGE]];
    self.comparedTextLabel.textColor = RED_ORANGE;
    self.horizontalGradientIndicatorView.topColor = WHITE_COLOR;
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
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setLocale:EN_LOCALE];
    [dateFormat setDateFormat:@"d'%s' LLLL"];
    
    NSDate *formattedDate = [self.content.views[0] formattedDate];
    NSString *date = [dateFormat stringFromDate:formattedDate];
    NSInteger day = [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:formattedDate];
    
    NSString *suffix = @"th";
    
    switch (day) {
        case 1:
        case 21:
        case 31:
            suffix = @"st";
            break;
        case 2:
        case 22:
            suffix = @"nd";
            break;
        case 3:
        case 23:
            suffix = @"rd";
            break;
        default:
            break;
    }
    
    self.mainMetaLabel.text = [NSString stringWithFormat:@"%@, by %@", [date stringByReplacingOccurrencesOfString:@"%s" withString:suffix], [self.content.views[0] author]];
    self.mainQuoteLabel.text = [self.content.views[0] quote];
    
    formattedDate = [self.content.views[1] formattedDate];
    date = [dateFormat stringFromDate:formattedDate];
    day = [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:formattedDate];
    
    self.comparedMetaLabel.text = [NSString stringWithFormat:@"%@, by %@", [date stringByReplacingOccurrencesOfString:@"%s" withString:suffix], [self.content.views[1] author]];
    self.comparedQuoteLabel.text = [self.content.views[1] quote];
    
    [self.comparedQuoteLabel setNeedsLayout];
    [self.comparedQuoteLabel layoutIfNeeded];
    
    self.comparedQuoteLabel.textColor = [UIColor colorWithPatternImage:[self imageGradient:self.comparedQuoteLabel.bounds topColor:FIRST_PURPLE bottomColor:RED_ORANGE]];
    
    self.bouncingView = [[CSBoucingView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(self.comparedQuoteLabel.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.comparedQuoteLabel.frame))];
    
    self.bouncingView.delegate = self;
    
    [self.bottomView addSubview:self.bouncingView];
}

- (void)hydrateWithContentData:(NSDictionary *)data forState:(NSNumber *)state {
    [super hydrateWithContentData:data forState:state];
    
    if ([state intValue] == 1) {
        self.bouncingView.direction = CSDirectionRight;
        
        self.comparedTextLabel.text = [NSString stringWithFormat:@"\n%@", [self.content.views[1] text]];
        
        self.comparedQuoteLabelLeftConstraint.constant = _expandedLeftQuoteConstraintConstant;
        self.comparedQuoteLabelRightConstraint.constant = _expandedRightQuoteConstraintConstant;
        
        self.comparedTextLabelLeftConstraint.constant = 0;
    } else {
        self.bouncingView.direction = CSDirectionLeft;
        
        self.comparedTextLabel.text = @"";
        
        self.comparedQuoteLabelLeftConstraint.constant = _initialLeftQuoteConstraintConstant;
        self.comparedQuoteLabelRightConstraint.constant = _initialRightQuoteConstraintConstant;
        
        self.comparedTextLabelLeftConstraint.constant = CGRectGetWidth(self.frame) - _expandedLeftQuoteConstraintConstant;
    }
}

#pragma mark - Boucing view delegate

- (void)boucingViewDidScroll:(CSBoucingView *)boucingView {
    CGPoint offset = boucingView.contentOffset;
    
    if (self.bouncingView.direction == CSDirectionLeft) {
        if (boucingView.contentOffset.x >= 0) {
            offset.x = 0;
        }
        
        CGFloat left = fmax(_initialLeftQuoteConstraintConstant + offset.x*_multiplier, _expandedLeftQuoteConstraintConstant);
        CGFloat right = fmax(_initialRightQuoteConstraintConstant + offset.x*_multiplier, _expandedRightQuoteConstraintConstant);
        
        self.comparedQuoteLabelLeftConstraint.constant = left;
        self.comparedQuoteLabelRightConstraint.constant = right;
    } else if (self.bouncingView.direction == CSDirectionRight) {
        if (boucingView.contentOffset.x <= 0) {
            offset.x = 0;
        }
        
        CGFloat left = fmin(_expandedLeftQuoteConstraintConstant + offset.x*_multiplier, _initialLeftQuoteConstraintConstant);
        CGFloat right = fmin(_expandedRightQuoteConstraintConstant + offset.x*_multiplier, _initialRightQuoteConstraintConstant);
        
        self.comparedQuoteLabelLeftConstraint.constant = left;
        self.comparedQuoteLabelRightConstraint.constant = right;
    }
}

- (void)boucingViewWillBeginDecelarating:(CSBoucingView *)boucingView {
    if (self.bouncingView.direction == CSDirectionLeft) {
        CGFloat left = fmax(_initialLeftQuoteConstraintConstant + boucingView.contentOffset.x*_multiplier, _expandedLeftQuoteConstraintConstant);
        
        if (left <= _expandedLeftQuoteConstraintConstant) {
            self.bouncingView.scrollEnabled = NO;
            self.bouncingView.direction = CSDirectionRight;
            
            self.comparedTextLabel.text = [NSString stringWithFormat:@"\n%@", [self.content.views[1] text]];
            
            [CSTween tweenFrom:CGRectGetWidth(self.frame) - _expandedLeftQuoteConstraintConstant to:0 duration:1 delay:0.2 timingFunction:CSTweenEaseOutExpo updateBlock:^(CSTweenOperation *operation) {
                self.comparedTextLabelLeftConstraint.constant = operation.value;
            } completeBlock:^(BOOL finished) {
                if (finished) {
                    self.bouncingView.scrollEnabled = YES;
                }
            }];
            
            if ([self.delegate respondsToSelector:@selector(tableViewCell:rowNeedsPersistentState:)]) {
                [self.delegate performSelector:@selector(tableViewCell:rowNeedsPersistentState:) withObject:self withObject:[NSNumber numberWithInt:1]];
            }
            
            [self.tableView beginUpdates];
            [self.tableView endUpdates];
        }
    } else if (self.bouncingView.direction == CSDirectionRight) {
        CGFloat left = fmin(_expandedLeftQuoteConstraintConstant + boucingView.contentOffset.x*_multiplier, _initialLeftQuoteConstraintConstant);
        
        if (left >= _initialLeftQuoteConstraintConstant) {
            self.bouncingView.scrollEnabled = NO;
            self.bouncingView.direction = CSDirectionLeft;
            
            [CSTween tweenFrom:0 to:CGRectGetWidth(self.frame) - _expandedLeftQuoteConstraintConstant duration:0.5 delay:0 timingFunction:CSTweenEaseInExpo updateBlock:^(CSTweenOperation *operation) {
                self.comparedTextLabelLeftConstraint.constant = operation.value;
            } completeBlock:^(BOOL finished) {
                if (finished) {
                    self.bouncingView.scrollEnabled = YES;
                    
                    self.comparedTextLabel.text = @"";
                    
                    [self.tableView beginUpdates];
                    [self.tableView endUpdates];
                }
            }];
            
            if ([self.delegate respondsToSelector:@selector(tableViewCell:rowNeedsPersistentState:)]) {
                [self.delegate performSelector:@selector(tableViewCell:rowNeedsPersistentState:) withObject:self withObject:[NSNumber numberWithInt:0]];
            }
        }
    }
}

#pragma mark - Gradient

- (UIImage *)imageGradient:(CGRect)rect topColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor {
    CGSize size = rect.size;
    
    size.width = fmax(size.width, 20);
    size.height = fmax(size.height, 20);
    
    UIGraphicsBeginImageContext(size);
    
    CGFloat locations[2];
    
    locations[0] = 0;
    locations[1] = 1;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    
    UIGraphicsPushContext(context);
    
    NSMutableArray *colors = [[NSMutableArray alloc] initWithCapacity:2];
    
    [colors addObject:(id)[topColor CGColor]];
    [colors addObject:(id)[bottomColor CGColor]];
    
    CGGradientRef gradient = CGGradientCreateWithColors(space, (CFArrayRef)colors, locations);
    
    CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(0, size.height), 0);
    
    CGColorSpaceRelease(space);
    CGGradientRelease(gradient);
    
    UIGraphicsPopContext();
    
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return  gradientImage;
}

@end
