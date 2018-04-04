//
//  B2UnfinishedLargeFiles+Private.m
//  B2Kit
//
//  Created by Andreas Meingast on 14.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2UnfinishedLargeFiles+Private.h"
#import "B2JSONValidator.h"

@implementation B2UnfinishedLargeFile (Private)

- (B2UnfinishedLargeFile *)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
                                        error:(out NSError *__autoreleasing *)error
{
    BOOL validationResult = [[B2JSONValidator sharedInstance] validateJSON:dictionary
                                                                    fields:@[@"fileId",
                                                                             @"fileName",
                                                                             @"accountId",
                                                                             @"bucketId",
                                                                             @"contentType",
                                                                             @"fileInfo",
                                                                             @"uploadTimestamp"]
                                                                     error:error];
    if (!validationResult) {
        return nil;
    }
    return [self initWithFileId:(NSString *)dictionary[@"fileId"]
                       filename:(NSString *)dictionary[@"fileName"]
                      accountId:(NSString *)dictionary[@"accountId"]
                       bucketId:(NSString *)dictionary[@"bucketId"]
                    contentType:(NSString *)dictionary[@"contentType"]
                       fileInfo:(NSDictionary<NSString *, NSString *> *)dictionary[@"fileInfo"]
                uploadTimestamp:[NSDate dateWithTimeIntervalSince1970:[(NSNumber *)dictionary[@"uploadTimestamp"] integerValue]]];
}

@end

@implementation B2UnfinishedLargeFiles (Private)

- (B2UnfinishedLargeFiles *)initWithJSONData:(NSData *)data
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

- (B2UnfinishedLargeFiles *)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
                                         error:(out NSError *__autoreleasing *)error
{
    BOOL validationResult = [[B2JSONValidator sharedInstance] validateJSON:dictionary
                                                                    fields:@[@"files", @"nextFileId" ]
                                                                     error:error];
    if (!validationResult) {
        return nil;
    }
    NSMutableArray<B2UnfinishedLargeFile *> *files = [NSMutableArray new];
    for (NSDictionary<NSString *, id> *file in dictionary[@"files"]) {
        B2UnfinishedLargeFile *mappedFile = [[B2UnfinishedLargeFile alloc] initWithDictionary:file
                                                                                        error:error];
        if (!mappedFile) {
            return nil;
        }
        [files addObject:mappedFile];
    }
    return [[B2UnfinishedLargeFiles alloc] initWithFiles:files
                                              nextFileId:(NSString *)dictionary[@"nextFileId"]];
}

@end
