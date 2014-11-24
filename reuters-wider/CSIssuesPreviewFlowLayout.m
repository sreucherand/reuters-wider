//
//  CSIssuesPreviewFlowLayout.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 23/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSIssuesPreviewFlowLayout.h"

@implementation CSIssuesPreviewFlowLayout

- (CGSize)collectionViewContentSize {
    return CGSizeMake(CGRectGetWidth(self.collectionView.frame)*[self.collectionView numberOfItemsInSection:0]/2, CGRectGetHeight(self.collectionView.frame));
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributesInRect = [super layoutAttributesForElementsInRect:rect];
    
    for (UICollectionViewLayoutAttributes *attributes in attributesInRect) {
        [self editLayoutAttributes:attributes];
    }
    
    return attributesInRect;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    [self editLayoutAttributes:attributes];
    
    return attributes;
}

- (void)editLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes {
    CGRect frame = CGRectZero;
    CGFloat width = CGRectGetWidth(self.collectionView.frame);
    CGFloat height = CGRectGetHeight(self.collectionView.frame);
    
    NSIndexPath *indexPath = attributes.indexPath;
    
    if (indexPath.item %2 != 0) {
        frame = CGRectMake(width*(indexPath.item-1)/2, height-width, width, width);
    } else {
        frame = CGRectMake(width*indexPath.item/2, 0, width, height-width);
    }
    
    attributes.frame = frame;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    CGRect bounds = self.collectionView.bounds;
    
    if (CGRectGetWidth(bounds) != CGRectGetWidth(newBounds)) {
        return YES;
    }
    
    return NO;
}

@end
