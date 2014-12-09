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

@interface CSArticlePartViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, CSAbstractArticleViewCellTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableDictionary *cells;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation CSArticlePartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
    CSArticleTableHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"CSArticleTableHeaderView" owner:self options:nil] lastObject];
    
    [headerView hydrateWithHeadingData:[[[CSDataManager sharedManager] getPartsForArticle:2] objectAtIndex:0]];
    
    headerView.frame = (CGRect){.origin=CGPointZero, .size=[headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize]};
    
    self.tableView.tableHeaderView = headerView;
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

- (void)openDefinition {
    [self.tableView addGestureRecognizer:self.tapGestureRecognizer];
    [self.tableView.layer removeAllAnimations];
    [self.tableView setScrollEnabled:NO];
    
    [UIView animateWithDuration:1 delay:0 options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState) animations:^{
        self.tableView.frame = CGRectOffset(self.tableView.frame, -220, 0);
    } completion:nil];
}

- (void)closeDefinition {
    [self.tableView removeGestureRecognizer:self.tapGestureRecognizer];
    [self.tableView.layer removeAllAnimations];
    [self.tableView setScrollEnabled:YES];
    
    [UIView animateWithDuration:1 delay:0 options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState) animations:^{
        self.tableView.frame = CGRectOffset(self.tableView.frame, 220, 0);
    } completion:nil];
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
    
    [self.tableView setEasingFunction:easeOutExpo forKeyPath:@"frame"];
    
    if (fabs(self.tableView.contentOffset.y - location) > 80) {
        [UIView animateWithDuration:0.5 animations:^{
            self.tableView.contentOffset = CGPointMake(0, location);
        } completion:^(BOOL finished) {
            if (finished) {
                [self openDefinition];
            }
        }];
    } else {
        [self openDefinition];
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
