//
//  CSIssuePreviewCollectionView.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 23/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSIssuesPreviewCollectionView.h"

@interface CSIssuesPreviewCollectionView () <UIGestureRecognizerDelegate>

@property (assign, nonatomic) CGPoint origin;

@property (strong, nonatomic) UIPanGestureRecognizer* verticalPanGestureRecognizer;
@property (strong, nonatomic) UIView *transitionView;
@property (strong, nonatomic) UIImageView *transitionViewImageView;
@property (strong, nonatomic) UILabel *transitionViewButtonView;

@end

@implementation CSIssuesPreviewCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    self.verticalPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(coucou:)];
    
    [self addGestureRecognizer:self.verticalPanGestureRecognizer];
    
    self.verticalPanGestureRecognizer.delegate = self;
    
    self.transitionView = [[UIView alloc] initWithFrame:CGRectZero];
    self.transitionView.backgroundColor = [UIColor whiteColor];
    
    self.transitionViewImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.transitionViewButtonView = [[UILabel alloc] initWithFrame:CGRectZero];
    
    self.transitionViewButtonView.text = @"Read";
    self.transitionViewButtonView.textAlignment = NSTextAlignmentCenter;
    
    [self.transitionView addSubview:self.transitionViewImageView];
    [self.transitionView addSubview:self.transitionViewButtonView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UICollectionViewCell *cell = obj;
        
        if ([cell.reuseIdentifier isEqualToString:@"DescriptionViewCellID"]) {
            NSIndexPath *indexPath = [self indexPathForCell:cell];
            
            cell.frame = CGRectMake(width*2*indexPath.item/2-self.contentOffset.x, cell.frame.origin.y, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame));
        }
    }];
    
    self.transitionView.frame = CGRectMake(0, CGRectGetHeight(self.superview.frame)-width, width, height);
    self.transitionViewImageView.frame = (CGRect){.origin=CGPointZero, CGSizeMake(width, width)};
    self.transitionViewButtonView.frame = (CGRect){.origin=CGPointMake(0, width), CGSizeMake(width, 60)};
}

#pragma marks - UIPanGestureRecognizer

- (void)coucou:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:self];
    
    if (translation.y > 0) {
        translation.y = 0;
    }
    
    if (fabs(translation.y) > 60) {
        translation.y = -60;
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        if ([self.coucou respondsToSelector:@selector(didBeganPullPicture)]) {
            [self.coucou performSelector:@selector(didBeganPullPicture)];
        }
        
        self.transitionViewImageView.image = [UIImage imageNamed:[[[[CSDataManager sharedManager] getArticles] objectAtIndex:self.currentIndex] image]];
        
        [self.superview insertSubview:self.transitionView aboveSubview:self];
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        self.transitionView.frame = (CGRect){.origin=CGPointMake(0, CGRectGetHeight(self.superview.frame)-CGRectGetWidth(self.frame)+translation.y), .size=self.frame.size};
        
        if ([self.coucou respondsToSelector:@selector(didPullPicture:)]) {
            [self.coucou performSelector:@selector(didPullPicture:) withObject:[NSNumber numberWithFloat:fabs(translation.y/60)]];
        }
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if ([self.coucou respondsToSelector:@selector(didReleasePicture:)]) {
            [self.coucou performSelector:@selector(didReleasePicture:) withObject:[NSNumber numberWithFloat:fabs(translation.y/60)]];
        }
        
        if (fabs(translation.y/60) < 1) {
            [UIView animateWithDuration:0.25 animations:^{
                self.transitionView.frame = (CGRect){.origin=CGPointMake(0, CGRectGetHeight(self.superview.frame)-CGRectGetWidth(self.frame)), .size=self.frame.size};
            } completion:^(BOOL finished) {
                if (finished) {
                    self.panGestureRecognizer.enabled = YES;
                    
                    [self.transitionView removeFromSuperview];
                }
            }];
        }
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint velocity = [((UIPanGestureRecognizer *) gestureRecognizer) velocityInView:self];
    
    if ([self.panGestureRecognizer isEqual:gestureRecognizer]) {
        return fabsf(velocity.x) > fabsf(velocity.y) || velocity.y == 0;
    } else {
        return fabsf(velocity.x) < fabsf(velocity.y);
    }
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
