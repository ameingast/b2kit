//
//  B2BucketManager.h
//  B2Kit
//
//  Created by Andreas Meingast on 07.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

@import Foundation;

#import "B2BucketType.h"

@class B2Bucket;
@class B2Account;
@class B2BucketLifeCycleRule;
@protocol B2Client;

NS_ASSUME_NONNULL_BEGIN

@interface B2BucketManager : NSObject

@property (readonly, nonatomic) id<B2Client> client;

- (B2BucketManager *)initWithClient:(id<B2Client>)client;
- (nullable B2Bucket *)createBucketWithBucketName:(NSString *)bucketName
                                          account:(B2Account *)account
                                       bucketType:(B2BucketType)bucketType
                                             info:(nullable NSDictionary<NSString *, id> *)info
                                   lifeCycleRules:(nullable NSArray<B2BucketLifeCycleRule *> *)lifeCycleRules
                                            error:(out NSError **)error;
- (nullable NSArray<B2Bucket *>*)listBucketsForAccount:(B2Account *)account
                                              bucketId:(nullable NSString *)bucketId
                                            bucketName:(nullable NSString *)bucketName
                                           bucketTypes:(B2BucketType)bucketTypes
                                                 error:(out NSError **)error;
- (nullable B2Bucket *)deleteBucketWithBucketId:(NSString *)bucketId
                                        account:(B2Account *)account
                                          error:(out NSError **)error;
- (nullable B2Bucket *)updateBucketWithBucketId:(NSString *)bucketId
                                        account:(B2Account *)account
                                     bucketType:(B2BucketType)bucketType
                                           info:(nullable NSDictionary<NSString *, id> *)info
                                 lifeCycleRules:(nullable NSArray<B2BucketLifeCycleRule *> *)lifeCycleRules
                                          error:(out NSError **)error;

@end

NS_ASSUME_NONNULL_END
