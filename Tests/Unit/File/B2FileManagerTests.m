//
//  B2FileManagerTests.m
//  B2KitTests
//
//  Created by Andreas Meingast on 27.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"
#import "B2FileManager.h"

@interface B2FileManagerTests : B2KitTestCase

@property (readwrite, nonatomic, nonnull) B2FileManager *fileManager;
@property (readwrite, nonatomic, nonnull) B2Account *account;
@property (readwrite, nonatomic, nonnull) B2Bucket *bucket;

@end

@implementation B2FileManagerTests

@synthesize fileManager = _fileManager;
@synthesize account = _account;
@synthesize bucket = _bucket;

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
    [self setBucket:[[B2Bucket alloc] initWithAccountId:@"accountId"
                                               bucketId:@"bucketId"
                                             bucketName:@"bucketName"
                                             bucketType:B2BucketTypeAllPublic
                                             bucketInfo:@{}
                                         lifeCycleRules:@[]
                                               revision:@(1)]];
    [self setFileManager:[[B2FileManager alloc] initWithClient:[self client]]];
}

- (void)testFileInfoForFileId
{
    NSError *error;
    [self addMockResponse:@{ @"fileId": @"fileId",
                             @"fileName": @"fileName",
                             @"bucketId": @"bucketId",
                             @"accountId": @"accountId",
                             @"contentLength": @(1),
                             @"contentType": @"contentType",
                             @"contentSha1": @"contentSha1",
                             @"fileInfo": @{},
                             @"action": @"upload",
                             @"uploadTimestamp": @(0) } ];
    NSMutableURLRequest *expectedRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL/b2api/v1/b2_get_file_info"]
                                                                    httpMethod:@"POST"
                                                                      httpBody:@{ @"fileId": @"fileId" }
                                                                       headers:@{}];
    B2File *expectedFile = [[B2File alloc] initWithFileId:@"fileId"
                                                 filename:@"fileName"
                                                accountId:@"accountId"
                                                 bucketId:@"bucketId"
                                            contentLength:@(1)
                                              contentSha1:@"contentSha1"
                                              contentType:@"contentType"
                                                 fileInfo:@{}
                                                   action:B2FileInfoActionUploaded
                                               uploadDate:[NSDate dateWithTimeIntervalSince1970:0]];
    B2File *file = [[self fileManager] fileInfoForFileId:@"fileId"
                                                 account:[self account]
                                                   error:&error];
    [self verifyURLRequest:expectedRequest];
    XCTAssertEqualObjects(expectedFile, file);
}

- (void)testFileInfoForFileIdFailsWithError
{
    NSError *error, *thrownError = [NSError new];
    [[self client] setError:thrownError];
    B2File *file = [[self fileManager] fileInfoForFileId:@"fileId"
                                                 account:[self account]
                                                   error:&error];
    XCTAssertNil(file);
    XCTAssertEqualObjects(thrownError, error);
}

- (void)testHideFile
{
    NSError *error;
    [self addMockResponse:@{ @"fileId": @"fileId",
                             @"fileName": @"fileName",
                             @"contentLength": @(0),
                             @"contentType": [NSNull new],
                             @"contentSha1": [NSNull new],
                             @"fileInfo": @{},
                             @"action": @"hide",
                             @"uploadTimestamp": @(0) }];
    NSMutableURLRequest *expectedRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL/b2api/v1/b2_hide_file"]
                                                                    httpMethod:@"POST"
                                                                      httpBody:@{ @"fileName": @"fileName",
                                                                                  @"bucketId": @"bucketId" }
                                                                       headers:@{}];
    BOOL result = [[self fileManager] hideFileWithFileName:@"fileName"
                                                   account:[self account]
                                                    bucket:[self bucket]
                                                     error:&error];
    [self verifyURLRequest:expectedRequest];
    XCTAssertTrue(result);
}

