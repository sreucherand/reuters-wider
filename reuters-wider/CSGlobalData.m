//
//  CSGlobalData.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 09/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import "CSGlobalData.h"

static CSGlobalData *instance = nil;

@implementation CSGlobalData

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
    }
    
    return self;
}

#pragma mark - Night layer

- (BOOL)hasUserAlreadyReceiveNightLayer {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"nightLayer"];
}

- (void)userDidReceiveNightLayer {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"nightLayer"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
