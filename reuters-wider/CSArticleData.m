//
//  CSDataManager.m
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 26/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSArticleData.h"

@interface CSArticleData ()

@property (strong, nonatomic) CSArticlesModel *data;

@end

static CSArticleData *instance = nil;

@implementation CSArticleData

+ (instancetype)sharedInstance {
    if (!instance) {
        instance = [[self alloc] initPrivate];
    }
    
    return instance;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Preferred use methode +sharedInstance"
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

#pragma mark - Articles

- (NSArray *)getArticles {
    return self.data.articles;
}

- (NSArray *)getBlocksOfArticle:(NSInteger)articleIndex {
    return [[[self getArticles] objectAtIndex:articleIndex] blocks];
}

- (NSArray *)getPartsOfArticle:(NSInteger)articleIndex {
    return [[[self getArticles] objectAtIndex:articleIndex] parts];
}

- (CSPartModel *)getPart:(NSInteger)partIndex ofArticle:(NSInteger)articleIndex {
    return [[self getPartsOfArticle:articleIndex] objectAtIndex:partIndex];
}

- (CSDefinitionModel *)getDefinitionAtIndex:(NSInteger)definitionIndex ofArticle:(NSInteger)articleIndex {
    return [[[[self getArticles] objectAtIndex:articleIndex] definitions] objectAtIndex:definitionIndex];
}

- (NSDictionary *)getSortedDefinitionsOfArticle:(NSInteger)articleIndex {
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

- (NSArray *)getSortedDefinitionsOfArticle:(NSInteger)articleIndex forKeyIndex:(NSInteger)index {
    NSDictionary *definitions = [self getSortedDefinitionsOfArticle:articleIndex];
    NSArray *keys = [[NSArray alloc] initWithArray:[[definitions allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *first = (NSString *)obj1;
        NSString *second = (NSString *)obj2;
        
        return [first compare:second];
    }]];
    
    return [definitions objectForKey:[keys objectAtIndex:index]];
}

#pragma mark - Synchronize

- (NSDictionary *)getSynchronizedArticles {
    NSDictionary *articles = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"articles"];
    
    if (nil != articles) {
        return articles;
    }
    
    return [NSDictionary dictionary];
}

- (NSDictionary *)getSynchronizedArticle:(NSInteger)articleIndex {
    NSDictionary *articles = [self getSynchronizedArticles];
    id article = [articles objectForKey:[NSString stringWithFormat:@"%i", (int)articleIndex]];
    
    if ([article isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)article;
    }
    
    return [NSDictionary dictionary];
}

- (CGFloat)getProgressionOfArticle:(NSInteger)articleIndex {
    NSDictionary *article = [self getSynchronizedArticle:articleIndex];
    id progression = [article objectForKey:@"progression"];
    
    if ([progression isKindOfClass:[NSNumber class]]) {
        return [((NSNumber *)progression) floatValue];
    }
    
    return 0.0f;
}

- (void)saveProgression:(CGFloat)percentage ofArticle:(NSInteger)articleIndex {
    NSMutableDictionary *articles = [NSMutableDictionary dictionaryWithDictionary:[self getSynchronizedArticles]];
    NSMutableDictionary *article = [NSMutableDictionary dictionaryWithDictionary:[self getSynchronizedArticle:articleIndex]];
    
    [article setValue:[NSNumber numberWithFloat:percentage] forKey:@"progression"];
    [articles setValue:article forKey:[NSString stringWithFormat:@"%i", (int)articleIndex]];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionaryWithDictionary:articles] forKey:@"articles"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
