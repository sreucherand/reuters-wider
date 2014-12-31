//
//  CSDataManager.h
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 26/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CSArticlesModel.h"

@interface CSArticleData : NSObject

+ (instancetype)sharedInstance;

- (NSArray *)getArticles;
- (NSArray *)getBlocksOfArticle:(NSInteger)articleIndex;
- (CSDefinitionModel *)getDefinitionAtIndex:(NSInteger)definitionIndex ofArticle:(NSInteger)articleIndex;
- (NSDictionary *)getSortedDefinitionsOfArticle:(NSInteger)articleIndex;
- (NSArray *)getSortedDefinitionsOfArticle:(NSInteger)articleIndex forKeyIndex:(NSInteger)index;

- (NSDictionary *)getSynchronizedArticles;
- (NSDictionary *)getSynchronizedArticle:(NSInteger)articleIndex;
- (CGFloat)getProgressionOfArticle:(NSInteger)articleIndex;
- (void)saveProgression:(CGFloat)percentage ofArticle:(NSInteger)articleIndex;

@end
