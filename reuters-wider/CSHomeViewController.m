//
//  CSHomeViewController.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 17/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSHomeViewController.h"
#import "CSHomeArchivesTransition.h"
#import "CSArchivesHomeTransition.h"
#import "CSIssuesPreviewCollectionView.h"
#import "CSIssuesPreviewFlowLayout.h"
#import "CSGradientIndicatorView.h"
#import "CSIssuesPreviewDescriptionViewCell.h"
#import "CSIssuesPreviewPictureViewCell.h"

@interface CSHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CSIssuesPreviewCollectionViewProtocol>

@property (weak, nonatomic) IBOutlet CSIssuesPreviewCollectionView *issuesPreviewCollectionView;
@property (weak, nonatomic) IBOutlet CSGradientIndicatorView *gradientIndicatorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintGradientIndicatorView;

@property (strong, nonatomic) NSMutableArray *colors;

@end

@implementation CSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.issuesPreviewCollectionView.delegate = self;
    self.issuesPreviewCollectionView.dataSource = self;
    self.issuesPreviewCollectionView.pullPictureDelegate = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.colors = [[NSMutableArray alloc] init];
    
    [self.colors addObject:[UIColor blueColor]];
    [self.colors addObject:[UIColor yellowColor]];
    [self.colors addObject:[UIColor redColor]];
    [self.colors addObject:[UIColor greenColor]];
    
    self.gradientIndicatorView.topColor = [UIColor colorWithString:[[[[CSDataManager sharedManager] getArticles] objectAtIndex:0] color]];
    
    CSIssuesPreviewFlowLayout *layout = [[CSIssuesPreviewFlowLayout alloc] init];
    
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    [self.issuesPreviewCollectionView setCollectionViewLayout:layout];
    
    self.bottomConstraintGradientIndicatorView.constant = CGRectGetWidth(self.view.frame)-CGRectGetHeight(self.gradientIndicatorView.frame)+25;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma marks - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[[CSDataManager sharedManager] getArticles] count]*2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item % 2 != 0) {
        CSArticleModel *article = [[[CSDataManager sharedManager] getArticles] objectAtIndex:(indexPath.item-1)/2];
        CSIssuesPreviewPictureViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PictureViewCellID" forIndexPath:indexPath];
        
        cell.pictureImageView.image = [UIImage imageNamed:article.image];
        
        return cell;
    }
    
    CSArticleModel *article = [[[CSDataManager sharedManager] getArticles] objectAtIndex:indexPath.item/2];
    CSIssuesPreviewDescriptionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DescriptionViewCellID" forIndexPath:indexPath];
    
    [cell hydrateWidthNumber:article.number title:article.title date:[NSDate dateWithTimeIntervalSince1970:0]];
    
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
    NSInteger toIndex = [(NSIndexPath *)[sortedIndexes lastObject] item]/2;
    
    NSArray *articles = [[CSDataManager sharedManager] getArticles];
    
    if ([indexes count] == 4) {
        [self.gradientIndicatorView interpolateBetweenColor:[UIColor colorWithString:[[articles objectAtIndex:fromIndex] color]] andColor:[UIColor colorWithString:[[articles objectAtIndex:toIndex] color]] withProgression:percentage-fromIndex];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGRect rect = (CGRect){.origin = scrollView.contentOffset, .size = scrollView.bounds.size};
    CGPoint point = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    
    NSIndexPath *indexPath = [self.issuesPreviewCollectionView indexPathForItemAtPoint:point];
    
    self.issuesPreviewCollectionView.currentIndex = indexPath.item/2;
}

- (void)didBeganPullPicture {
    [self.issuesPreviewCollectionView setScrollEnabled:NO];
}

- (void)didPullPicture:(NSNumber *)percentage {
    CSArticleModel *article = [[[CSDataManager sharedManager] getArticles] objectAtIndex:self.issuesPreviewCollectionView.currentIndex];
    [self.gradientIndicatorView interpolateBetweenColor:[UIColor clearColor] andColor:[UIColor colorWithString:article.color] withProgression:1-[percentage floatValue]];
}

- (void)didReleasePicture:(NSNumber *)percentage {
    if ([percentage floatValue] < 1) {
        [self.gradientIndicatorView animateWidthDuration:0.25 delay:0 completion:^{
            [self.issuesPreviewCollectionView setScrollEnabled:YES];
        }];
    } else {
        [self performSegueWithIdentifier:@"pushHomeToArticleSegueID" sender:self];
    }
}

#pragma marks - CSGradientIndicatorView

- (void)animationDidFinished {
    [self.issuesPreviewCollectionView setScrollEnabled:YES];
}

# pragma marks - UISegue

- (IBAction)unwindFromArchives:(UIStoryboardSegue *)segue {
    // Close archives
}

#pragma mark - Navigation

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
