//
//  CSBlockModel.h
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 26/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "JSONModel.h"
#import "CSBlockContentModel.h"

@protocol CSBlockModel
@end

@interface CSBlockModel : JSONModel

@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) CSBlockContentModel *content;

@end
