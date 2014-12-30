//
//  CSDataManager.h
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 26/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSArticlesModel.h"

@interface CSDataManager : NSObject

@property (strong, nonatomic, readonly) NSLocale *locale;

+ (instancetype)sharedManager;

- (NSArray *)getArticles;
- (NSArray *)getPartsForArticle:(NSInteger)articleIndex;
- (NSArray *)getBlocksForArticle:(NSInteger)articleIndex part:(NSInteger)partIndex;
- (CSDefinitionModel *)getDefinitionAtIndex:(NSInteger)definitionIndex forArticleAtIndex:(NSInteger)articleIndex;
- (NSDictionary *)getSortedDefinitionsForArticle:(NSInteger)articleIndex;
- (NSArray *)getSortedDefinitionsForArticle:(NSInteger)articleIndex forKeyIndex:(NSInteger)index;

@end
