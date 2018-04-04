//
//  B2Bucket+NSObject.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2Bucket.h"

@implementation B2Bucket (NSObject)

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
    B2Bucket *other = obj;
    return ([self accountId] == [other accountId] || [[self accountId] isEqual:[other accountId]]) &&
    ([self bucketId] == [other bucketId] || [[self bucketId] isEqual:[other bucketId]]) &&
    ([self bucketName] == [other bucketName] || [[self bucketName] isEqual:[other bucketName]]) &&
    [self bucketType] == [other bucketType] &&
    ([self bucketInfo] == [other bucketInfo] || [[self bucketInfo] isEqual:[other bucketInfo]]) &&
    ([self lifeCycleRules] == [other lifeCycleRules] || [[self lifeCycleRules] isEqual:[other lifeCycleRules]]) &&
    ([self revision] == [other revision] || [[self revision] isEqual:[other revision]]);
}

- (NSUInteger)hash
{
    return [self accountId].hash ^
    [self bucketId].hash ^
    [self bucketName].hash ^
    @([self bucketType]).hash ^
    [self bucketInfo].hash ^
    [self lifeCycleRules].hash ^
    [self revision].hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2Bucket %p> {accountId=%@, bucketId=%@, bucketName=%@, bucketInfo=%@, lifeCycleRules=%@, revision=%@}",
            (__bridge void*)self,
            [self accountId],
            [self bucketId],
            [self bucketName],
            [self bucketInfo],
            [self lifeCycleRules],
            [self revision]];
}

@end
