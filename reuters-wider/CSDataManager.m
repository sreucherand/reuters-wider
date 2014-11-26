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

- (NSArray *)getArticles {
    return self.data.articles;
}

@end