- (void)testHideFileFailsWithError
{
    NSError *error, *thrownError = [NSError new];
    [[self client] setError:thrownError];
    BOOL result = [[self fileManager] hideFileWithFileName:@"fileId"
                                                   account:[self account]
                                                    bucket:[self bucket]
                                                     error:&error];
    XCTAssertFalse(result);
    XCTAssertEqualObjects(thrownError, error);
}

- (void)testListFilesInBucket
{
    NSError *error;
    [self addMockResponse:@{ @"nextFileName": @"nextFileName",
                             @"files": @[ @{ @"fileId": @"fileId",
                                             @"fileName": @"fileName",
                                             @"contentLength": @(1),
                                             @"contentType": @"contentType",
                                             @"contentSha1": @"contentSha1",
                                             @"fileInfo": @{},
                                             @"action": @"upload",
                                             @"uploadTimestamp": @(0) } ] }];
    NSMutableURLRequest *expectedRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL/b2api/v1/b2_list_file_names"]
                                                                    httpMethod:@"POST"
                                                                      httpBody:@{ @"bucketId": @"bucketId",
                                                                                  @"maxFileCount": @(1),
                                                                                  @"prefix": @"prefix",
                                                                                  @"startFileName": @"startFileName" }
                                                                       headers:@{}];
    B2FileNames *expectedFileNames = [[B2FileNames alloc] initWithNextFileName:@"nextFileName"
                                                                         files:@[ [[B2File alloc] initWithFileId:@"fileId"
                                                                                                        filename:@"fileName"
                                                                                                       accountId:@"accountId"
                                                                                                        bucketId:@"bucketId"
                                                                                                   contentLength:@(1)
                                                                                                     contentSha1:@"contentSha1"
                                                                                                     contentType:@"contentType"
                                                                                                        fileInfo:@{}
                                                                                                          action:B2FileInfoActionUploaded
                                                                                                      uploadDate:[NSDate dateWithTimeIntervalSince1970:0]]]];
    B2FileNames *fileNames = [[self fileManager] listFilesWithBucketId:@"bucketId"
                                                               account:[self account]
                                                         startFileName:@"startFileName"
                                                          maxFileCount:@(1)
                                                                prefix:@"prefix"
                                                                 error:&error];
    [self verifyURLRequest:expectedRequest];
    XCTAssertEqualObjects(expectedFileNames, fileNames);
}

- (void)testListFilesInBucketFailsWithError
{
    NSError *error, *thrownError = [NSError new];
    [[self client] setError:thrownError];
    B2FileNames *fileNames = [[self fileManager] listFilesWithBucketId:@"bucketId"
                                                                 account:[self account]
                                                           startFileName:@"startFileName"
                                                            maxFileCount:@(1)
                                                                  prefix:@"prefix"
                                                                   error:&error];
    XCTAssertNil(fileNames);
    XCTAssertEqualObjects(thrownError, error);
}

