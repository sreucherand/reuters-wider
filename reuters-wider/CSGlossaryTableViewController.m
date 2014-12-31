//
//  CSGlossaryTableViewController.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 07/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSGlossaryTableViewController.h"
#import "CSGlossaryHeaderView.h"
#import "CSGlossaryDefinitionTableViewCell.h"

@interface CSGlossaryTableViewController ()

@property (strong, nonatomic) NSMutableDictionary *cells;

@end

@implementation CSGlossaryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.cells = [[NSMutableDictionary alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CSGlossaryDefinitionTableViewCell" bundle:nil] forCellReuseIdentifier:@"glossaryDefinitionCellID"];
    
    CSGlossaryDefinitionTableViewCell *headerView = [[[NSBundle mainBundle] loadNibNamed:@"CSGlossaryHeaderView" owner:self options:nil] lastObject];
    
    headerView.frame = (CGRect){.origin=CGPointZero, .size=[headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize]};
    
    self.tableView.tableHeaderView = headerView;
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
    CSGlossaryDefinitionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"glossaryDefinitionCellID" forIndexPath:indexPath];
    
    CSDefinitionModel *definition = [[[CSArticleData sharedInstance] getSortedDefinitionsOfArticle:2 forKeyIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    [cell hydrateWithDefinition:definition forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:@"%i", (int)indexPath.row];
    
    CSGlossaryDefinitionTableViewCell *cell = [self.cells objectForKey:key];
    CSDefinitionModel *definition = [[[CSArticleData sharedInstance] getSortedDefinitionsOfArticle:2 forKeyIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"glossaryDefinitionCellID"];
        
        [cell hydrateWithDefinition:definition forIndexPath:indexPath];
        
        [self.cells setValue:cell forKey:key];
    }
    
    cell.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), CGRectGetHeight(self.tableView.bounds));
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return size.height + 1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
