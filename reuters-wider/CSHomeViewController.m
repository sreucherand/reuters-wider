//
//  CSHomeViewController.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 17/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSHomeViewController.h"
#import "CSHomeArchivesTransition.h"
#import "CSArticlePartViewController.h"
#import "CSArchivesHomeTransition.h"
#import "CSIssuesPreviewCollectionView.h"
#import "CSIssuesPreviewFlowLayout.h"
#import "CSGradientIndicatorView.h"
#import "CSIssuesPreviewDescriptionViewCell.h"
#import "CSIssuesPreviewPictureViewCell.h"

@interface CSHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CSIssuesPreviewPictureViewCellDelegate>

@property (weak, nonatomic) IBOutlet CSIssuesPreviewCollectionView *issuesPreviewCollectionView;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *gradientIndicatorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintGradientIndicatorView;

@end

@implementation CSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.issuesPreviewCollectionView.delegate = self;
    self.issuesPreviewCollectionView.dataSource = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.gradientIndicatorView.topColor = DARK_BLUE;
    
    CSIssuesPreviewFlowLayout *layout = [[CSIssuesPreviewFlowLayout alloc] init];
    
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    [self.issuesPreviewCollectionView setCollectionViewLayout:layout];
    
    self.bottomConstraintGradientIndicatorView.constant = CGRectGetWidth(self.view.frame)-CGRectGetHeight(self.gradientIndicatorView.frame)+25;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[self.issuesPreviewCollectionView visibleCells] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[CSIssuesPreviewPictureViewCell class]]) {
            [((CSIssuesPreviewPictureViewCell *)obj).motionMoviePlayer play];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[[CSArticleData sharedInstance] getArticles] count]*2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item % 2 != 0) {
        CSArticleModel *article = [[[CSArticleData sharedInstance] getArticles] objectAtIndex:(indexPath.item-1)/2];
        CSIssuesPreviewPictureViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PictureViewCellID" forIndexPath:indexPath];
        
        cell.placeholderImageView.image = [UIImage imageNamed:article.media];
        cell.motionVideoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:article.media ofType:@"mp4"]];
        [cell.motionMoviePlayer seekToTime:kCMTimeZero];
        cell.delegate = self;
        
        return cell;
    }
    
    CSArticleModel *article = [[[CSArticleData sharedInstance] getArticles] objectAtIndex:indexPath.item/2];
    CSIssuesPreviewDescriptionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DescriptionViewCellID" forIndexPath:indexPath];
    
    [cell hydrateWidthNumber:article.number title:article.title date:article.formattedDate];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.gradientIndicatorView clearAnimation];
    
    CGFloat percentage = fabs(self.issuesPreviewCollectionView.contentOffset.x)/CGRectGetWidth(self.issuesPreviewCollectionView.frame);
    
    NSArray *indexes = [self.issuesPreviewCollectionView indexPathsForVisibleItems];
    NSArray *sortedIndexes = [indexes sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSIndexPath *first = (NSIndexPath *)obj1;
        NSIndexPath *second = (NSIndexPath *)obj2;
        
        return [first compare:second];
    }];
    
    NSInteger fromIndex = [(NSIndexPath *)[sortedIndexes firstObject] item]/2;
    
    if ([indexes count] == 4) {
        [self.gradientIndicatorView interpolateBetweenColor:DARK_BLUE andColor:DARK_BLUE withProgression:percentage-fromIndex];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGRect rect = (CGRect){.origin = scrollView.contentOffset, .size = scrollView.bounds.size};
    CGPoint point = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    
    NSIndexPath *indexPath = [self.issuesPreviewCollectionView indexPathForItemAtPoint:point];
    
    self.issuesPreviewCollectionView.currentIndex = indexPath.item/2;
    
    [[self.issuesPreviewCollectionView visibleCells] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[CSIssuesPreviewPictureViewCell class]]) {
            [((CSIssuesPreviewPictureViewCell *)obj).motionMoviePlayer play];
        }
    }];
}

- (void)didPictureScroll:(NSNumber *)percentage {
    [self.gradientIndicatorView interpolateBetweenColor:[UIColor clearColor] andColor:DARK_BLUE withProgression:1-[percentage floatValue]];
}

- (void)didReleasePicture:(NSNumber *)percentage {
    if ([percentage floatValue] >= 1) {
        [self performSegueWithIdentifier:@"pushHomeToArticleSegueID" sender:self];
    }
}

#pragma mark - UISegue

- (IBAction)unwindFromArticle:(UIStoryboardSegue *)segue {
    // Close article
}

- (IBAction)unwindFromArchives:(UIStoryboardSegue *)segue {
    // Close archives
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"pushHomeToArticleSegueID"]) {
        CSArticlePartViewController *destinationViewController = [segue destinationViewController];
        
        destinationViewController.view.frame = CGRectOffset(destinationViewController.view.frame, 0, CGRectGetHeight(self.view.frame));
    }
}

@end
