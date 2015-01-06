//
//  CSKeyfiguresBlockTableViewCell.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 31/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSKeyfiguresBlockTableViewCell.h"

@interface CSKeyfiguresBlockTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *contextLabel;

@end

@implementation CSKeyfiguresBlockTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = BLUE_COLOR;
    
    self.titleTextLabel.font = CALIBRE_REG_15;
    self.titleTextLabel.textColor = WHITE_COLOR;
    
    self.contextLabel.font = CALIBRE_REG_15;
    self.contextLabel.textColor = LIGHT_BLUE_COLOR;
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
    
    self.titleTextLabel.text = self.content.title;
    
    self.contextLabel.text = self.content.context;
}

@end
