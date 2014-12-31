//
//  CSPOVBlockTableViewCell.m
//  reuters-wider
//
//  Created by Clément Bardon on 27/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSPovBlockTableViewCell.h"

@interface CSPovBlockTableViewCell ()
{
    CGSize gradientSize;
}

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UILabel *mainMetaLabel;
@property (weak, nonatomic) IBOutlet CSAttributedLabel *mainTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *comparedMetaLabel;
@property (weak, nonatomic) IBOutlet CSAttributedLabel *comparedTextLabel;

@end

@implementation CSPovBlockTableViewCell

- (void)awakeFromNib {
    self.mainView.backgroundColor = MIDDLE_BLUE_COLOR;
    
    self.mainMetaLabel.font = CALIBRE_LIGHT_14;
    self.mainMetaLabel.textColor = WHITE_COLOR;
    
    self.mainTextLabel.font = LEITURA_ROMAN_2_23;
    self.mainTextLabel.textColor = WHITE_COLOR;
    self.mainTextLabel.lineHeight = 28;
    
    self.comparedMetaLabel.font = CALIBRE_LIGHT_14;
    self.comparedMetaLabel.textColor = BLUE_COLOR;
    
    self.comparedTextLabel.font = ARCHER_THIN_38;
    self.comparedTextLabel.lineHeight = 34;
    //[self.comparedTextLabel textColorWithGradienFromColor:TEXT_GRADIENT_BLUE_COLOR toColor:TEXT_GRADIENT_ORANGE_COLOR];
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
    
    date = [date stringByReplacingOccurrencesOfString:@"%s" withString:suffix];
    
    self.mainMetaLabel.text = [NSString stringWithFormat:@"%@, by %@", date, [self.content.views[0] author]];
    self.mainTextLabel.text = [self.content.views[0] text];
    
    self.comparedMetaLabel.text = [NSString stringWithFormat:@"By %@", [self.content.views[1] author]];
    self.comparedTextLabel.text = [self.content.views[1] text];
}

@end
