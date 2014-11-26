//
//  CSPartModel.h
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 26/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "JSONModel.h"
#import "CSBlockModel.h"

@protocol CSPartModel
@end

@interface CSPartModel : JSONModel

@property (assign, nonatomic) int id;
@property (assign, nonatomic) int duration;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSArray<CSBlockModel> *blocks;

@end
