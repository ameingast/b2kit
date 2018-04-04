//
//  B2+Buckets.m
//  B2Kit
//
//  Created by Andreas Meingast on 05.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2.h"
#import "B2BucketManager.h"

@implementation B2 (Buckets)

- (B2Bucket *)createBucketWithBucketName:(NSString *)bucketName
                                 account:(B2Account *)account
                              bucketType:(B2BucketType)bucketType
                                    info:(NSDictionary<NSString *, id> *)info
                          lifeCycleRules:(NSArray<B2BucketLifeCycleRule *> *)lifeCycleRules
                                   error:(out NSError *__autoreleasing *)error
{
    return [[[B2BucketManager alloc] initWithClient:[self client]] createBucketWithBucketName:bucketName
                                                                                      account:account
                                                                                   bucketType:bucketType
                                                                                         info:info
                                                                               lifeCycleRules:lifeCycleRules
                                                                                        error:error];
}

- (NSArray<B2Bucket *>*)listBucketsForAccount:(B2Account *)account
                                     bucketId:(NSString *)bucketId
                                   bucketName:(NSString *)bucketName
                                  bucketTypes:(B2BucketType)bucketTypes
                                        error:(out NSError *__autoreleasing *)error
{
    return [[[B2BucketManager alloc] initWithClient:[self client]] listBucketsForAccount:account
                                                                                bucketId:bucketId
                                                                              bucketName:bucketName
                                                                             bucketTypes:bucketTypes
                                                                                   error:error];
}

- (B2Bucket *)deleteBucketWithBucketId:(NSString *)bucketId
                               account:(B2Account *)account
                                 error:(out NSError *__autoreleasing *)error
{
    return [[[B2BucketManager alloc] initWithClient:[self client]] deleteBucketWithBucketId:bucketId
                                                                                    account:account
                                                                                      error:error];
}

- (B2Bucket *)updateBucketWithBucketId:(NSString *)bucketId
                               account:(B2Account *)account
                            bucketType:(B2BucketType)bucketType
                                  info:(NSDictionary<NSString *, id> *)info
                        lifeCycleRules:(NSArray<B2BucketLifeCycleRule *> *)lifeCycleRules
                                 error:(out NSError *__autoreleasing *)error
{
    return [[[B2BucketManager alloc] initWithClient:[self client]] updateBucketWithBucketId:bucketId
                                                                                    account:account
                                                                                 bucketType:bucketType
                                                                                       info:info
                                                                             lifeCycleRules:lifeCycleRules
                                                                                      error:error];
}

@end
