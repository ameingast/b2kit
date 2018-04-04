//
//  B2BucketManagerTests.m
//  B2KitTests
//
//  Created by Andreas Meingast on 27.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"
#import "B2BucketManager.h"

@interface B2BucketManagerTests : B2KitTestCase

@property (readwrite, nonatomic, nonnull) B2BucketManager *bucketManager;
@property (readwrite, nonatomic, nonnull) B2Account *account;

@end

@implementation B2BucketManagerTests

@synthesize bucketManager = _bucketManager;
@synthesize account = _account;

- (void)setUp
{
    [super setUp];
    [self setAccount:[[B2Account alloc] initWithIdentifier:@"accountId"
                                                     token:@"test-key"
                                       accountCapabilities:B2AccountCapabilityNone
                                                    apiURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL"]
                                               downloadURL:(NSURL *)[NSURL URLWithString:@"http://example.com/downloadURL"]
                                       recommendedPartSize:@(1)
                                   absoluteMinimumPartSize:@(2)]];
    [self setBucketManager:[[B2BucketManager alloc] initWithClient:[self client]]];
}

- (void)testCreateBucketWithName
{
    NSError *error;
    [self addMockResponse:@{ @"accountId": @"accountId",
                             @"bucketId": @"bucketId",
                             @"bucketInfo": @{},
                             @"bucketName": @"bucketName",
                             @"bucketType": @"allPublic",
                             @"lifecycleRules": @[],
                             @"revision": @(1) }];
    NSMutableURLRequest *expectedRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL/b2api/v1/b2_create_bucket"]
                                                                    httpMethod:@"POST"
                                                                      httpBody:@{ @"accountId": @"accountId",
                                                                                  @"bucketName": @"bucketName",
                                                                                  @"bucketType": @"allPublic",
                                                                                  @"bucketInfo": @{},
                                                                                  @"lifecycleRules": @[] }
                                                                       headers:@{}];
    B2Bucket *expectedBucket = [[B2Bucket alloc] initWithAccountId:@"accountId"
                                                          bucketId:@"bucketId"
                                                        bucketName:@"bucketName"
                                                        bucketType:B2BucketTypeAllPublic
                                                        bucketInfo:@{} lifeCycleRules:@[]
                                                          revision:@(1)];
    B2Bucket *bucket = [[self bucketManager] createBucketWithBucketName:@"bucketName"
                                                                account:[self account]
                                                             bucketType:B2BucketTypeAllPublic
                                                                   info:@{}
                                                         lifeCycleRules:@[]
                                                                  error:&error];
    [self verifyURLRequest:expectedRequest];
    XCTAssertEqualObjects(expectedBucket, bucket);
}

- (void)testCreateBucketWithNameFailsWithError
{
    NSError *error, *thrownError = [NSError new];
    [[self client] setError:thrownError];
    B2Bucket *bucket = [[self bucketManager] createBucketWithBucketName:@"bucketName"
                                                                account:[self account]
                                                             bucketType:B2BucketTypeAllPublic
                                                                   info:@{}
                                                         lifeCycleRules:@[]
                                                                  error:&error];
    XCTAssertNil(bucket);
    XCTAssertEqualObjects(thrownError, error);
}

- (void)testListBucketsForAccountWithAccountId
{
    NSError *error;
    [self addMockResponse:@{ @"buckets": @[ @{ @"accountId": @"accountId",
                                               @"bucketId": @"bucketId",
                                               @"bucketInfo": @{},
                                               @"bucketName": @"bucketName",
                                               @"bucketType": @"allPublic",
                                               @"lifecycleRules": @[],
                                               @"revision": @(1) } ] }];
    NSMutableURLRequest *expectedRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL/b2api/v1/b2_list_buckets"]
                                                                    httpMethod:@"POST"
                                                                      httpBody:@{ @"accountId": @"accountId",
                                                                                  @"bucketId": @"bucketId",
                                                                                  @"bucketName": @"bucketName",
                                                                                  @"bucketTypes": @[ @"allPublic" ] }
                                                                       headers:@{}];
    B2Bucket *expectedBucket = [[B2Bucket alloc] initWithAccountId:@"accountId"
                                                          bucketId:@"bucketId"
                                                        bucketName:@"bucketName"
                                                        bucketType:B2BucketTypeAllPublic
                                                        bucketInfo:@{}
                                                    lifeCycleRules:@[]
                                                          revision:@(1)];
    NSArray<B2Bucket *> *buckets = [[self bucketManager] listBucketsForAccount:[self account]
                                                                      bucketId:@"bucketId"
                                                                    bucketName:@"bucketName"
                                                                   bucketTypes:B2BucketTypeAllPublic
                                                                         error:&error];
    [self verifyURLRequest:expectedRequest];
    XCTAssertEqualObjects(@[ expectedBucket ], buckets);
    
}

