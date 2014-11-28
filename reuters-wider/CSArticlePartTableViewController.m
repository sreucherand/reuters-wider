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
#import "CSTeasingBlockTableViewCell.h"
#import "CSParagraphBlockTableViewCell.h"

@interface CSArticlePartTableViewController (){
    CSMetaBlockTableViewCell *_proto;
}

@property (strong, nonatomic) NSMutableDictionary *cells;

@end

@implementation CSArticlePartTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.cells = @{}.mutableCopy;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CSMetaBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSMetaBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSTeasingBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSTeasingBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSParagraphBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSParagraphBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSHeadingBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSHeadingBlockCellID"];
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
    //CSPartModel *part = [[[CSDataManager sharedManager] getPartsForArticle:2] objectAtIndex:0];
    CSBlockModel *block = [[[CSDataManager sharedManager] getBlocksForArticle:2 part:0] objectAtIndex:indexPath.row];
    
    if ([block.type isEqualToString:@"meta"]) {
        CSMetaBlockTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CSMetaBlockCellID" forIndexPath:indexPath];
        
        [cell hydrateWithContentData:(NSDictionary *)block];
        return cell;
    } else if ([block.type isEqualToString:@"teasing"]) {
        CSTeasingBlockTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CSTeasingBlockCellID" forIndexPath:indexPath];
        
        [cell hydrateWithContentData:(NSDictionary *)block];
        
        return cell;
    } else {
        CSParagraphBlockTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CSParagraphBlockCellID" forIndexPath:indexPath];
        
        [cell hydrateWithContentData:(NSDictionary *)block];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //CSPartModel *part = [[[CSDataManager sharedManager] getPartsForArticle:2] objectAtIndex:0];
    
    CSAbstractArticleViewCellTableViewCell *cell = self.cells[[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
    
    CSBlockModel *block = [[[CSDataManager sharedManager] getBlocksForArticle:2 part:0] objectAtIndex:indexPath.row];
    
    if ([block.type isEqualToString:@"meta"]) {
        if (cell == nil) {
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"CSMetaBlockCellID"];
            
            self.cells[[NSString stringWithFormat:@"%ld", (long)indexPath.row]] = cell;
        }
    } else if ([block.type isEqualToString:@"teasing"]) {
        if (cell == nil) {
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"CSTeasingBlockCellID"];
            
            self.cells[[NSString stringWithFormat:@"%ld", (long)indexPath.row]] = cell;
        }
    } else { // Paragraph
        if (cell == nil) {
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"CSParagraphBlockCellID"];
            
            self.cells[[NSString stringWithFormat:@"%ld", (long)indexPath.row]] = cell;
        }
    }
    
    [cell hydrateWithContentData:(NSDictionary *)block];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    cell.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), CGRectGetHeight(self.tableView.bounds));
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
//    NSLog(@"%@", NSStringFromCGSize(size));
    
    return size.height+1;
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
