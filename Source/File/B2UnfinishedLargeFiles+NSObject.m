//
//  B2UnfinishedLargeFiles+NSObject.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2UnfinishedLargeFiles.h"
#import "NSArray+B2Kit.h"
#import "NSDictionary+B2Kit.h"

@implementation B2UnfinishedLargeFile (NSObject)

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
    B2UnfinishedLargeFile *other = obj;
    return ([self fileId] == [other fileId] || [[self fileId] isEqual:[other fileId]]) &&
    ([self filename] == [other filename] || [[self filename] isEqual:[other filename]]) &&
    ([self accountId] == [other accountId] || [[self accountId] isEqual:[other accountId]]) &&
    ([self bucketId] == [other bucketId] || [[self bucketId] isEqual:[other bucketId]]) &&
    ([self contentType] == [other contentType] || [[self contentType] isEqual:[other contentType]]) &&
    ([self fileInfo] == [other fileInfo] || [[self fileInfo] isEqual:[other fileInfo]]) &&
    ([self uploadTimestamp] == [other uploadTimestamp] || [[self uploadTimestamp] isEqual:[other uploadTimestamp]]);
}

- (NSUInteger)hash
{
    return [self fileId].hash ^
    [self filename].hash ^
    [self accountId].hash ^
    [self bucketId].hash ^
    [self contentType].hash ^
    [self fileInfo].hash ^
    [self uploadTimestamp].hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2UnfinishedLargeFile %p> {fileId=%@, filename=%@, accountId=%@, bucketId=%@, "
            "conentType=%@, fileInfo=%@, uploadTimestamp=%@}",
            (__bridge void *)self,
            [self fileId],
            [self filename],
            [self accountId],
            [self bucketId],
            [self contentType],
            [[self fileInfo] singleLineDescription],
            [self uploadTimestamp]];
}

@end

@implementation B2UnfinishedLargeFiles (NSObject)

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
    B2UnfinishedLargeFiles *other = obj;
    return ([self files] == [other files] || [[self files] isEqual:[other files]]) &&
    ([self nextFileId] == [other nextFileId] || [[self nextFileId] isEqual:[other nextFileId]]);
}

- (NSUInteger)hash
{
    return [self files].hash ^
    [self nextFileId].hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2UnfinishedLargeFiles %p> {files=%@, nextFileId=%@}",
            (__bridge void *)self,
            [[self files] singleLineDescription],
            [self nextFileId]];
}

@end
