//
//  B2Range+NSObject.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2Range.h"

@implementation B2Range (NSObject)

- (BOOL)isEqual:(id)obj
{
    if (obj == nil) {
        return NO;
    }
    if (self == obj) {
        return YES;
    }
    if (![obj isKindOfClass:[self class]]) {
        return NO;
    }
    B2Range *other = obj;
    return ([self start] == [other start] || [[self start] isEqual:[other start]]) &&
    ([self end] == [other end] || [[self end] isEqual:[other end]]);
}

- (NSUInteger)hash
{
    return [self start].hash ^
    [self end].hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2Range %p> {start=%@, end=%@}",
            (__bridge void *)self,
            [self start],
            [self end]];
}

@end
