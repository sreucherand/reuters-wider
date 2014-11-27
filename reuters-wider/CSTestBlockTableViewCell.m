//
//  CSTestBlockTableViewCell.m
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 27/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSTestBlockTableViewCell.h"
#import "CSGradientIndicatorView.h"

@interface CSTestBlockTableViewCell ()

@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *gradientView;

@end

@implementation CSTestBlockTableViewCell

- (instancetype)init {
    self = [super init];
    
    if (self) {
        NSLog(@"init");
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.gradientView.topColor = [UIColor redColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
