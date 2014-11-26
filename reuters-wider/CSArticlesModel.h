//
//  CSArticlesModel.h
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 26/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "JSONModel.h"
#import "CSArticleModel.h"

@protocol CSArticlesModel
@end

@interface CSArticlesModel : JSONModel

@property (strong, nonatomic) NSArray<CSArticleModel> *articles;

@end
