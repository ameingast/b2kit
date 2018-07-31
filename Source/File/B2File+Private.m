//
//  B2File+Private.m
//  B2Kit
//
//  Created by Andreas Meingast on 14.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2File+Private.h"
#import "B2Account.h"
#import "B2JSONValidator.h"

@implementation B2File (Private)

+ (NSArray<B2File *> *)filesFromArray:(NSArray<NSDictionary<NSString *, id> *> *)array
                              account:(B2Account *)account
                             bucketId:(NSString *)bucketId
                                error:(out NSError *__autoreleasing *)error
{
    NSMutableArray<B2File *> *result = [NSMutableArray new];
    for (NSDictionary<NSString *, id> *dictionary in array) {
        BOOL validationResult = [[B2JSONValidator sharedInstance] validateJSON:dictionary
                                                                        fields:@[@"fileId",
                                                                                 @"fileName",
                                                                                 @"contentLength",
                                                                                 @"contentSha1",
                                                                                 @"contentType",
                                                                                 @"fileInfo",
                                                                                 @"action",
                                                                                 @"uploadTimestamp"]
                                                                         error:error];
        if (!validationResult) {
            return nil;
        }
        B2File *file = [[B2File alloc] initWithFileId:(NSString *)dictionary[@"fileId"]
                                             filename:(NSString *)dictionary[@"fileName"]
                                            accountId:[account accountId]
                                             bucketId:bucketId
                                        contentLength:(NSNumber *)dictionary[@"contentLength"]
                                          contentType:(NSString *)dictionary[@"contentType"]
                                             metadata:[NSDictionary new]
                                               action:B2FileInfoActionFromString((NSString *)dictionary[@"action"])
                                           uploadDate:[NSDate dateWithTimeIntervalSince1970:[(NSNumber *)dictionary[@"uploadTimestamp"] integerValue] / 1000]];
        [result addObject:file];
    }
    return result;
}

- (B2File *)initWithJSONData:(NSData *)data
                       error:(out NSError *__autoreleasing *)error
{
    NSDictionary<NSString *, id> *json = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:0
                                                                           error:error];
    if (!json) {
        return nil;
    }
    return [self initWithDictionary:json
                              error:error];
}

- (B2File *)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
                         error:(out NSError *__autoreleasing *)error
{
    BOOL validationResult = [[B2JSONValidator sharedInstance] validateJSON:dictionary
                                                                    fields:@[@"fileId",
                                                                             @"fileName",
                                                                             @"accountId",
                                                                             @"bucketId",
                                                                             @"contentLength",
                                                                             @"contentSha1",
                                                                             @"contentType",
                                                                             @"fileInfo",
                                                                             @"action",
                                                                             @"uploadTimestamp"]
                                                                     error:error];
    if (!validationResult) {
        return nil;
    }
    return [[B2File alloc] initWithFileId:(NSString *)dictionary[@"fileId"]
                                 filename:(NSString *)dictionary[@"fileName"]
                                accountId:(NSString *)dictionary[@"accountId"]
                                 bucketId:(NSString *)dictionary[@"bucketId"]
                            contentLength:(NSNumber *)dictionary[@"contentLength"]
                              contentType:(NSString *)dictionary[@"contentType"]
                                 metadata:[NSDictionary new]
                                   action:B2FileInfoActionFromString((NSString *)dictionary[@"action"])
                               uploadDate:[NSDate dateWithTimeIntervalSince1970:[(NSNumber *)dictionary[@"uploadTimestamp"] integerValue] / 1000]];
}

@end
