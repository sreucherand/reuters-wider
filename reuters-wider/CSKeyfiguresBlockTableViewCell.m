//
//  CSKeyfiguresBlockTableViewCell.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 31/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSKeyfiguresBlockTableViewCell.h"

@interface CSKeyfiguresBlockTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleText;


@end

@implementation CSKeyfiguresBlockTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = BLUE_COLOR;
    
    self.titleText.font = CALIBRE_REG_15;
    self.titleText.textColor = WHITE_COLOR;
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
    
    self.titleText.text = self.content.title;
}

@end
