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
#import "CSStatementBlockTableViewCell.h"

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
    [self.tableView registerNib:[UINib nibWithNibName:@"CSStatementBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSStatementBlockCellID"];
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
    return 5+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSAbstractArticleViewCellTableViewCell *cell = nil;
    
    CSPartModel *part = [[[CSDataManager sharedManager] getPartsForArticle:2] objectAtIndex:0];
    
    if (!indexPath.row) { // If heading
        cell = [self.tableView dequeueReusableCellWithIdentifier:[self cellIdentifierForBlockType:@"heading"] forIndexPath:indexPath];
        
        [cell hydrateWithHeadingData:(NSDictionary *)part];
        
        return cell;
    }
    
    CSBlockModel *block = [[[CSDataManager sharedManager] getBlocksForArticle:2 part:0] objectAtIndex:indexPath.row-1];
    
    cell = [self.tableView dequeueReusableCellWithIdentifier:[self cellIdentifierForBlockType:block.type] forIndexPath:indexPath];
    
    [cell hydrateWithContentData:(NSDictionary *)block];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSAbstractArticleViewCellTableViewCell *cell = self.cells[[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
    
    if (cell == nil) {
        if (!indexPath.row) { // If heading
            CSPartModel *part = [[[CSDataManager sharedManager] getPartsForArticle:2] objectAtIndex:0];
            
            cell = [self.tableView dequeueReusableCellWithIdentifier:[self cellIdentifierForBlockType:@"heading"]];
            
            [cell hydrateWithHeadingData:(NSDictionary *)part];
        } else {
            CSBlockModel *block = [[[CSDataManager sharedManager] getBlocksForArticle:2 part:0] objectAtIndex:indexPath.row-1];
            
            cell = [self.tableView dequeueReusableCellWithIdentifier:[self cellIdentifierForBlockType:block.type]];
            
            [cell hydrateWithContentData:(NSDictionary *)block];
        }
        
        self.cells[[NSString stringWithFormat:@"%ld", (long)indexPath.row]] = cell;
    }
    
    cell.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), CGFLOAT_MAX);
    
    [cell setNeedsLayout];
    //[cell layoutIfNeeded];
    
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
