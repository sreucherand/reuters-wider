//
//  CSAttributedLabel.h
//  reuters-wider
//
//  Created by Sylvain Reucherand on 02/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@protocol CSAttributedLabelDelegate;

@interface CSAttributedLabel : UILabel

@property (weak, nonatomic) id <CSAttributedLabelDelegate>delegate;

@property (assign, nonatomic) CGFloat lineHeight;

@property (readwrite, nonatomic, copy) NSAttributedString *attributedText;

- (void)addLinkToURL:(NSURL *)url withRange:(NSRange)range;

@end

@protocol CSAttributedLabelDelegate <NSObject>
@optional;

- (void)didSelectLinkWithURL:(NSURL *)url atPoint:(NSValue *)point;

@end