- (void)testListFileVersionsWithBucketId
{
    NSError *error;
    [self addMockResponse:@{ @"nextFileId": @"nextFileId",
                             @"nextFileName": @"nextFileName",
                             @"files": @[ @{ @"fileId": @"fileId",
                                             @"fileName": @"fileName",
                                             @"contentLength": @(1),
                                             @"contentType": @"contentType",
                                             @"contentSha1": @"contentSha1",
                                             @"fileInfo": @{},
                                             @"action": @"upload",
                                             @"uploadTimestamp": @(0) } ] }];
    NSMutableURLRequest *expectedRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL/b2api/v1/b2_list_file_versions"]
                                                                    httpMethod:@"POST"
                                                                      httpBody:@{ @"bucketId": @"bucketId",
                                                                                  @"maxFileCount": @(1),
                                                                                  @"prefix": @"prefix",
                                                                                  @"startFileName": @"startFileName",
                                                                                  @"startFileId": @"startFileId" }
                                                                       headers:@{}];
    B2FileVersions *expectedFileVersions = [[B2FileVersions alloc] initWithNextFileId:@"nextFileId"
                                                                         nextFileName:@"nextFileName"
                                                                                files:@[ [[B2File alloc] initWithFileId:@"fileId"
                                                                                                               filename:@"fileName"
                                                                                                              accountId:@"accountId"
                                                                                                               bucketId:@"bucketId"
                                                                                                          contentLength:@(1)
                                                                                                            contentSha1:@"contentSha1"
                                                                                                            contentType:@"contentType"
                                                                                                               fileInfo:@{}
                                                                                                                 action:B2FileInfoActionUploaded
                                                                                                             uploadDate:[NSDate dateWithTimeIntervalSince1970:0]]]];
    B2FileVersions * fileVersions = [[self fileManager] listFileVersionsWithBucketId:@"bucketId"
                                                                             account:[self account]
                                                                         startFileId:@"startFileId"
                                                                       startFileName:@"startFileName"
                                                                        maxFileCount:@(1)
                                                                              prefix:@"prefix"
                                                                               error:&error];
    [self verifyURLRequest:expectedRequest];
    XCTAssertEqualObjects(expectedFileVersions, fileVersions);
}

- (void)testListFileVersionsWithBucketIdFailsWithError
{
    NSError *error, *thrownError = [NSError new];
    [[self client] setError:thrownError];
    B2FileVersions *fileVersions = [[self fileManager] listFileVersionsWithBucketId:@"bucketId"
                                                                      account:[self account]
                                                                  startFileId:nil
                                                                startFileName:nil
                                                                 maxFileCount:nil
                                                                       prefix:nil
                                                                        error:&error];
    XCTAssertNil(fileVersions);
    XCTAssertEqualObjects(thrownError, error);
}

- (void)testDeleteFileById
{
    NSError *error;
    [self addMockResponse:@{ @"fileId": @"fileId",
                             @"fileName": @"fileName" }];
    NSMutableURLRequest *expectedRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL/b2api/v1/b2_delete_file_version"]
                                                                    httpMethod:@"POST"
                                                                      httpBody:@{ @"fileId": @"fileId",
                                                                                  @"fileName": @"fileName" }
                                                                       headers:@{}];
    BOOL result = [[self fileManager] deleteFileWithFileId:@"fileId"
                                                  filename:@"fileName"
                                                   account:[self account]
                                                     error:&error];
    [self verifyURLRequest:expectedRequest];
    XCTAssertTrue(result);
}

- (void)testDeleteFileByIdFailsWithError
{
    NSError *error, *thrownError = [NSError new];
    [[self client] setError:thrownError];
    BOOL result = [[self fileManager] deleteFileWithFileId:@"fileId"
                                                  filename:@"fileName"
                                                   account:[self account]
                                                     error:&error];
    XCTAssertFalse(result);
    XCTAssertEqualObjects(thrownError, error);
}

- (void)testUploadURLForBucketId
{
    NSError *error;
    [self addMockResponse:@{ @"uploadUrl": @"http://example.com/uploadURL",
                             @"authorizationToken": @"authorizationToken" }];
    NSMutableURLRequest *expectedRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL/b2api/v1/b2_get_upload_url"]
                                                                    httpMethod:@"POST"
                                                                      httpBody:@{ @"bucketId": @"bucketId" }
                                                                       headers:@{}];
    B2UploadURL *expecetedURL = [[B2UploadURL alloc] initWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/uploadURL"]
                                              authorizationToken:@"authorizationToken"];
    B2UploadURL *URL = [[self fileManager] uploadURLForBucketWithBucketId:@"bucketId"
                                                                  account:[self account]
                                                                    error:&error];
    [self verifyURLRequest:expectedRequest];
    XCTAssertEqualObjects(expecetedURL, URL);
}

