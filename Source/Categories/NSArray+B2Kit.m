//
//  NSArray+B2Kit.m
//  B2Kit
//
//  Created by Andreas Meingast on 31.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "NSArray+B2Kit.h"

@implementation NSArray (B2Kit)

- (NSString *)singleLineDescription
{
    NSMutableString *result = [NSMutableString new];
    [result appendString:@"["];
    for (id element in self) {
        NSString *elementDescription = [element respondsToSelector:@selector(singleLineDescription)]
            ? [element performSelector:@selector(singleLineDescription)]
            : [element performSelector:@selector(description)];
        [result appendFormat:@"%@, ", elementDescription];
    }
    if ([result length] > 1) {
        [result replaceCharactersInRange:NSMakeRange([result length] - 2, 2) withString:@""];
    }
    [result appendString:@"]"];
    return result;
}

@end
