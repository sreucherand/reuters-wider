//
//  CSDataManager.m
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 26/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSDataManager.h"

@interface CSDataManager ()

@property (strong, nonatomic) CSArticlesModel *data;

@end

@implementation CSDataManager

+ (instancetype)sharedManager {
    static CSDataManager *sharedManager = nil;
    
    if (!sharedManager) {
        sharedManager = [[self alloc] initPrivate];
    }
    
    return sharedManager;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Preferred use methode +sharedManager"
                                 userInfo:nil];
    
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"articles" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        self.data = [[CSArticlesModel alloc] initWithString:json error:nil];
    }
    
    return self;
}

#pragma mark - Global

- (NSLocale *)locale {
    return [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
}

#pragma mark - Articles

- (NSArray *)getArticles {
    return self.data.articles;
}

- (NSArray *)getPartsForArticle:(NSInteger)articleIndex {
    return [[[self getArticles] objectAtIndex:articleIndex] parts];
}

- (NSArray *)getBlocksForArticle:(NSInteger)articleIndex part:(NSInteger)partIndex {
    return [[[self getPartsForArticle:articleIndex] objectAtIndex:partIndex] blocks];
}

- (CSDefinitionModel *)getDefinitionAtIndex:(NSInteger)definitionIndex forArticleAtIndex:(NSInteger)articleIndex {
    return [[[[self getArticles] objectAtIndex:articleIndex] definitions] objectAtIndex:definitionIndex];
}

- (NSDictionary *)getSortedDefinitionsForArticle:(NSInteger)articleIndex {
    NSArray *sortedDefinitions = [[NSArray alloc] initWithArray:[[[[self getArticles] objectAtIndex:articleIndex] definitions] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *first = [[(CSDefinitionModel *)obj1 title] substringWithRange:NSMakeRange(0, 1)];
        NSString *second = [[(CSDefinitionModel *)obj1 title] substringWithRange:NSMakeRange(0, 1)];
        
        return [first compare:second];
    }]];
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    
    for (CSDefinitionModel *definition in sortedDefinitions) {
        NSString *letter = [definition.title substringWithRange:NSMakeRange(0, 1)];
        
        if (results[letter] == nil) {
            results[letter] = @[].mutableCopy;
        }
        
        [results[letter] addObject:definition];
    }
    
    return results;
}

- (NSArray *)getSortedDefinitionsForArticle:(NSInteger)articleIndex forKeyIndex:(NSInteger)index {
    NSDictionary *definitions = [self getSortedDefinitionsForArticle:articleIndex];
    NSArray *keys = [[NSArray alloc] initWithArray:[[definitions allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *first = (NSString *)obj1;
        NSString *second = (NSString *)obj2;
        
        return [first compare:second];
    }]];
    
    return [definitions objectForKey:[keys objectAtIndex:index]];
}

@end