- (void)testUploadURLForBucketIdFailsWithError
{
    NSError *error, *thrownError = [NSError new];
    [[self client] setError:thrownError];
    B2UploadURL *URL = [[self fileManager] uploadURLForBucketWithBucketId:@"bucketId"
                                                                  account:[self account]
                                                                    error:&error];
    XCTAssertNil(URL);
    XCTAssertEqualObjects(thrownError, error);
}

- (void)testUploadFileAtURL
{
    NSError *error;
    [self addMockResponse:@{ @"uploadUrl": @"http://example.com/uploadURL",
                             @"authorizationToken": @"authorizationToken" }];
    [self addMockResponse:@{ @"fileId": @"fileId",
                             @"accountId": @"accountId",
                             @"bucketId": @"bucketId",
                             @"fileName": @"fileName",
                             @"contentLength": @(0),
                             @"contentType": @"contentType",
                             @"contentSha1": @"contentSha1",
                             @"fileInfo": @{},
                             @"action": @"upload",
                             @"uploadTimestamp": @(1000) }];
    NSMutableURLRequest *expectedURLRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL/b2api/v1/b2_get_upload_url"]
                                                                       httpMethod:@"POST"
                                                                         httpBody:@{ @"bucketId": @"bucketId" }
                                                                          headers:@{}];
    NSMutableURLRequest *expectedUploadRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/uploadURL"]
                                                                          httpMethod:@"POST"
                                                                            httpBody:nil
                                                                             headers:@{ @"Authorization": @"authorizationToken",
                                                                                        @"X-Bz-File-Name": @"fileName",
                                                                                        @"Content-Type": @"contentType",
                                                                                        @"X-Bz-Content-Sha1": @"contentSha1",
                                                                                        @"X-Bz-Info-src_last_modified_millis": @"1000",
                                                                                        @"X-Bz-Info-Info1": @"Info1",
                                                                                        @"X-Bz-Info-Info2": @"Info2" }];
    B2File *expectedFile = [[B2File alloc] initWithFileId:@"fileId"
                                                 filename:@"fileName"
                                                accountId:@"accountId"
                                                 bucketId:@"bucketId"
                                            contentLength:@(0)
                                              contentSha1:@"contentSha1"
                                              contentType:@"contentType"
                                                 fileInfo:@{}
                                                   action:B2FileInfoActionUploaded
                                               uploadDate:[NSDate dateWithTimeIntervalSince1970:1]];
    B2File *file = [[self fileManager] uploadFileAtURL:(NSURL *)[NSURL URLWithString:@"file:///file"]
                                               account:[self account]
                                              fileName:@"fileName"
                                          sha1Checksum:@"contentSha1"
                                            intoBucket:@"bucketId"
                                           contentType:@"contentType"
                                        lastModifiedOn:[NSDate dateWithTimeIntervalSince1970:1]
                                              fileInfo:@{ @"Info1": @"Info1",
                                                          @"Info2": @"Info2" }
                                                 error:&error];
    [self verifyURLRequest:expectedURLRequest];
    [self verifyURLRequest:expectedUploadRequest];
    XCTAssertEqualObjects(expectedFile, file);
}

- (void)testUploadFileAtURLFailsWithError
{
    NSError *error, *thrownError = [NSError new];
    [[self client] setError:thrownError];
    B2File *file = [[self fileManager] uploadFileAtURL:(NSURL *)[NSURL URLWithString:@"file:///file"]
                                               account:[self account]
                                              fileName:@"fileName"
                                          sha1Checksum:@"contentSha1"
                                            intoBucket:@"bucketId"
                                           contentType:@"contentType"
                                        lastModifiedOn:[NSDate dateWithTimeIntervalSince1970:0]
                                              fileInfo:@{}
                                                 error:&error];
    XCTAssertNil(file);
    XCTAssertEqualObjects(thrownError, error);
}

