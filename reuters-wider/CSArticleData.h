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
- (NSArray *)getPartsOfArticle:(NSInteger)articleIndex;
- (CSPartModel *)getPart:(NSInteger)partIndex ofArticle:(NSInteger)articleIndex;
- (CSDefinitionModel *)getDefinitionAtIndex:(NSInteger)definitionIndex ofArticle:(NSInteger)articleIndex;
- (NSDictionary *)getSortedDefinitionsOfArticle:(NSInteger)articleIndex;
- (NSArray *)getSortedDefinitionsOfArticle:(NSInteger)articleIndex forKeyIndex:(NSInteger)index;

- (NSDictionary *)getSynchronizedArticles;
- (NSDictionary *)getSynchronizedArticle:(NSInteger)articleIndex;
- (CGFloat)getProgressionOfArticle:(NSInteger)articleIndex;
- (void)saveProgression:(CGFloat)percentage ofArticle:(NSInteger)articleIndex;
- (NSString *)getReadModeOfArticle:(NSInteger)articleIndex;
- (void)saveReadMode:(NSString *)mode ofArticle:(NSInteger)articleIndex;

@end
