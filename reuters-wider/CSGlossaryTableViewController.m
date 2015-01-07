//
//  CSGlossaryTableViewController.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 07/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSGlossaryTableViewController.h"
#import "CSGlossaryDefinitionTableViewCell.h"
#import "CSSummaryGlossaryTransition.h"

@interface CSGlossaryTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *tableViewHeaderTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *tableViewHeaderDashView;
@property (weak, nonatomic) IBOutlet UIView *backButtonAreaView;

@property (strong, nonatomic) CSGlossaryDefinitionTableViewCell *cell;

@end

@implementation CSGlossaryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *headerView = self.tableView.tableHeaderView;
    
    [headerView setNeedsLayout];
    [headerView layoutIfNeeded];
    
    headerView.frame = (CGRect){.origin=CGPointZero, .size=[headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize]};
    
    self.tableView.tableHeaderView = headerView;
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanOnBackButtonArea:)];
    
    UITapGestureRecognizer *tapGestureRecognizez = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnBackButtonArea:)];
    
    [self.backButtonAreaView addGestureRecognizer:panGestureRecognizer];
    [self.backButtonAreaView addGestureRecognizer:tapGestureRecognizez];
    
    self.tableViewHeaderTitleLabel.font = LEITURA_ROMAN_2_25;
    
    self.tableViewHeaderDashView.backgroundColor = LIGHT_GREY;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [[[CSArticleData sharedInstance] getSortedDefinitionsOfArticle:2] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[[CSArticleData sharedInstance] getSortedDefinitionsOfArticle:2 forKeyIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSGlossaryDefinitionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"glossaryDefinitionCellID"];
    
    CSDefinitionModel *definition = [[[CSArticleData sharedInstance] getSortedDefinitionsOfArticle:2 forKeyIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    [cell hydrateWithDefinition:definition forIndexPath:indexPath];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSGlossaryDefinitionTableViewCell *cell = self.cell;
    CSDefinitionModel *definition = [[[CSArticleData sharedInstance] getSortedDefinitionsOfArticle:2 forKeyIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"glossaryDefinitionCellID"];
        
        self.cell = cell;
    }
    
    [cell hydrateWithDefinition:definition forIndexPath:indexPath];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    cell.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), CGRectGetHeight(cell.bounds));
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return size.height + 1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark - Gestures

- (void)didPanOnBackButtonArea:(UIPanGestureRecognizer *)recognizer {
    if ([self.transitioningDelegate isKindOfClass:[CSSummaryGlossaryTransition class]]) {
        [((CSSummaryGlossaryTransition *)self.transitioningDelegate) didPanFromDestinationViewControllerTransition:recognizer];
    }
}

- (void)didTapOnBackButtonArea:(UITapGestureRecognizer *)recognizer {
    if ([self.transitioningDelegate isKindOfClass:[CSSummaryGlossaryTransition class]]) {
        [((CSSummaryGlossaryTransition *)self.transitioningDelegate) didTapFromDestinationViewControllerTransition:recognizer];
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