- (void)testDownloadFileById
{
    NSError *error;
    [[self client] setFileDownloadResponse:YES];
    NSMutableURLRequest *expectedRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL/b2api/v1/b2_download_file_by_id?fileId=fileId"]
                                                                    httpMethod:@"GET"
                                                                      httpBody:nil
                                                                       headers:@{ @"Range": @"bytes=0-1" }];
    BOOL result = [[self fileManager] downloadFileWithFileId:@"fileId"
                                                     account:[self account]
                                                       range:[[B2Range alloc] initWithStart:@(0)
                                                                                        end:@(1)]
                                                 locationURL:(NSURL *)[NSURL URLWithString:@"file:///"]
                                                       error:&error];
    [self verifyURLRequest:expectedRequest];
    XCTAssertTrue(result);
}

- (void)testDownloadFileByIdFailsWithError
{
    NSError *error, *thrownError = [NSError new];
    [[self client] setError:thrownError];
    BOOL result = [[self fileManager] downloadFileWithFileId:@"fileId"
                                                     account:[self account]
                                                       range:[[B2Range alloc] initWithStart:@(0)
                                                                                        end:@(1)]
                                                 locationURL:(NSURL *)[NSURL URLWithString:@"file:///"]
                                                       error:&error];
    XCTAssertFalse(result);
    XCTAssertEqualObjects(thrownError, error);
}

- (void)testDownloadFileByName
{
    NSError *error;
    [[self client] setFileDownloadResponse:YES];
    NSMutableURLRequest *expectedRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/downloadURL/file/bucketName/fileName"]
                                                                    httpMethod:@"GET"
                                                                      httpBody:nil
                                                                       headers:@{ @"Range": @"bytes=0-1" }];
    BOOL result = [[self fileManager] downloadFileWithFileName:@"fileName"
                                                    bucketName:@"bucketName"
                                                       account:[self account]
                                                         range:[[B2Range alloc] initWithStart:@(0)
                                                                                          end:@(1)]
                                                   locationURL:(NSURL *)[NSURL URLWithString:@"file:///"]
                                                         error:&error];
    [self verifyURLRequest:expectedRequest];
    XCTAssertTrue(result);
}

- (void)testDownloadFileByNameFailsWithError
{
    NSError *error, *thrownError = [NSError new];
    [[self client] setError:thrownError];
    BOOL result = [[self fileManager] downloadFileWithFileName:@"fileName"
                                                    bucketName:@"bucketName"
                                                       account:[self account]
                                                         range:[[B2Range alloc] initWithStart:@(0)
                                                                                          end:@(1)]
                                                   locationURL:(NSURL *)[NSURL URLWithString:@"file:///"]
                                                         error:&error];
    XCTAssertFalse(result);
    XCTAssertEqualObjects(thrownError, error);
}

- (void)testUploadPartURLForFileId
{
    NSError *error;
    [self addMockResponse:@{ @"uploadUrl": @"http://example.com",
                             @"authorizationToken": @"authorizationToken" }];
    NSMutableURLRequest *expectedRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL/b2api/v1/b2_get_upload_part_url"]
                                                                    httpMethod:@"POST"
                                                                      httpBody:@{ @"fileId": @"fileId" }
                                                                       headers:@{}];
    B2UploadURL *expectedURL = [[B2UploadURL alloc] initWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com"]
                                             authorizationToken:@"authorizationToken"];
    B2UploadURL *uploadURL = [[self fileManager] uploadPartURLForFileId:@"fileId"
                                                                account:[self account]
                                                                  error:&error];
    [self verifyURLRequest:expectedRequest];
    XCTAssertEqualObjects(expectedURL, uploadURL);
}

- (void)testUploadPartURLForFileIdFailsWithError
{
    NSError *error, *thrownError = [NSError new];
    [[self client] setError:thrownError];
    B2UploadURL *uploadURL = [[self fileManager] uploadPartURLForFileId:@"fileId"
                                                                account:[self account]
                                                                  error:&error];
    XCTAssertNil(uploadURL);
    XCTAssertEqualObjects(thrownError, error);
}

