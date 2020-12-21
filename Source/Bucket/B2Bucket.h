//
//  B2Bucket.h
//  B2Kit
//
//  Created by Andreas Meingast on 04.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <B2Kit/B2BucketType.h>

@class B2BucketLifeCycleRule;

NS_ASSUME_NONNULL_BEGIN

@interface B2Bucket : NSObject

@property (nonatomic, readonly, nonnull) NSString *accountId;
@property (nonatomic, readonly, nonnull) NSString *bucketId;
@property (nonatomic, readonly, nonnull) NSString *bucketName;
@property (nonatomic, readonly) B2BucketType bucketType;
@property (nonatomic, readonly, nullable) NSDictionary<NSString *, id> *bucketInfo;
@property (nonatomic, readonly, nullable) NSArray<B2BucketLifeCycleRule *> *lifeCycleRules;
@property (nonatomic, readonly, nonnull) NSNumber *revision;

- (B2Bucket *)initWithAccountId:(NSString *)accountId
                       bucketId:(NSString *)bucketId
                     bucketName:(NSString *)bucketName
                     bucketType:(B2BucketType)bucketType
                     bucketInfo:(nullable NSDictionary<NSString *, id> *)bucketInfo
                 lifeCycleRules:(nullable NSArray<B2BucketLifeCycleRule *> *)lifeCycleRules
                       revision:(NSNumber *)revision;

@end

NS_ASSUME_NONNULL_END
