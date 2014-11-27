//
//  CSArticleModel.h
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 26/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "JSONModel.h"
#import "CSPartModel.h"

@protocol CSArticleModel
@end

@interface CSArticleModel : JSONModel

@property (assign, nonatomic) int id;
@property (assign, nonatomic) int number;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSArray<CSPartModel, Optional> *parts;

@end