//
//  CSArticlePartTableViewController.m
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 27/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSArticlePartTableViewController.h"
#import "CSHeadingBlockTableViewCell.h"
#import "CSMetaBlockTableViewCell.h"
#import "CSParagraphBlockTableViewCell.h"

@interface CSArticlePartTableViewController ()

@end

@implementation CSArticlePartTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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
    return 2; // Don't forget add one
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSPartModel *part = [[[CSDataManager sharedManager] getPartsForArticle:2] objectAtIndex:0];
    
    if (!indexPath.row) {
        CSHeadingBlockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSHeadingBlockCellID"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CSHeadingBlockTableViewCell class]) owner:self options:nil];
            cell = [nib objectAtIndex:0];
            [cell hydrateWithHeadingData:(NSDictionary *)part];
        }
        
        return cell;
    }
    
    CSBlockModel *block = [[[CSDataManager sharedManager] getBlocksForArticle:2 part:0] objectAtIndex:indexPath.row-1];
    
    if ([block.type isEqualToString:@"meta"]) {
        CSMetaBlockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSMetaBlockCellID"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CSMetaBlockTableViewCell class]) owner:self options:nil];
            cell = [nib objectAtIndex:0];
            [cell hydrateWithContentData:(NSDictionary *)block];
        }
        
        return cell;
    } else {
        CSParagraphBlockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSParagraphBlockCellID"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CSParagraphBlockTableViewCell class]) owner:self options:nil];
            cell = [nib objectAtIndex:0];
            [cell hydrateWithContentData:(NSDictionary *)block];
        }
        
        return cell;
    }
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
