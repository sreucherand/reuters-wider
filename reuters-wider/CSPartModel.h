//
//  CSPartModel.h
//  reuters-wider
//
//  Created by Sylvain Reucherand on 03/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import "JSONModel.h"

@protocol CSPartModel
@end

@interface CSPartModel : JSONModel

@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subtitle;

@end
