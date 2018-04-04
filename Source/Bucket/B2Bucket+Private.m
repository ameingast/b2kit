//
//  B2Bucket+Private.m
//  B2Kit
//
//  Created by Andreas Meingast on 14.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2Bucket+Private.h"
#import "B2JSONValidator.h"
#import "B2BucketLifeCycleRule.h"
#import "B2BucketLifeCycleRule+Private.h"

@implementation B2Bucket (Private)

+ (NSArray<B2Bucket *> *)bucketsFromJSONData:(NSData *)response
                                       error:(out NSError *__autoreleasing *)error
{
    NSDictionary<NSString *, NSArray<NSDictionary<NSString *, id> *> *>  *json = [NSJSONSerialization JSONObjectWithData:response
                                                                                                                 options:0
                                                                                                                   error:error];
    if (!json) {
        return nil;
    }
    BOOL validationResult = [[B2JSONValidator sharedInstance] validateJSON:json
                                                                    fields:@[@"buckets"]
                                                                     error:error];
    if (!validationResult) {
        return nil;
    }
    NSMutableArray<B2Bucket *> *result = [NSMutableArray new];
    for (NSDictionary<NSString *, id> *dictionary in json[@"buckets"]) {
        B2Bucket *bucket = [[B2Bucket alloc] initWithDictionary:dictionary
                                                          error:error];
        if (!bucket) {
            return nil;
        }
        [result addObject:bucket];
    }
    return result;
}

- (B2Bucket *)initWithJSONData:(NSData *)data
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

- (B2Bucket *)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
                           error:(out NSError *__autoreleasing *)error
{
    BOOL validationResult = [[B2JSONValidator sharedInstance] validateJSON:dictionary
                                                                    fields:@[ @"accountId",
                                                                              @"bucketId",
                                                                              @"bucketInfo",
                                                                              @"bucketName",
                                                                              @"bucketType",
                                                                              @"lifecycleRules",
                                                                              @"revision" ]
                                                                     error:error];
    if (!validationResult) {
        return nil;
    }
    B2Bucket *bucket = [self initWithAccountId:(NSString *)dictionary[@"accountId"]
                                      bucketId:(NSString *)dictionary[@"bucketId"]
                                    bucketName:(NSString *)dictionary[@"bucketName"]
                                    bucketType:B2BucketTypeFromNSString((NSString *)dictionary[@"bucketType"])
                                    bucketInfo:(NSDictionary<NSString *, id> *)dictionary[@"bucketInfo"]
                                lifeCycleRules:[B2BucketLifeCycleRule fromDictionaries:(NSArray<NSDictionary<NSString *, id> *> *)dictionary[@"lifecycleRules"]]
                                      revision:(NSNumber *)dictionary[@"revision"]];
    return bucket;
}

@end