- (void)testStartUploadForFilename
{
    NSError *error;
    [self addMockResponse:@{ @"fileId": @"fileId",
                             @"fileName": @"fileName",
                             @"accountId": @"accountId",
                             @"bucketId": @"bucketId",
                             @"contentType": @"contentType",
                             @"contentSha1": @"contentSha1",
                             @"fileInfo": @{},
                             @"uploadTimestamp": @(0) }];
    NSMutableURLRequest *expectedRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL/b2api/v1/b2_start_large_file"]
                                                                    httpMethod:@"POST"
                                                                      httpBody:@{ @"fileName": @"fileName",
                                                                                  @"bucketId": @"bucketId",
                                                                                  @"contentType": @"contentType",
                                                                                  @"fileInfo": @{@"large_file_sha1": @"contentSha1"} }
                                                                       headers:@{}];
    NSString *fileId = [[self fileManager] startUploadForFileName:@"fileName"
                                                          account:[self account]
                                                         bucketId:@"bucketId"
                                                      contentType:@"contentType"
                                                      contentSha1:@"contentSha1"
                                                         fileInfo:@{}
                                                            error:&error];
    [self verifyURLRequest:expectedRequest];
    XCTAssertEqualObjects(@"fileId", fileId);
}

- (void)testStartUploadForFilenameFailsWithError
{
    NSError *error, *thrownError = [NSError new];
    [[self client] setError:thrownError];
    NSString *fileId = [[self fileManager] startUploadForFileName:@"fileName"
                                                          account:[self account]
                                                         bucketId:@"bucketId"
                                                      contentType:@"contentType"
                                                      contentSha1:@"contentSha1"
                                                         fileInfo:@{}
                                                            error:&error];
    XCTAssertNil(fileId);
    XCTAssertEqualObjects(thrownError, error);
}

- (void)testCancelUploadForFileId
{
    NSError *error;
    [self addMockResponse:@{ @"fileId": @"fileId",
                             @"accountId": @"accountId",
                             @"bucketId": @"bucketId",
                             @"fileName": @"fileName" }];
    NSMutableURLRequest *expectedRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL/b2api/v1/b2_cancel_large_file"]
                                                                    httpMethod:@"POST"
                                                                      httpBody:@{ @"fileId": @"fileId" }
                                                                       headers:@{}];
    BOOL result = [[self fileManager] cancelUploadForFileId:@"fileId"
                                                    account:[self account]
                                                      error:&error];
    [self verifyURLRequest:expectedRequest];
    XCTAssertTrue(result);
    
}

- (void)testCancelUploadForFileIdFailsWithError
{
    NSError *error, *thrownError = [NSError new];
    [[self client] setError:thrownError];
    BOOL result = [[self fileManager] cancelUploadForFileId:@"fileId"
                                                    account:[self account]
                                                      error:&error];
    XCTAssertFalse(result);
    XCTAssertEqualObjects(thrownError, error);
}

- (void)testFinishUploadForFileId
{
    NSError *error;
    [self addMockResponse:@{ @"fileId": @"fileId",
                             @"acountId": @"accountId",
                             @"bucketId": @"bucketId",
                             @"fileName": @"fileName",
                             @"contentLength": @(0),
                             @"contentSha1": @"none",
                             @"contentType": @"contentType",
                             @"fileInfo": @{},
                             @"action": @"upload",
                             @"uploadTimestmap": @(0) }];
    NSMutableURLRequest *expectedRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL/b2api/v1/b2_finish_large_file"]
                                                                    httpMethod:@"POST"
                                                                      httpBody:@{ @"fileId": @"fileId",
                                                                                  @"partSha1Array": @[ @"contentSha1-1", @"contentSha1-2" ] }
                                                                       headers:@{}];
    BOOL result = [[self fileManager] finishUploadForFileId:@"fileId"
                                                    account:[self account]
                                       contentSha1Checksums:@[@"contentSha1-1", @"contentSha1-2"]
                                                      error:&error];
    [self verifyURLRequest:expectedRequest];
    XCTAssertTrue(result);
}

