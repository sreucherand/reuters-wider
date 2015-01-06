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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *articleImageHeightConstraint;

@end

@implementation CSImageBlockTableViewCell

- (void)awakeFromNib {
    self.gradientIndicatorView.topColor = DARK_BLUE;
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
    
    UIImage *image = [UIImage imageNamed:self.content.image];
    
    CGFloat ratio = image.size.height/image.size.width;
    
    self.articleImageView.image = image;
    self.articleImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.articleImageHeightConstraint.constant = CGRectGetWidth(self.frame)*ratio;
}

@end
