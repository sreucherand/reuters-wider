//
//  CSSummaryViewController.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 01/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import "CSSummaryViewController.h"
#import "CSSummaryGlossaryTransition.h"
#import "CSSummaryEntryTableViewCell.h"

@interface CSSummaryViewController () <UITableViewDelegate, UITableViewDataSource, CSSummaryEntryTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *tableViewHeaderTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tableViewHeaderImageView;
@property (weak, nonatomic) IBOutlet UIView *tableViewHeaderDashView;
@property (strong, nonatomic) IBOutlet UIView *glossaryToggleView;
@property (weak, nonatomic) IBOutlet UILabel *glossaryToggleViewLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *glossaryToggleViewLabelConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *mainRenderImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainRenderImageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *progressionBarView;

@property (strong, nonatomic) CSSummaryGlossaryTransition *transition;

@end

@implementation CSSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.transition = [[CSSummaryGlossaryTransition alloc] init];
    self.transition.sourceViewController = self;
    
    self.glossaryToggleView.backgroundColor = WHITE_COLOR;
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanOnGlossaryToggleBottomView:)];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnGlossaryToggleBottomView:)];
    
    [self.glossaryToggleView addGestureRecognizer:tapGestureRecognizer];
    [self.glossaryToggleView addGestureRecognizer:panGestureRecognizer];
    
    self.glossaryToggleViewLabel.font = CALIBRE_LIGHT_17;
    self.glossaryToggleViewLabel.textColor = DARK_GREY;
    
    CALayer *topBorder = [CALayer layer];
    
    topBorder.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 1);
    topBorder.backgroundColor = LIGHT_DIMMED_GREY.CGColor;
    
    [self.glossaryToggleView.layer addSublayer:topBorder];
    
    [self.glossaryToggleViewLabel setNeedsLayout];
    [self.glossaryToggleViewLabel layoutIfNeeded];
    
    self.glossaryToggleViewLabelConstraint.constant =(CGRectGetWidth(self.glossaryToggleViewLabel.frame) + 27)/2;
    
    UIView *headerView = self.tableView.tableHeaderView;
    
    [headerView setNeedsLayout];
    [headerView layoutIfNeeded];
    
    headerView.frame = (CGRect){.origin=CGPointZero, .size=[headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize]};
    
    self.tableView.tableHeaderView = headerView;
    
    [self.tableView setNeedsLayout];
    [self.tableView layoutIfNeeded];
    
    self.tableViewHeaderDashView.backgroundColor = LIGHT_GREY;
    
    self.tableViewHeaderTitleLabel.font = LEITURA_ROMAN_2_23;
    
    [self switchTableViewIntoDarkMode];
    
    self.mainRenderImageView.image = [self tableViewRenderImage];
    
    [self switchTableViewIntoLightMode];
    
    self.progressionBarView.backgroundColor = SECOND_PURPLE;
}

#pragma mark - Table view datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[CSArticleData sharedInstance] getPartsOfArticle:2] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSSummaryEntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"summaryEntryCellID" forIndexPath:indexPath];
    CSPartModel *part = [[CSArticleData sharedInstance] getPart:indexPath.row ofArticle:2];
    
    cell.partNumberLabel.text = [NSString stringWithFormat:@"0%i", (int)indexPath.row+1];
    cell.partTitleLabel.text = part.title;
    cell.partSubtitleLabel.text = part.subtitle;
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.tableView.tableHeaderView.frame) - CGRectGetHeight(self.glossaryToggleView.frame))/[[[CSArticleData sharedInstance] getPartsOfArticle:2] count];
}

#pragma mark - Table view cell delegate

- (void)didTapOnSummaryEntryCell:(NSIndexPath *)indexPath {
    
}

#pragma mark - Setters

- (void)setProgression:(CGFloat)progression {
    _progression = progression;
    
    self.mainRenderImageViewHeightConstraint.constant = CGRectGetHeight(self.view.frame) * progression;
}

#pragma mark - Specific methods

- (void)switchTableViewIntoDarkMode {
    self.tableView.backgroundColor = FIRST_PURPLE;
    self.tableViewHeaderTitleLabel.textColor = WHITE_COLOR;
    self.tableViewHeaderImageView.image = [UIImage imageNamed:@"summary-white"];
    
    [[self.tableView visibleCells] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[CSSummaryEntryTableViewCell class]]) {
            [((CSSummaryEntryTableViewCell *)obj) switchTableViewCellIntoDarkMode];
        }
    }];
}

- (void)switchTableViewIntoLightMode {
    self.tableView.backgroundColor = WHITE_COLOR;
    self.tableViewHeaderTitleLabel.textColor = BLACK_COLOR;
    self.tableViewHeaderImageView.image = [UIImage imageNamed:@"summary"];
    
    [[self.tableView visibleCells] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[CSSummaryEntryTableViewCell class]]) {
            [((CSSummaryEntryTableViewCell *)obj) switchTableViewCellIntoLightMode];
        }
    }];
}

- (UIImage *)tableViewRenderImage {
    UIGraphicsBeginImageContextWithOptions(self.tableView.frame.size, YES, 0.0f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.tableView.layer renderInContext:context];
    
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return snapshot;
}

- (UIImage *)glossaryToggleViewRenderImage {
    UIGraphicsBeginImageContextWithOptions(self.glossaryToggleView.frame.size, YES, 0.0f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.glossaryToggleView.layer renderInContext:context];
    
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return snapshot;
}

#pragma mark - Gesture

- (void)didPanOnGlossaryToggleBottomView:(UIPanGestureRecognizer *)recognizer {
    [self.transition didPanFromSourceViewControllerTransition:recognizer];
}

- (void)didTapOnGlossaryToggleBottomView:(UITapGestureRecognizer *)recognizer {
    [self.transition didTapFromSourceViewControllerTransition:recognizer];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destinationViewController = segue.destinationViewController;
    
    self.transition.destinationViewController = destinationViewController;
    
    destinationViewController.transitioningDelegate = self.transition;
}

@end
