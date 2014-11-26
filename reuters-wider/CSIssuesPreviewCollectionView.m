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
@property (strong, nonatomic) UIImageView *imageView;

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
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.image = [UIImage imageNamed:@"map"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.frame);
    
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UICollectionViewCell *cell = obj;
        
        if ([cell.reuseIdentifier isEqualToString:@"DescriptionViewCellID"]) {
            NSIndexPath *indexPath = [self indexPathForCell:cell];
            
            cell.frame = CGRectMake(width*2*indexPath.item/2-self.contentOffset.x, cell.frame.origin.y, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame));
        }
    }];
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
        
        self.imageView.frame = CGRectMake(0, CGRectGetHeight(self.superview.frame)-CGRectGetWidth(self.frame), CGRectGetWidth(self.frame), CGRectGetWidth(self.frame));
        [self.superview insertSubview:self.imageView aboveSubview:self];
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        self.imageView.frame = CGRectMake(0, CGRectGetHeight(self.superview.frame)-CGRectGetWidth(self.frame)+translation.y, CGRectGetWidth(self.imageView.frame), CGRectGetWidth(self.imageView.frame));
        
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
                self.imageView.frame = CGRectMake(0, CGRectGetHeight(self.superview.frame)-CGRectGetWidth(self.frame), CGRectGetWidth(self.frame), CGRectGetWidth(self.frame));
            } completion:^(BOOL finished) {
                if (finished) {
                    self.panGestureRecognizer.enabled = YES;
                    
                    [self.imageView removeFromSuperview];
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
