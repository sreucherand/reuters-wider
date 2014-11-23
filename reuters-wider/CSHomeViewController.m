//
//  CSHomeViewController.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 17/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSHomeViewController.h"
#import "CSArchivesHomeTransition.h"
#import "CSIssuesPreviewFlowLayout.h"
#import "CSGradientIndicatorView.h"

@interface CSHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *issuesPreviewCollectionView;
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CSIssuesPreviewFlowLayout *layout = [[CSIssuesPreviewFlowLayout alloc] init];
    
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    [self.issuesPreviewCollectionView setCollectionViewLayout:layout];
    
    self.bottomConstraintGradientIndicatorView.constant = CGRectGetWidth(self.view.frame) - CGRectGetHeight(self.gradientIndicatorView.frame)/2;
}

# pragma marks - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;

    if (indexPath.row % 2 != 0) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PictureViewCellID" forIndexPath:indexPath];
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DescriptionViewCellID" forIndexPath:indexPath];
    }
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat hue = (arc4random() % 256 / 256.0);
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;
    
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    [self.gradientIndicatorView switchToGradientColor:color];
}

# pragma marks - UISegue

- (IBAction)unwindFromArchives:(UIStoryboardSegue *)segue {
    // Close archives
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
