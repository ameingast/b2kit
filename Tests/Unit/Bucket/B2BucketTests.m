//
//  B2BucketTests.m
//  B2KitTests
//
//  Created by Andreas Meingast on 27.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"
#import "B2Bucket+Private.h"

@interface B2BucketTests : B2KitTestCase

@end

@implementation B2BucketTests

- (void)initWithAccountId
{
    B2Bucket *bucket = [[B2Bucket alloc] initWithAccountId:@"accountId"
                                                  bucketId:@"bucketId"
                                                bucketName:@"bucketName"
                                                bucketType:B2BucketTypeAllPrivate
                                                bucketInfo:@{}
                                            lifeCycleRules:@[]
                                                  revision:@(1)];
    XCTAssertEqualObjects(@"accountId", [bucket accountId]);
    XCTAssertEqualObjects(@"bucketId", [bucket bucketId]);
    XCTAssertEqualObjects(@"bucketName", [bucket bucketName]);
    XCTAssertEqual(B2BucketTypeAllPrivate, [bucket bucketType]);
    XCTAssertEqualObjects(@{}, [bucket bucketInfo]);
    XCTAssertEqualObjects(@[], [bucket lifeCycleRules]);
    XCTAssertEqualObjects(@(1), [bucket revision]);
}

- (void)testBucketsFromJSONData
{
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{ @"buckets": @[ @{ @"accountId": @"accountId",
                                                                                @"bucketId": @"bucketId",
                                                                                @"bucketInfo": @{},
                                                                                @"bucketName" : @"bucketName",
                                                                                @"bucketType": @"allPrivate",
                                                                                @"lifecycleRules": @[],
                                                                                @"revision": @(1) } ] }
                                                   options:0
                                                     error:&error];
    NSArray<B2Bucket *> *buckets = [B2Bucket bucketsFromJSONData:data
                                                           error:&error];
    B2Bucket *expectedBucket = [[B2Bucket alloc] initWithAccountId:@"accountId"
                                                          bucketId:@"bucketId"
                                                        bucketName:@"bucketName"
                                                        bucketType:B2BucketTypeAllPrivate
                                                        bucketInfo:@{}
                                                    lifeCycleRules:@[]
                                                          revision:@(1)];
    XCTAssertEqualObjects(@[expectedBucket], buckets);
}

- (void)testInitWithJSONData
{
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{ @"accountId": @"accountId",
                                                              @"bucketId": @"bucketId",
                                                              @"bucketInfo": @{},
                                                              @"bucketName" : @"bucketName",
                                                              @"bucketType": @"allPrivate",
                                                              @"lifecycleRules": @[],
                                                              @"revision": @(1) }
                                                   options:0
                                                     error:&error];
    B2Bucket *bucket = [[B2Bucket alloc] initWithJSONData:data
                                                    error:&error];
    B2Bucket *expectedBucket = [[B2Bucket alloc] initWithAccountId:@"accountId"
                                                          bucketId:@"bucketId"
                                                        bucketName:@"bucketName"
                                                        bucketType:B2BucketTypeAllPrivate
                                                        bucketInfo:@{}
                                                    lifeCycleRules:@[]
                                                          revision:@(1)];
    XCTAssertEqualObjects(expectedBucket, bucket);
}

- (void)testInitWithJSONDataFailsWithInvalidJSON
{
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:@{}
                                                   options:0
                                                     error:&error];
    B2Bucket *bucket = [[B2Bucket alloc] initWithJSONData:data
                                                    error:&error];
    XCTAssertNil(bucket);
}

@end
