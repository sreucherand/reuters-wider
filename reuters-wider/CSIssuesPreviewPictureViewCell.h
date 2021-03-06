//
//  CSIssuesPreviewPictureCollectionViewCell.h
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 26/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol CSIssuesPreviewPictureViewCellDelegate;

@interface CSIssuesPreviewPictureViewCell : UICollectionViewCell

@property (strong, nonatomic) AVPlayer *motionMoviePlayer;
@property (strong, nonatomic) NSURL *motionVideoURL;
@property (strong, nonatomic) UIImageView *placeholderImageView;

@property (assign, nonatomic) id <CSIssuesPreviewPictureViewCellDelegate> delegate;

@end

@protocol CSIssuesPreviewPictureViewCellDelegate <NSObject>
@optional;

- (void)didPictureScroll:(NSNumber *)percentage;
- (void)didPullPicture:(NSNumber *)percentage;
- (void)didReleasePicture:(NSNumber *)percentage;

@end