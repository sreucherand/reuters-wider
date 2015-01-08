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
    CGFloat _leftConstraintConstantInitialValue;
    CGFloat _rightConstraintConstantInitialValue;
}

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *mainMetaLabel;
@property (weak, nonatomic) IBOutlet CSAttributedLabel *mainQuoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *comparedMetaLabel;
@property (weak, nonatomic) IBOutlet CSAttributedLabel *comparedQuoteLabel;
@property (weak, nonatomic) IBOutlet CSAttributedLabel *comparedTextLabel;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *horizontalGradientIndicatorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *comparedTextLabelLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *comparedTextLabelRightConstraint;

@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation CSPovBlockTableViewCell

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
    
    self.horizontalGradientIndicatorView.topColor = DARK_BLUE;
    self.horizontalGradientIndicatorView.direction = CSDirectionLeft;
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
    
    CSBoucingView *view = [[CSBoucingView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.comparedQuoteLabel.frame), CGRectGetMinY(self.comparedQuoteLabel.frame), CGRectGetWidth(self.frame) - CGRectGetMinX(self.comparedQuoteLabel.frame), CGRectGetHeight(self.comparedQuoteLabel.frame))];
    
    view.delegate = self;
    
    [self.bottomView addSubview:view];
    
    _leftConstraintConstantInitialValue = self.comparedTextLabelLeftConstraint.constant;
    _rightConstraintConstantInitialValue = self.comparedTextLabelRightConstraint.constant;
    
    if ([self.state intValue] == 2) {
        self.backgroundColor = [UIColor yellowColor];
    }
}

#pragma mark - Boucing view delegate

- (void)boucingViewDidScroll:(CSBoucingView *)boucingView {
    CGFloat left = fmax(_leftConstraintConstantInitialValue + boucingView.contentOffset.x*1.5, 25);
    CGFloat right = fmax(_rightConstraintConstantInitialValue + boucingView.contentOffset.x*1.5, -25);
    
    if (boucingView.contentOffset.x <= 0) {
        self.comparedTextLabelLeftConstraint.constant = left;
        self.comparedTextLabelRightConstraint.constant = right;
    }
}

- (void)boucingViewWillBeginDecelarating:(CSBoucingView *)boucingView {
    CGFloat left = fmax(_leftConstraintConstantInitialValue + boucingView.contentOffset.x*1.5, 25);
    
    if (left <= 25) {
        boucingView.muted = YES;
        
//        [self.tableView beginUpdates];
//        [self.tableView endUpdates];
//
    
//        [self.tableView reloadData];
        if ([self.delegate respondsToSelector:@selector(tableViewCell:rowNeedsPersistentState:)]) {
            [self.delegate performSelector:@selector(tableViewCell:rowNeedsPersistentState:) withObject:self withObject:[NSNumber numberWithInt:2]];
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
