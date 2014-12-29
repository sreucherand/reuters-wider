//
//  CSIssuePreviewCollectionView.h
//  reuters-wider
//
//  Created by Sylvain Reucherand on 23/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CSIssuesPreviewCollectionViewProtocol <NSObject>
@required;

- (void)didBeganPullPicture;
- (void)didPullPicture:(NSNumber *)percentage;
- (void)didReleasePicture:(NSNumber *)percentage;

@end

@interface CSIssuesPreviewCollectionView : UICollectionView

@property (assign, nonatomic) NSInteger currentIndex;
@property (assign, nonatomic) id <CSIssuesPreviewCollectionViewProtocol> pullPictureDelegate;

@end
