//
//  NSString+Helper.m
//  Wrapper
//
//  Created by Adriana Santos on 11/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

+(NSString *)stringBetweenString:(NSString *)start andString:(NSString *)end onString:(NSString *)search {
    NSRange startRange = [search rangeOfString:start options:NSCaseInsensitiveSearch];
    if (startRange.location != NSNotFound) {
        NSRange targetRange;
        targetRange.location = startRange.location + startRange.length;
        targetRange.length = [search length] - targetRange.location;
        NSRange endRange = [search rangeOfString:end options:NSCaseInsensitiveSearch range:targetRange];
        if (endRange.location != NSNotFound) {
            targetRange.length = endRange.location - targetRange.location;
            return [search substringWithRange:targetRange];
        }
    }
    return nil;
}

@end
