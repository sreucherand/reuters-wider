//
//  CSArticleModel.h
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 26/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "JSONModel.h"
#import "CSBlockModel.h"
#import "CSDefinitionModel.h"

@protocol CSArticleModel
@end

@interface CSArticleModel : JSONModel

@property (assign, nonatomic) int id;
@property (assign, nonatomic) int number;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSArray<CSBlockModel, Optional> *blocks;
@property (strong, nonatomic) NSArray<CSDefinitionModel, Optional> *definitions;

- (NSDate *)formattedDate;

@end
