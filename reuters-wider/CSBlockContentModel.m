//
//  CSBlockContentModel.m
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 26/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "CSBlockContentModel.h"

@implementation CSBlockContentModel

+(BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}

- (NSDate *)formattedDate {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setLocale:EN_LOCALE];
    [dateFormat setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss zzz"];
    
    return [dateFormat dateFromString:self.date];
}

@end
