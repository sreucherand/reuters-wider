//
//  CSInterviewBlockTableViewCell.m
//  reuters-wider
//
//  Created by Clément Bardon on 05/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import "CSInterviewBlockTableViewCell.h"
#import "CSGradientIndicatorView.h"

#import <MediaPlayer/MediaPlayer.h>

@interface CSInterviewBlockTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *interviewViewBackground;
@property (weak, nonatomic) IBOutlet UILabel *interviewTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *interviewedNameLabel;
@property (weak, nonatomic) IBOutlet CSAttributedLabel *keyphraseLabel;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *gradientView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundImageViewHeightConstrint;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;

@end

@implementation CSInterviewBlockTableViewCell

- (void)awakeFromNib {
    self.interviewViewBackground.backgroundColor = FIRST_DIMMED_PURPLE;
    
    self.interviewTitleLabel.font = LEITURA_ROMAN_3_19;
    self.interviewTitleLabel.textColor = DARK_GREY;
    
    self.interviewedNameLabel.font = CALIBRE_LIGHT_16;
    self.interviewedNameLabel.textColor = FIRST_PURPLE;
    
    self.gradientView.topColor = DARK_BLUE;
    
    self.keyphraseLabel.font = LEITURA_ROMAN_1_19;
    self.keyphraseLabel.textColor = DARK_GREY;
    self.keyphraseLabel.lineHeight = 25;
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
    
    self.interviewTitleLabel.text = self.content.title;
    self.interviewedNameLabel.text = self.content.person;
    self.keyphraseLabel.text = self.content.subject;
    
    UIImage *image = [UIImage imageNamed:self.content.thumbnail];
    
    CGFloat ratio = image.size.height/image.size.width;
    
    self.backgroundImageView.image = image;
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImageViewHeightConstrint.constant = CGRectGetWidth(self.frame)*ratio;
    
    if (self.content.video) {
        self.playButton.hidden = NO;
    }
}

- (IBAction)launchVideo:(id)sender {
    // Video
    NSLog(@"coucoucou");
    [self layoutIfNeeded];
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"honk-kong-interview" ofType:@"mp4"]];
    
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    
    [self.moviePlayer prepareToPlay];
    
    self.moviePlayer.view.frame = self.backgroundImageView.frame;
    self.moviePlayer.view.alpha = 0;
    self.moviePlayer.repeatMode = MPMovieRepeatModeNone;
    
    [self addSubview:self.moviePlayer.view];
    
    [self.moviePlayer play];
    
    self.moviePlayer.view.userInteractionEnabled = NO;
    
    [CSTween tweenFrom:0 to:1 duration:0.5 timingFunction:CSTweenEaseLinear updateBlock:^(CSTweenOperation *operation) {
        self.moviePlayer.view.alpha = operation.value;
    } completeBlock:^(BOOL finished) {
        if (finished) {
            self.moviePlayer.view.userInteractionEnabled = YES;
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MPMoviePlayerPlaybackStateDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}

- (void)MPMoviePlayerPlaybackStateDidFinish:(NSNotification *)notification {
    self.moviePlayer.view.userInteractionEnabled = NO;
    
    [CSTween tweenFrom:1 to:0 duration:0.5 timingFunction:CSTweenEaseLinear updateBlock:^(CSTweenOperation *operation) {
        self.moviePlayer.view.alpha = operation.value;
    } completeBlock:^(BOOL finished) {
        [self.moviePlayer.view removeFromSuperview];
        
        self.moviePlayer = nil;
    }];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.playButton.hidden = YES;
}

- (void)switchToNightMode {
    [super switchToNightMode];
    
    self.interviewViewBackground.backgroundColor = DARK_NIGHT_BLUE;
    
    self.gradientView.topColor = WHITE_COLOR;
    
    self.interviewTitleLabel.textColor = PURPLE_GREY;
    self.interviewedNameLabel.textColor = PURPLE_GREY;
    self.keyphraseLabel.textColor = PURPLE_GREY;
}

- (void)leave {
    if (!self.moviePlayer) {
        return;
    }
    
    [self.moviePlayer stop];
    [self.moviePlayer.view removeFromSuperview];
    
    self.moviePlayer = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}

@end
