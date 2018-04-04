//
//  B2Parts+NSObject.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2Parts.h"

@implementation B2Part (NSObject)

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
    B2Part *other = obj;
    return ([self fileId] == [other fileId] || [[self fileId] isEqual:[other fileId]]) &&
    ([self partNumber] == [other partNumber] || [[self partNumber] isEqual:[other partNumber]]) &&
    ([self contentSha1] == [other contentSha1] || [[self contentSha1] isEqual:[other contentSha1]]) &&
    ([self uploadTimestamp] == [other uploadTimestamp] || [[self uploadTimestamp] isEqual:[other uploadTimestamp]]);
}

- (NSUInteger)hash
{
    return [self fileId].hash ^
    [self partNumber].hash ^
    [self contentSha1].hash ^
    [self uploadTimestamp].hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2Part %p> {fileId=%@, partNumber=%@, contentSha1=%@, uploadTimestamp=%@}",
            (__bridge void *)self,
            [self fileId],
            [self partNumber],
            [self contentSha1],
            [self uploadTimestamp]];
}

@end

@implementation B2Parts (NSObject)

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
    B2Parts *other = obj;
    return ([self parts] == [other parts] || [[self parts] isEqual:[other parts]]) &&
    ([self nextPartNumber] == [other nextPartNumber] || [[self nextPartNumber] isEqual:[other nextPartNumber]]);
}

- (NSUInteger)hash
{
    return [self parts].hash ^
    [self nextPartNumber].hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2Parts %p> {parts=%@, nextPartNumber=%@}",
            (__bridge void *)self,
            [self parts],
            [self nextPartNumber]];
}

@end
