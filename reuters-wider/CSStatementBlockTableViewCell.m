//
//  CSStatementBlockTableViewCell.m
//  reuters-wider
//
//  Created by Clément Bardon on 27/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSStatementBlockTableViewCell.h"
#import "CSGradientIndicatorView.h"

@interface CSStatementBlockTableViewCell ()

@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *gradientView;
@property (weak, nonatomic) IBOutlet CSAttributedLabel *statementLabel;

@end

@implementation CSStatementBlockTableViewCell

-(void)awakeFromNib{
    self.gradientView.topColor = LIGHT_BLUE_COLOR;
    
    self.statementLabel.font = LEITURA_ITALIC_2_20;
    self.statementLabel.textColor = BLUE_COLOR;
    self.statementLabel.textAlignment = NSTextAlignmentCenter;
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
    
    self.statementLabel.text = self.content.text;
}

@end
