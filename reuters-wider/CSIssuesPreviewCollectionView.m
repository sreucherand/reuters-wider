//
//  CSIssuePreviewCollectionView.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 23/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSIssuesPreviewCollectionView.h"

@interface CSIssuesPreviewCollectionView () <UIGestureRecognizerDelegate>

@end

@implementation CSIssuesPreviewCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.frame);
    
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UICollectionViewCell *cell = obj;
        
        if ([cell.reuseIdentifier isEqualToString:@"DescriptionViewCellID"]) {
            NSIndexPath *indexPath = [self indexPathForCell:cell];
            
            cell.frame = CGRectMake(width*2*indexPath.row/2-self.contentOffset.x, cell.frame.origin.y, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame));
        }
    }];
}

#pragma marks - UIPanGestureRecognizer

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint velocity = [(UIPanGestureRecognizer *)gestureRecognizer velocityInView:self];
    
    if (fabs(velocity.y) < fabs(velocity.x)) {
        return YES;
    }
    
    return NO;
}

@end
