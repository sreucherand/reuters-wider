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

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *gradientView;

@end

@implementation CSTestBlockTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)hydrateWithContentData:(NSDictionary *)data {
    [super hydrateWithHeadingData:data];
    
    self.textView.text = self.content.text;
}

@end
