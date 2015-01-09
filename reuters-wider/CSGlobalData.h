//
//  CSGlobalData.h
//  reuters-wider
//
//  Created by Sylvain Reucherand on 09/01/2015.
//  Copyright (c) 2015 Gobelins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSGlobalData : NSObject

+ (instancetype)sharedInstance;

- (BOOL)hasUserAlreadyReceiveNightLayer;
- (void)userDidReceiveNightLayer;

@end
