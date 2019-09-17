//
//  B2File+NSObject.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2File.h"
#import "NSArray+B2Kit.h"
#import "NSDictionary+B2Kit.h"

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
    ([self contentSha1] == [other contentSha1] || [[self contentSha1] isEqual:[other contentSha1]]) &&
    ([self contentType] == [other contentType] || [[self contentType] isEqual:[other contentType]]) &&
    ([self fileInfo] == [other fileInfo] || [[self fileInfo] isEqual:[other fileInfo]]) &&
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
    [self contentSha1].hash ^
    [self contentType].hash ^
    [self fileInfo].hash ^
    [self uploadDate].hash ^
    @([self action]).hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2File %p> {fileId=%@, filename=%@, accountId=%@, bucketId=%@, "
            "contentLength=%@, contentSha1=%@, contentType=%@, fileInfo=%@, action=%@, uploadDate=%@}",
            (__bridge void *)self,
            [self fileId],
            [self filename],
            [self accountId],
            [self bucketId],
            [self contentLength],
            [self contentSha1],
            [self contentType],
            [[self fileInfo] singleLineDescription],
            NSStringFromB2FileInfoAction([self action]),
            [self uploadDate]];
}

@end

@implementation B2FileNames (NSObject)

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
    B2FileNames *other = obj;
    return ([self nextFileName] == [other nextFileName] || [[self nextFileName] isEqual:[other nextFileName]]) &&
    ([self files] == [other files] || [[self files] isEqual:[other files]]);
}

- (NSUInteger)hash
{
    return [self nextFileName].hash ^ [self files].hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2FileNames %p> {nextFileName=%@, files=%@}",
            (__bridge void *)self,
            [self nextFileName],
            [[self files] singleLineDescription]];
}

@end

@implementation B2FileVersions (NSObject)

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
    B2FileVersions *other = obj;
    return ([self nextFileId] == [other nextFileId] || [[self nextFileId] isEqual:[other nextFileId]]) &&
    ([self nextFileName] == [other nextFileName] || [[self nextFileName] isEqual:[other nextFileName]]) &&
    ([self files] == [other files] || [[self files] isEqual:[other files]]);
}

- (NSUInteger)hash
{
    return [self nextFileId].hash ^ [self nextFileName].hash ^ [self files].hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2FileVersions %p> {nextFileId=%@, nextFileName=%@, files=%@}",
            (__bridge void *)self,
            [self nextFileId],
            [self nextFileName],
            [[self files] singleLineDescription]];
}

@end
