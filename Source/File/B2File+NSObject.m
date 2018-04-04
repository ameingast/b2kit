//
//  B2File+NSObject.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2File.h"

@implementation B2File (NSObject)

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
    B2File *other = obj;
    return ([self fileId] == [other fileId] || [[self fileId] isEqual:[other fileId]]) &&
    ([self filename] == [other filename] || [[self filename] isEqual:[other filename]]) &&
    ([self accountId] == [other accountId] || [[self accountId] isEqual:[other accountId]]) &&
    ([self contentSha1] == [other contentSha1] || [[self contentSha1] isEqual:[other contentSha1]]) &&
    ([self bucketId] == [other bucketId] || [[self bucketId] isEqual:[other bucketId]]) &&
    ([self contentLength] == [other contentLength] || [[self contentLength] isEqual:[other contentLength]]) &&
    ([self contentType] == [other contentType] || [[self contentType] isEqual:[other contentType]]) &&
    ([self metadata] == [other metadata] || [[self metadata] isEqual:[other metadata]]) &&
    ([self uploadDate] == [other uploadDate] || [[self uploadDate] isEqual:[other uploadDate]]) &&
    [self action] == [other action];
}

- (NSUInteger)hash
{
    return [self fileId].hash ^
    [self filename].hash ^
    [self accountId].hash ^
    [self contentSha1].hash ^
    [self bucketId].hash ^
    [self contentLength].hash ^
    [self contentType].hash ^
    [self metadata].hash ^
    [self uploadDate].hash ^
    @([self action]).hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2File %p> {fileId=%@, filename=%@, accountId=%@, bucketId=%@, "
            "contentLength=%@, contentType=%@, metadata=%@, action=%@, uploadDate=%@}",
            (__bridge void *)self,
            [self fileId],
            [self filename],
            [self accountId],
            [self bucketId],
            [self contentLength],
            [self contentType],
            [self metadata],
            NSStringFromB2FileInfoAction([self action]),
            [self uploadDate]];
}

@end
