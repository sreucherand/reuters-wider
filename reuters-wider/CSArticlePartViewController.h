//
//  CSArticlePartViewController.h
//  reuters-wider
//
//  Created by Sylvain Reucherand on 07/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSArticlePartViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)openWith:(void(^)())completion;
- (void)closeWith:(void(^)())completion;

@end
