//
//  CSArticleModel.m
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 26/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSArticleModel.h"

@implementation CSArticleModel

- (NSDate *)formattedDate {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    
    [dateFormat setLocale:locale];
    [dateFormat setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss zzz"];
    
    return [dateFormat dateFromString:self.date];
}

@end
