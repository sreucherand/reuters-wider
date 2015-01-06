//
//  CSKeyfiguresBlockTableViewCell.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 31/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSKeyfiguresBlockTableViewCell.h"
#import "CSPagingScrollViewContainerView.h"
#import "CSKeyfigureKeyView.h"
#import "CSGradientIndicatorView.h"

@interface CSKeyfiguresBlockTableViewCell () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet CSPagingScrollViewContainerView *containerScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleTextLabel;
@property (weak, nonatomic) IBOutlet CSAttributedLabel *contextLabel;

@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *topGradientIndicatorView;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *middleGradientIndicatorView;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *bottomGradientIndicatorView;

@property (strong, nonatomic) NSArray *scrollViewSubviews;

@end

@implementation CSKeyfiguresBlockTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = BLUE_COLOR;
    
    self.titleTextLabel.font = CALIBRE_REG_15;
    self.titleTextLabel.textColor = WHITE_COLOR;
    
    self.contextLabel.font = CALIBRE_REG_15;
    self.contextLabel.textColor = LIGHT_BLUE_COLOR;
    self.contextLabel.lineHeight = 20;
    
    self.topGradientIndicatorView.topColor = LIGHT_BLUE_COLOR;
    
    self.middleGradientIndicatorView.topColor = LIGHT_BLUE_COLOR;
    self.middleGradientIndicatorView.direction = CSDirectionBottom;
    
    self.bottomGradientIndicatorView.topColor = LIGHT_BLUE_COLOR;
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
    
    [self.scrollView layoutIfNeeded];
    
    for (UIView *subview in self.scrollView.subviews) {
        [subview removeFromSuperview];
    }
    
    UIView *views[[self.content.keys count]];
    
    self.scrollViewSubviews = nil;
    
    NSMutableArray *subviews = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[self.content.keys count]; i++) {
        CSBlockContentModel *model = [self.content.keys objectAtIndex:i];
        
        views[i] = [[[NSBundle mainBundle] loadNibNamed:@"CSKeyfigureKeyView" owner:self options:nil] lastObject];
        [views[i] setFrame:CGRectMake(CGRectGetWidth(self.scrollView.frame)*i, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame))];
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        
        [formatter setUsesGroupingSeparator:YES];
        [formatter setGroupingSize:3];
        
        ((CSKeyfigureKeyView *)views[i]).valueLabel.text = [formatter stringFromNumber:[NSNumber numberWithInt:model.data]];
        ((CSKeyfigureKeyView *)views[i]).labelLabel.text = model.label;
        
        [self.scrollView addSubview:views[i]];
        
        [subviews addObject:views[i]];
    }
    
    self.scrollViewSubviews = [NSArray arrayWithArray:subviews];
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame)*[self.content.keys count], CGRectGetHeight(self.scrollView.frame));
    self.scrollView.delegate = self;
    self.scrollView.userInteractionEnabled = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.clipsToBounds = NO;
    
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.scrollView.frame), 0) animated:NO];
    
    [self interpolateItemsAlpha:self.scrollView];
    
    self.containerScrollView.scrollView = self.scrollView;
}

- (void)interpolateItemsAlpha:(UIScrollView *)scrollView {
    for (UIView *subview in self.scrollViewSubviews) {
        CGFloat x = (CGRectGetMinX(subview.frame) - self.scrollView.contentOffset.x);
        CGFloat relativeX = x/(CGRectGetWidth(subview.frame)*2) + 1.0/2;
        
        subview.alpha = relativeX < 0 || relativeX > 1 ? 0.25 : 5.0/8 + 3*cos(M_PI*2*relativeX + M_PI)/8;
    }
}

#pragma mark - Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self interpolateItemsAlpha:scrollView];
}

@end