- (void)testFinishUploadForFileIdFailsWithError
{
    NSError *error, *thrownError = [NSError new];
    [[self client] setError:thrownError];
    BOOL result = [[self fileManager] finishUploadForFileId:@"fileId"
                                                    account:[self account]
                                       contentSha1Checksums:@[@"contentSha1-1", @"contentSha1-2"]
                                                      error:&error];
    XCTAssertFalse(result);
    XCTAssertEqualObjects(thrownError, error);
}

- (void)testUploadPartForFileId
{
    NSError *error;
    [self addMockResponse:@{ @"uploadUrl": @"http://example.com/uploadPartURL",
                             @"authorizationToken": @"authorizationToken" }];
    [self addMockResponse:@{ @"fileId": @"fileId",
                             @"partNumber": @(0),
                             @"contentLength": @(0),
                             @"contentSha1": @"contentSha1", }];
    NSMutableURLRequest *expectedUploadPartURLRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL/b2api/v1/b2_get_upload_part_url"]
                                                                                 httpMethod:@"POST"
                                                                                   httpBody:@{ @"fileId": @"fileId" }
                                                                                    headers:@{}];
    NSMutableURLRequest *expectedUploadRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/uploadPartURL"]
                                                                          httpMethod:@"POST"
                                                                            httpBody:nil
                                                                             headers:@{ @"Authorization": @"authorizationToken",
                                                                                        @"X-Bz-Part-Number": @"0",
                                                                                        @"Content-Length": @"0",
                                                                                        @"X-Bz-Content-Sha1": @"contentSha1" }];
    BOOL result = [[self fileManager] uploadPartForFileId:@"fileId"
                                                  account:[self account]
                                             dataLocation:(NSURL *)[NSURL URLWithString:@"file:///file"]
                                               partNumber:@(0)
                                            contentLength:@(0)
                                      contentSha1Checksum:@"contentSha1"
                                                    error:&error];
    [self verifyURLRequest:expectedUploadPartURLRequest];
    [self verifyURLRequest:expectedUploadRequest];
    XCTAssertTrue(result);
}

- (void)testUploadPartForFileIdFailsWithError
{
    NSError *error, *thrownError = [NSError new];
    [[self client] setError:thrownError];
    BOOL result = [[self fileManager] uploadPartForFileId:@"fileId"
                                                  account:[self account]
                                             dataLocation:(NSURL *)[NSURL URLWithString:@"file:///file"]
                                               partNumber:@(0)
                                            contentLength:@(0)
                                      contentSha1Checksum:@"contentSha1"
                                                    error:&error];
    XCTAssertFalse(result);
    XCTAssertEqualObjects(thrownError, error);
}

- (void)testListUnfinishedFilesForBucketId
{
    NSError *error;
    [self addMockResponse:@{ @"nextFileId": @"nextFileId",
                             @"files": @[ @{ @"fileId": @"fileId",
                                             @"accountId": @"accountId",
                                             @"bucketId": @"bucketId",
                                             @"fileName": @"fileName",
                                             @"contentLength": @(0),
                                             @"contentType": @"contentType",
                                             @"fileInfo": @{},
                                             @"action": @"hide",
                                             @"uploadTimestamp": @(0) } ] }];
    NSMutableURLRequest *expectedRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL/b2api/v1/b2_list_unfinished_large_files"]
                                                                    httpMethod:@"POST"
                                                                      httpBody:@{ @"bucketId": @"bucketId",
                                                                                  @"startFileId": @"startFileId",
                                                                                  @"maxFileCount": @(0) }
                                                                       headers:@{ }];
    B2UnfinishedLargeFiles *expectedUnfinishedLargeFiles = [[B2UnfinishedLargeFiles alloc] initWithFiles:@[ [[B2UnfinishedLargeFile alloc] initWithFileId:@"fileId"
                                                                                                                                                 filename:@"fileName"
                                                                                                                                                accountId:@"accountId"
                                                                                                                                                 bucketId:@"bucketId"
                                                                                                                                              contentType:@"contentType"
                                                                                                                                                 fileInfo:@{}
                                                                                                                                          uploadTimestamp:[NSDate dateWithTimeIntervalSince1970:0]] ]
                                                                                              nextFileId:@"nextFileId"];
    B2UnfinishedLargeFiles *unfinishedLargeFiles = [[self fileManager] listUnfinishedFilesForBucketId:@"bucketId"
                                                                                              account:[self account]
                                                                                          startFileId:@"startFileId"
                                                                                         maxFileCount:@(0)
                                                                                                error:&error];
    [self verifyURLRequest:expectedRequest];
    XCTAssertEqualObjects(expectedUnfinishedLargeFiles, unfinishedLargeFiles);
}

