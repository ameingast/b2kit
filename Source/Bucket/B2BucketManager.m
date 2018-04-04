//
//  B2BucketManager.m
//  B2Kit
//
//  Created by Andreas Meingast on 07.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2BucketManager.h"
#import "B2DefaultClient.h"
#import "B2Bucket.h"
#import "B2Bucket+Private.h"
#import "B2Account.h"
#import "B2Endpoint.h"
#import "B2BucketLifeCycleRule.h"
#import "B2BucketLifeCycleRule+Private.h"

@implementation B2BucketManager

@synthesize client = _client;

- (B2BucketManager *)initWithClient:(id<B2Client>)client
{
    self = [super init];
    if (self) {
        _client = client;
    }
    return self;
}

- (B2Bucket *)createBucketWithBucketName:(NSString *)bucketName
                                 account:(B2Account *)account
                              bucketType:(B2BucketType)bucketType
                                    info:(NSDictionary<NSString *, id> *)info
                          lifeCycleRules:(NSArray<B2BucketLifeCycleRule *> *)lifeCycleRules
                                   error:(out NSError *__autoreleasing *)error
{
    NSData *payload = [NSJSONSerialization dataWithJSONObject:@{ @"accountId": [account accountId],
                                                                 @"bucketName": bucketName,
                                                                 @"bucketType": NSStringFromB2BucketType(bucketType),
                                                                 @"bucketInfo": info ? (NSDictionary<NSString *, id> *)info : [NSNull new],
                                                                 @"lifecycleRules": lifeCycleRules ? [B2BucketLifeCycleRule toDictionaries:(NSArray<B2BucketLifeCycleRule *> *)lifeCycleRules] : [NSNull new] }
                                                      options:NSJSONWritingPrettyPrinted
                                                        error:error];
    if (!payload) {
        return nil;
    }
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:B2EndpointCreateBucketURL([account apiURL])];
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest setHTTPBody:payload];
    if (!mutableRequest) {
        return nil;
    }
    NSData *result = [[self client] performDownloadRequest:mutableRequest
                                                   account:account
                                                     error:error];
    return !result ? nil : [[B2Bucket alloc] initWithJSONData:result
                                                        error:error];
}

- (NSArray<B2Bucket *> *)listBucketsForAccount:(B2Account *)account
                                      bucketId:(nullable NSString *)bucketId
                                    bucketName:(nullable NSString *)bucketName
                                   bucketTypes:(B2BucketType)bucketTypes
                                         error:(out NSError *__autoreleasing *)error
{
    NSData *payload = [NSJSONSerialization dataWithJSONObject:@{ @"accountId": [account accountId],
                                                                 @"bucketId": bucketId ? (NSString *)bucketId : [NSNull new],
                                                                 @"bucketName": bucketName ? (NSString *)bucketName : [NSNull new],
                                                                 @"bucketTypes": bucketTypes != B2BucketTypeNone ? NSArrayFromB2BucketType(bucketTypes) : [NSNull new] }
                                                      options:NSJSONWritingPrettyPrinted
                                                        error:error];
    if (!payload) {
        return nil;
    }
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:B2EndpointListBucketsURL([account apiURL])];
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest setHTTPBody:payload];
    if (!mutableRequest) {
        return nil;
    }
    NSData *result = [[self client] performDownloadRequest:mutableRequest
                                                   account:account
                                                     error:error];
    return !result ? nil : [B2Bucket bucketsFromJSONData:result
                                                   error:error];
}

- (B2Bucket *)deleteBucketWithBucketId:(NSString *)bucketId
                               account:(B2Account *)account
                                 error:(out NSError *__autoreleasing *)error
{
    NSData *payload = [NSJSONSerialization dataWithJSONObject:@{ @"accountId": [account accountId],
                                                                 @"bucketId": bucketId }
                                                      options:NSJSONWritingPrettyPrinted
                                                        error:error];
    if (!payload) {
        return nil;
    }
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:B2EndpointDeleteBucketURL([account apiURL])];
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest setHTTPBody:payload];
    if (!mutableRequest) {
        return nil;
    }
    NSData *result = [[self client] performDownloadRequest:mutableRequest
                                                   account:account
                                                     error:error];
    return !result ? nil : [[B2Bucket alloc] initWithJSONData:result
                                                        error:error];
}

- (B2Bucket *)updateBucketWithBucketId:(NSString *)bucketId
                               account:(B2Account *)account
                            bucketType:(B2BucketType)bucketType
                                  info:(NSDictionary<NSString *, id> *)info
                        lifeCycleRules:(NSArray<B2BucketLifeCycleRule *> *)lifeCycleRules
                                 error:(out NSError *__autoreleasing *)error
{
    NSData *payload = [NSJSONSerialization dataWithJSONObject:@{ @"accountId": [account accountId],
                                                                 @"bucketId": bucketId,
                                                                 @"bucketType": NSStringFromB2BucketType(bucketType),
                                                                 @"bucketInfo": info ? (NSDictionary<NSString *, id> *)info : [NSNull new],
                                                                 @"lifecycleRules": lifeCycleRules ? [B2BucketLifeCycleRule toDictionaries:(NSArray<B2BucketLifeCycleRule *> *)lifeCycleRules] : [NSNull new] }
                                                      options:NSJSONWritingPrettyPrinted
                                                        error:error];
    if (!payload) {
        return nil;
    }
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:B2EndpointUpdateBucketURL([account apiURL])];
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest setHTTPBody:payload];
    if (!mutableRequest) {
        return nil;
    }
    NSData *result = [[self client] performDownloadRequest:mutableRequest
                                                   account:account
                                                     error:error];
    return !result ? nil : [[B2Bucket alloc] initWithJSONData:result
                                                        error:error];
}

@end
