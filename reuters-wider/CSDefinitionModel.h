//
//  CSDefinitionModel.h
//  reuters-wider
//
//  Created by Sylvain Reucherand on 07/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "JSONModel.h"

@protocol CSDefinitionModel
@end

@interface CSDefinitionModel : JSONModel

@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *text;

@end