- (void)testListUnfinishedFilesForBucketIdFailsWithError
{
    NSError *error, *thrownError = [NSError new];
    [[self client] setError:thrownError];
    B2UnfinishedLargeFiles *unfinishedLargeFiles = [[self fileManager] listUnfinishedFilesForBucketId:@"bucketId"
                                                                                              account:[self account]
                                                                                          startFileId:@"startFileId"
                                                                                         maxFileCount:@(0)
                                                                                                error:&error];
    XCTAssertNil(unfinishedLargeFiles);
    XCTAssertEqualObjects(thrownError, error);
}

- (void)testListPartsForFileId
{
    NSError *error;
    [self addMockResponse:@{ @"nextPartNumber": @(0),
                             @"parts": @[ @{ @"fileId": @"fileId",
                                             @"partNumber": @(0),
                                             @"contentLength": @(0),
                                             @"contentSha1": @"contentSha1",
                                             @"uploadTimestamp": @(0) },
                                          @{ @"fileId": @"fileId",
                                             @"partNumber": @(1),
                                             @"contentLength": @(0),
                                             @"contentSha1": @"contentSha1",
                                             @"uploadTimestamp": @(0) }  ] }];
    NSMutableURLRequest *expectedRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL/b2api/v1/b2_list_parts"]
                                                                    httpMethod:@"POST"
                                                                      httpBody:@{ @"fileId": @"fileId",
                                                                                  @"startPartNumber": @(0),
                                                                                  @"maxPartCount": @(0) }
                                                                       headers:@{ }];
    B2Parts *expectedParts = [[B2Parts alloc] initWithParts:@[ [[B2Part alloc] initWithFileId:@"fileId"
                                                                                   partNumber:@(0)
                                                                                  contentSha1:@"contentSha1"
                                                                              uploadTimestamp:[NSDate dateWithTimeIntervalSince1970:0]],
                                                               [[B2Part alloc] initWithFileId:@"fileId"
                                                                                   partNumber:@(1)
                                                                                  contentSha1:@"contentSha1"
                                                                              uploadTimestamp:[NSDate dateWithTimeIntervalSince1970:0]] ]
                                             nextPartNumber:@(0)];
    B2Parts *parts = [[self fileManager] listPartsForFileId:@"fileId"
                                                    account:[self account]
                                            startPartNumber:@(0)
                                               maxPartCount:@(0)
                                                      error:&error];
    [self verifyURLRequest:expectedRequest];
    XCTAssertEqualObjects(expectedParts, parts);
}

- (void)testListPartsForFileIdFailsWithError
{
    NSError *error, *thrownError = [NSError new];
    [[self client] setError:thrownError];
    B2Parts *parts = [[self fileManager] listPartsForFileId:@"fileID"
                                                    account:[self account]
                                            startPartNumber:@(0)
                                               maxPartCount:@(0)
                                                      error:&error];
    XCTAssertNil(parts);
    XCTAssertEqualObjects(thrownError, error);
}

@end
