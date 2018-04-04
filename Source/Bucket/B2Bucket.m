//
//  B2Bucket.m
//  B2Kit
//
//  Created by Andreas Meingast on 04.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2Bucket.h"

@implementation B2Bucket

@synthesize accountId = _accountId;
@synthesize bucketId = _bucketId;
@synthesize bucketName = _bucketName;
@synthesize bucketType = _bucketType;
@synthesize bucketInfo = _bucketInfo;
@synthesize lifeCycleRules = _lifeCycleRules;
@synthesize revision = _revision;

- (B2Bucket *)initWithAccountId:(NSString *)accountId
                       bucketId:(NSString *)bucketId
                     bucketName:(NSString *)bucketName
                     bucketType:(B2BucketType)bucketType
                     bucketInfo:(NSDictionary<NSString *, id> *)bucketInfo
                 lifeCycleRules:(NSArray<B2BucketLifeCycleRule *> *)lifeCycleRules
                       revision:(NSNumber *)revision
{
    self = [self init];
    if (self) {
        _accountId = accountId;
        _bucketId = bucketId;
        _bucketName = bucketName;
        _bucketType = bucketType;
        _bucketInfo = bucketInfo;
        _lifeCycleRules = lifeCycleRules;
        _revision = revision;
    }
    return self;
}

@end