- (void)testListBucketsForAccountWithAccountIdFailsWithError
{
    NSError *error, *thrownError = [NSError new];
    [[self client] setError:thrownError];
    NSArray<B2Bucket *> *buckets = [[self bucketManager] listBucketsForAccount:[self account]
                                                                      bucketId:@"bucketId"
                                                                    bucketName:@"bucketName"
                                                                   bucketTypes:B2BucketTypeAllPublic
                                                                         error:&error];
    XCTAssertNil(buckets);
    XCTAssertEqualObjects(thrownError, error);
}

- (void)testDeleteBucketWithBucketId
{
    NSError *error;
    [self addMockResponse:@{ @"accountId": @"accountId",
                             @"bucketId": @"bucketId",
                             @"bucketInfo": @{},
                             @"bucketName": @"bucketName",
                             @"bucketType": @"allPublic",
                             @"lifecycleRules": @[],
                             @"revision": @(1) }];
    NSMutableURLRequest *expectedRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL/b2api/v1/b2_delete_bucket"]
                                                                    httpMethod:@"POST"
                                                                      httpBody:@{ @"accountId": @"accountId",
                                                                                  @"bucketId": @"bucketId" }
                                                                       headers:@{}];
    B2Bucket *expectedBucket = [[B2Bucket alloc] initWithAccountId:@"accountId"
                                                          bucketId:@"bucketId"
                                                        bucketName:@"bucketName"
                                                        bucketType:B2BucketTypeAllPublic
                                                        bucketInfo:@{}
                                                    lifeCycleRules:@[]
                                                          revision:@(1)];
    B2Bucket *bucket = [[self bucketManager] deleteBucketWithBucketId:@"bucketId"
                                                              account:[self account]
                                                                error:&error];
    [self verifyURLRequest:expectedRequest];
    XCTAssertEqualObjects(expectedBucket, bucket);
}

- (void)testDeleteBucketWithBucketIdFailsWithError
{
    NSError *error, *thrownError = [NSError new];
    [[self client] setError:thrownError];
    B2Bucket *bucket = [[self bucketManager] deleteBucketWithBucketId:@"bucketId"
                                                              account:[self account]
                                                                error:&error];
    XCTAssertNil(bucket);
    XCTAssertEqualObjects(thrownError, error);
}

- (void)testUpdateBucketWithBucketId
{
    NSError *error;
    [self addMockResponse:@{ @"accountId": @"accountId",
                             @"bucketId": @"bucketId",
                             @"bucketInfo": @{},
                             @"bucketName": @"bucketName",
                             @"bucketType": @"allPublic",
                             @"lifecycleRules": @[],
                             @"revision": @(1) }];
    NSMutableURLRequest *expectedRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL/b2api/v1/b2_update_bucket"]
                                                                    httpMethod:@"POST"
                                                                      httpBody:@{ @"accountId": @"accountId",
                                                                                  @"bucketId": @"bucketId",
                                                                                  @"bucketType": @"snapshot",
                                                                                  @"bucketInfo": @{},
                                                                                  @"lifecycleRules": @[] }
                                                                       headers:@{}];
    B2Bucket *expectedBucket = [[B2Bucket alloc] initWithAccountId:@"accountId"
                                                          bucketId:@"bucketId"
                                                        bucketName:@"bucketName"
                                                        bucketType:B2BucketTypeAllPublic
                                                        bucketInfo:@{}
                                                    lifeCycleRules:@[]
                                                          revision:@(1)];
    B2Bucket *bucket = [[self bucketManager] updateBucketWithBucketId:@"bucketId"
                                                              account:[self account]
                                                           bucketType:B2BucketTypeSnapshot
                                                                 info:@{}
                                                       lifeCycleRules:@[]
                                                                error:&error];
    [self verifyURLRequest:expectedRequest];
    XCTAssertEqualObjects(expectedBucket, bucket);
}

- (void)testUpdateBucketWithBucketIdFailsWithError
{
    NSError *error, *thrownError = [NSError new];
    [[self client] setError:thrownError];
    B2Bucket *bucket = [[self bucketManager] updateBucketWithBucketId:@"bucketId"
                                                              account:[self account]
                                                           bucketType:B2BucketTypeSnapshot
                                                                 info:@{}
                                                       lifeCycleRules:@[]
                                                                error:&error];
    XCTAssertNil(bucket);
    XCTAssertEqualObjects(thrownError, error);
}

@end
