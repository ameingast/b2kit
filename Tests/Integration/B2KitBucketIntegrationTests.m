//
//  B2KitBucketIntegrationTests.m
//  B2KitIntegrationTests
//
//  Created by Andreas Meingast on 05.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"

@interface B2KitBucketIntegrationTests : B2KitTestCase

@end

@implementation B2KitBucketIntegrationTests

- (void)testBuckets
{
    NSError *error;
    B2Account *account = [[self b2] authorizeAccountWithAccountId:[self accountId]
                                                   applicationKey:[self applicationKey]
                                                            error:&error];
    if (!account) {
        XCTFail(@"Authorization failed: %@", [error description]);
        return;
    }
    B2Bucket *createdBucket = [[self b2] createBucketWithBucketName:[self randomBucketName]
                                                            account:account
                                                         bucketType:B2BucketTypeAllPrivate
                                                               info:nil
                                                     lifeCycleRules:nil
                                                              error:&error];
    if (!createdBucket) {
        XCTFail(@"Bucket creation failed: %@", error);
        return;
    }
    B2Bucket *updatedBucket = [[self b2] updateBucketWithBucketId:[createdBucket bucketId]
                                                          account:account
                                                       bucketType:B2BucketTypeAllPublic
                                                             info:nil
                                                   lifeCycleRules:nil
                                                            error:&error];
    if (!updatedBucket) {
        XCTFail(@"Bucket update failed: %@", error);
        return;
    }
    NSArray<B2Bucket *> *buckets = [[self b2] listBucketsForAccount:account
                                                           bucketId:nil
                                                         bucketName:nil
                                                        bucketTypes:B2BucketTypeAllPrivate
                                                              error:&error];
    if (!buckets) {
        XCTFail(@"Bucket listing failed: %@", error);
        return;
    }
    B2Bucket *deletedBucket = [[self b2] deleteBucketWithBucketId:[createdBucket bucketId]
                                                          account:account
                                                            error:&error];
    if (!deletedBucket) {
        XCTFail(@"Bucket deletion failed: %@", error);
        return;
    }
}

@end
