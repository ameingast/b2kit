//
//  B2KitFileIntegrationTests.m
//  B2KitIntegrationTests
//
//  Created by Andreas Meingast on 05.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"

@interface B2KitFileIntegrationTests : B2KitTestCase

@property (atomic, readwrite) B2Account *account;
@property (atomic, readwrite) B2Bucket *bucket;

@end

@implementation B2KitFileIntegrationTests

@synthesize account = _account;
@synthesize bucket = _bucket;

- (void)setUp
{
    NSError *error;
    [super setUp];
    [self setAccount:[[self b2] authorizeAccountWithAccountId:[self accountId]
                                               applicationKey:[self applicationKey]
                                                        error:&error]];
    if (![self account]) {
        XCTFail(@"Authorization failed: %@", error);
        return;
    }
    [self setBucket:[[self b2] createBucketWithBucketName:[self randomBucketName]
                                                  account:[self account]
                                               bucketType:B2BucketTypeAllPrivate
                                                     info:nil
                                           lifeCycleRules:nil
                                                    error:&error]];
    if (![self bucket]) {
        XCTFail(@"Bucket creation failed: %@", error);
        return;
    }
}

- (void)tearDown
{
    NSError *error;
    if ([self bucket]) {
        (void)[[self b2] deleteBucketWithBucketId:[[self bucket] bucketId]
                                          account:[self account]
                                            error:&error];
    }
    [super tearDown];
}

- (void)testFiles
{
    NSError *error;
    B2File *file = [[self b2] uploadFileAtURL:[self randomDataURL]
                                      account:[self account]
                                     fileName:@"test.bin"
                                 sha1Checksum:[self randomDataSha1Checksum]
                                     bucketId:[[self bucket] bucketId]
                                  contentType:@"application/octet-stream"
                               lastModifiedOn:0
                                     fileInfo:nil
                                        error:&error];
    if (!file) {
        XCTFail(@"File upload failed: %@", error);
        return;
    }
    B2FileNames *fileNames = [[self b2] listFilesWithBucketId:[[self bucket] bucketId]
                                                      account:[self account]
                                                startFileName:nil
                                                 maxFileCount:nil
                                                       prefix:nil
                                                        error:&error];
    if (!fileNames) {
        XCTFail(@"File name listing failed: %@", error);
        return;
    }
    B2FileVersions *fileVersions = [[self b2] listFileVersionsWithBucketId:[[self bucket] bucketId]
                                                                   account:[self account]
                                                               startFileId:nil
                                                             startFileName:nil
                                                              maxFileCount:nil
                                                                    prefix:nil
                                                                     error:&error];
    if (!fileVersions) {
        XCTFail(@"File version listing failed: %@", error);
        return;
    }
    BOOL downloadByIdResult = [[self b2] downloadFileWithFileId:[file fileId]
                                                        account:[self account]
                                                          range:nil
                                                    locationURL:[self targetURL]
                                                          error:&error];
    XCTAssertEqualObjects([self randomData], [NSData dataWithContentsOfURL:[self targetURL]]);
    if (!downloadByIdResult) {
        XCTFail(@"File download failed: %@", error);
        return;
    }
    (void)[[NSFileManager defaultManager] removeItemAtURL:[self targetURL]
                                                    error:nil];
    BOOL downloadByNameResult = [[self b2] downloadFileWithFileName:@"test.bin"
                                                         bucketName:[[self bucket] bucketName]
                                                            account:[self account]
                                                              range:nil
                                                        locationURL:[self targetURL]
                                                              error:&error];
    XCTAssertEqualObjects([self randomData], [NSData dataWithContentsOfURL:[self targetURL]]);
    if (!downloadByNameResult) {
        XCTFail(@"File download failed: %@", error);
        return;
    }
    B2File *fileInfo = [[self b2] fileInfoForFileId:[file fileId]
                                            account:[self account]
                                              error:&error];
    if (!fileInfo) {
        XCTFail(@"File Info failed: %@", error);
        return;
    }
    BOOL deleteResult = [[self b2] deleteFileWithFileId:[file fileId]
                                               fileName:@"test.bin"
                                                account:[self account]
                                                  error:&error];
    if (!deleteResult) {
        XCTFail(@"File deletion failed: %@", error);
        return;
    }
}

- (void)testLargeFiles
{
    NSError *error;
    NSString *fileId = [[self b2] startUploadForFilename:@"test-large.bin"
                                                 account:[self account]
                                                bucketId:[[self bucket] bucketId]
                                             contentType:@"application/octet-stream"
                                                fileInfo:nil
                                                   error:&error];
    if (!fileId) {
        XCTFail(@"File upload start failed: %@", error);
        return;
    }
    BOOL uploadResultOne = [[self b2] uploadPartForFileId:fileId
                                                  account:[self account]
                                                     data:[self alternativeRandomDataURL]
                                                   number:@(1)
                                            contentLength:@(6291456)
                                      contentSha1Checksum:[self alternativeRandomDataSha1Checksum]
                                                    error:&error];
    if (!uploadResultOne) {
        XCTFail(@"File upload part one failed: %@", error);
        return;
    }
    BOOL uploadResultTwo = [[self b2] uploadPartForFileId:fileId
                                                  account:[self account]
                                                     data:[self alternativeRandomDataURL]
                                                   number:@(2)
                                            contentLength:@(6291456)
                                      contentSha1Checksum:[self alternativeRandomDataSha1Checksum]
                                                    error:&error];
    if (!uploadResultTwo) {
        XCTFail(@"File upload part two failed: %@", error);
        return;
    }
    B2UnfinishedLargeFiles *unfinishedFiles = [[self b2] listUnfinishedFilesForBucketId:[[self bucket] bucketId]
                                                                                account:[self account]
                                                                            startFileId:nil
                                                                           maxFileCount:nil
                                                                                  error:&error];
    if (!unfinishedFiles) {
        XCTFail(@"Unfinished large file listing failed: %@", error);
        return;
    }
    B2Parts *parts = [[self b2] listPartsForFileId:fileId
                                           account:[self account]
                                   startPartNumber:nil
                                      maxPartCount:nil
                                             error:&error];
    if (!parts) {
        XCTFail(@"Part file listing failed: %@", error);
        return;
    }
    BOOL finishResult = [[self b2] finishUploadForFileId:fileId
                                                 account:[self account]
                                    contentSha1Checksums:@[ [self alternativeRandomDataSha1Checksum],
                                                            [self alternativeRandomDataSha1Checksum] ]
                                                   error:&error];
    if (!finishResult) {
        XCTFail(@"File upload finish failed: %@", error);
        return;
    }
    BOOL deleteResult = [[self b2] deleteFileWithFileId:fileId
                                               fileName:@"test-large.bin"
                                                account:[self account]
                                                  error:&error];
    if (!deleteResult) {
        XCTFail(@"File delete failed: %@", error);
        return;
    }
}

@end
