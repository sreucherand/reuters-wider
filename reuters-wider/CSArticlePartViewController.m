//
//  CSArticlePartViewController.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 07/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSArticlePartViewController.h"
#import "CSAbstractArticleViewCellTableViewCell.h"
#import "CSArticleTableHeaderView.h"
#import "CSInArticleGlossaryDefinition.h"

@interface CSArticlePartViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, CSAbstractArticleViewCellTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewRightConstraint;

@property (strong, nonatomic) CSArticleTableHeaderView *headerView;
@property (strong, nonatomic) CSInArticleGlossaryDefinition *definitionView;
@property (strong, nonatomic) NSMutableDictionary *cells;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation CSArticlePartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the
    
    self.definitionView = [[[NSBundle mainBundle] loadNibNamed:@"CSInArticleGlossaryDefinition" owner:self options:nil] lastObject];
    self.definitionView.frame = (CGRect){.origin=self.definitionView.frame.origin, .size=CGSizeMake(CGRectGetWidth(self.view.frame)*0.55, self.definitionView.frame.size.height)};
    
    [self.view insertSubview:self.definitionView belowSubview:self.tableView];
    
    self.cells = [[NSMutableDictionary alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CSMetaBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSMetaBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSTeasingBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSTeasingBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSParagraphBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSParagraphBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSStatementBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSStatementBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSSubtitleBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSSubtitleBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSFigureBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSFigureBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSAsideBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSAsideBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSPovBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSPovBlockCellID"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CSGlossaryDefinitionTableViewCell" bundle:nil] forCellReuseIdentifier:@"glossaryDefinitionCellID"];
    
    self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"CSArticleTableHeaderView" owner:self options:nil] lastObject];
    
    [self.headerView hydrateWithHeadingData:[[[CSDataManager sharedManager] getPartsForArticle:2] objectAtIndex:0]];
    
    self.headerView.frame = (CGRect){.origin=CGPointZero, .size=[self.headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize]};
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnTableView:)];
    self.tapGestureRecognizer.delegate = self;
    
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeOnView:)];
    
    [self.view addGestureRecognizer:swipeGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 14;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSAbstractArticleViewCellTableViewCell *cell = nil;
    
    CSBlockModel *block = [[[CSDataManager sharedManager] getBlocksForArticle:2 part:0] objectAtIndex:indexPath.row];
    
    cell = [self.tableView dequeueReusableCellWithIdentifier:[self cellIdentifierForBlockType:block.type] forIndexPath:indexPath];
    cell.delegate = self;
    
    [cell hydrateWithContentData:(NSDictionary *)block];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSAbstractArticleViewCellTableViewCell *cell = self.cells[[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
    
    CSBlockModel *block = [[[CSDataManager sharedManager] getBlocksForArticle:2 part:0] objectAtIndex:indexPath.row];
    
    if (cell == nil) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:[self cellIdentifierForBlockType:block.type]];
        
        [cell hydrateWithContentData:(NSDictionary *)block];
        
        self.cells[[NSString stringWithFormat:@"%ld", (long)indexPath.row]] = cell;
    }
    
    cell.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), CGRectGetHeight(self.tableView.bounds));
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return size.height+1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark - Identifier and block type match

- (NSString *)cellClassForBlockType:(NSString *)type {
    NSString *class = [NSString stringWithFormat:@"CS%@BlockTableViewCell", [type capitalizedString]];
    
    return class;
}

- (NSString *)cellIdentifierForBlockType:(NSString *)type {
    NSString *identifier = [NSString stringWithFormat:@"CS%@BlockCellID", [type capitalizedString]];
    
    return identifier;
}

- (void)openDefinitionWithUrl:(NSURL *)url {
    CSDefinitionModel *definition = [[CSDataManager sharedManager] getDefinitionAtIndex:[[[url.relativeString componentsSeparatedByString:@"/"] lastObject] integerValue] forArticleAtIndex:2];
    
    [self.definitionView hydrateWithTitle:definition.title andText:definition.text];
    
    [self.tableView addGestureRecognizer:self.tapGestureRecognizer];
    [self.tableView.layer removeAllAnimations];
    [self.tableView setScrollEnabled:NO];
    
    [self.definitionView.layer removeAllAnimations];
    
    [self.definitionView.gradientIndicatorView clearAnimation];
    [self.definitionView.gradientIndicatorView interpolateBetweenColor:[UIColor clearColor] andColor:BLUE_COLOR withProgression:0];
    [self.definitionView.gradientIndicatorView animateWidthDuration:0.35 delay:0.35 timingFunction:PRTweenTimingFunctionExpoInOut completion:nil];
    
    self.tableViewLeftConstraint.constant = -CGRectGetWidth(self.view.frame)*0.65;
    self.tableViewRightConstraint.constant = CGRectGetWidth(self.view.frame)*0.65;
    
    [UIView animateWithDuration:0.85 delay:0 options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState) animations:^{
        [self.tableView layoutIfNeeded];
        self.definitionView.frame = CGRectOffset(self.definitionView .frame, -CGRectGetWidth(self.view.frame)*0.65, 0);
    } completion:nil];
}

- (void)closeDefinition {
    [self.tableView removeGestureRecognizer:self.tapGestureRecognizer];
    [self.tableView.layer removeAllAnimations];
    [self.tableView setScrollEnabled:YES];
    
    [self.definitionView.layer removeAllAnimations];
    
    self.tableViewLeftConstraint.constant = 0;
    self.tableViewRightConstraint.constant = 0;
    
    [UIView animateWithDuration:0.85 delay:0 options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState) animations:^{
        [self.tableView layoutIfNeeded];
        self.definitionView.frame = CGRectOffset(self.definitionView.frame, CGRectGetWidth(self.view.frame)*0.65, 0);
    } completion:nil];
}

- (void)colorizeHeaderGradientIndicator {
    [self.headerView.gradientIndicatorView interpolateBetweenColor:[UIColor clearColor] andColor:BLUE_COLOR withProgression:0];
    [self.headerView.gradientIndicatorView animateWidthDuration:1 delay:0 timingFunction:PRTweenTimingFunctionExpoInOut completion:nil];
}

#pragma mark - Gesture delegate

- (void)didTapOnTableView:(UITapGestureRecognizer *)recognizer {
    [self closeDefinition];
}

- (void)didSwipeOnView:(UISwipeGestureRecognizer *)recognizer {
    [self closeDefinition];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - Cell delegate

- (void)didSelectLinkWithURL:(NSURL *)url atPoint:(NSValue *)point {
    CGFloat location = [point CGPointValue].y - CGRectGetHeight(self.tableView.frame)/2;
    
    [self.tableView setEasingFunction:easeOutExpo forKeyPath:@"center"];
    [self.definitionView setEasingFunction:easeOutExpo forKeyPath:@"frame"];
    
    if (fabs(self.tableView.contentOffset.y - location) > 80) {
        [self.definitionView setFrameForPoint:CGPointMake(CGRectGetWidth(self.view.frame)*1.05, CGRectGetHeight(self.tableView.frame)/2)];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.tableView.contentOffset = CGPointMake(0, location);
        } completion:^(BOOL finished) {
            if (finished) {
                [self openDefinitionWithUrl:url];
            }
        }];
    } else {
        [self.definitionView setFrameForPoint:CGPointMake(CGRectGetWidth(self.view.frame)*1.05, [point CGPointValue].y - self.tableView.contentOffset.y)];
        [self openDefinitionWithUrl:url];
    }
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
