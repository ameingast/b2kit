//
//  NSDictionary+B2Kit.m
//  B2Kit
//
//  Created by Andreas Meingast on 31.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "NSDictionary+B2Kit.h"

@implementation NSDictionary (B2Kit)

- (NSString *)singleLineDescription
{
    NSMutableString *result = [NSMutableString new];
    [result appendString:@"["];
    for (id key in self) {
        id value = self[key];
        NSString *keyDescription = [key respondsToSelector:@selector(singleLineDescription)]
            ? [key performSelector:@selector(singleLineDescription)]
            : [key performSelector:@selector(description)];
        NSString *valueDescription = [value respondsToSelector:@selector(singleLineDescription)]
            ? [value performSelector:@selector(singleLineDescription)]
            : [value performSelector:@selector(description)];
        [result appendFormat:@"{%@=%@}, ", keyDescription, valueDescription];
    }
    if ([result length] > 1) {
        [result replaceCharactersInRange:NSMakeRange([result length] - 2, 2) withString:@""];
    }
    [result appendString:@"]"];
    return result;
}

@end
