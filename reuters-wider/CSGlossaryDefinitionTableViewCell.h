//
//  CSGlossaryDefinitionTableViewCell.h
//  reuters-wider
//
//  Created by Sylvain Reucherand on 07/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSAttributedLabel.h"

@interface CSGlossaryDefinitionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *letterLabel;
@property (weak, nonatomic) IBOutlet CSAttributedLabel *titleDefinitionLabel;
@property (weak, nonatomic) IBOutlet CSAttributedLabel *definitionLabel;

- (void)hydrateWithDefinition:(CSDefinitionModel *)definition forIndexPath:(NSIndexPath *)indexPath;

@end
