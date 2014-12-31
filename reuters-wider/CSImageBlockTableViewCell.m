//
//  CSImageBlockTableViewCell.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 31/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSImageBlockTableViewCell.h"
#import "CSGradientIndicatorView.h"

@interface CSImageBlockTableViewCell ()

@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *gradientIndicatorView;
@property (weak, nonatomic) IBOutlet UIImageView *articleImageView;

@end

@implementation CSImageBlockTableViewCell

- (void)awakeFromNib {
    self.gradientIndicatorView.topColor = BLUE_COLOR;
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
    
    self.articleImageView.image = [UIImage imageNamed:self.content.image];
    
    [self.articleImageView sizeToFit];
}

@end
