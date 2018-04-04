//
//  B2Account+NSObject.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2Account.h"

@implementation B2Account (NSObject)

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
    B2Account *other = obj;
    return ([self accountId] == [other accountId] || [[self accountId] isEqual:[other accountId]]) &&
    ([self token] == [other token] || [[self token] isEqual:[other token]]) &&
    [self accountCapabilities] == [other accountCapabilities] &&
    ([self apiURL] == [other apiURL] || [[self apiURL] isEqual:[other apiURL]]) &&
    ([self downloadURL] == [other downloadURL] || [[self downloadURL] isEqual:[other downloadURL]]) &&
    ([self recommendedPartSize] == [other recommendedPartSize] || [[self recommendedPartSize] isEqual:[other recommendedPartSize]]) &&
    ([self absoluteMinimumPartSize] == [other absoluteMinimumPartSize] || [[self absoluteMinimumPartSize] isEqual:[other absoluteMinimumPartSize]]);
}

- (NSUInteger)hash
{
    return [self accountId].hash ^
    [self token].hash ^
    @([self accountCapabilities]).hash ^
    [self apiURL].hash ^
    [self downloadURL].hash ^
    [self recommendedPartSize].hash ^
    [self absoluteMinimumPartSize].hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2Account: %p> {accountId=%@, token=%@, accountCapabilites=%@, apiURL=%@, "
            "downloadURL=%@, recommendedPartSize=%@, absoluteMinimumPartSize=%@}",
            (__bridge void *)self,
            [self accountId],
            [self token],
            NSStringFromB2AccountCapability([self accountCapabilities]),
            [self apiURL],
            [self downloadURL],
            [self recommendedPartSize],
            [self absoluteMinimumPartSize]];
}

@end
