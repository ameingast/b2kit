//
//  B2FileTests.m
//  B2KitTests
//
//  Created by Andreas Meingast on 27.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"
#import "B2File+Private.h"

@interface B2FileTests : B2KitTestCase

@end

@implementation B2FileTests

- (void)testInitWithFileId
{
    B2File *file = [[B2File alloc] initWithFileId:@"fileId"
                                         filename:@"fileName"
                                        accountId:@"accountId"
                                         bucketId:@"bucketId"
                                    contentLength:@(1)
                                      contentType:@"contentType"
                                         metadata:@{}
                                           action:B2FileInfoActionUploaded
                                       uploadDate:[NSDate dateWithTimeIntervalSince1970:0]];
    XCTAssertEqualObjects(@"fileId", [file fileId]);
    XCTAssertEqualObjects(@"fileName", [file filename]);
    XCTAssertEqualObjects(@"accountId", [file accountId]);
    XCTAssertEqualObjects(@"bucketId", [file bucketId]);
    XCTAssertEqualObjects(@(1), [file contentLength]);
    XCTAssertEqualObjects(@"contentType", [file contentType]);
    XCTAssertEqual(B2FileInfoActionUploaded, [file action]);
    XCTAssertEqualObjects([NSDate dateWithTimeIntervalSince1970:0], [file uploadDate]);
}

- (void)testFilesFromArray
{
    B2Account *account = [[B2Account alloc] initWithIdentifier:@"accountId"
                                                         token:@"token"
                                           accountCapabilities:B2AccountCapabilityNone
                                                        apiURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL"]
                                                   downloadURL:(NSURL *)[NSURL URLWithString:@"http://example.com/downloadURL"]
                                           recommendedPartSize:@(1)
                                       absoluteMinimumPartSize:@(2)];
    B2File *expectedFile = [[B2File alloc] initWithFileId:@"fileId"
                                                 filename:@"fileName"
                                                accountId:@"accountId"
                                                 bucketId:@"bucketId"
                                            contentLength:@(1)
                                              contentType:@"contentType"
                                                 metadata:@{}
                                                   action:B2FileInfoActionUploaded
                                               uploadDate:[NSDate dateWithTimeIntervalSince1970:0]];
    NSArray<B2File *> *files = [B2File filesFromArray:@[ @{ @"fileId": @"fileId",
                                                            @"fileName": @"fileName",
                                                            @"accountId": @"accountId",
                                                            @"contentLength": @(1),
                                                            @"contentType": @"contentType",
                                                            @"contentSha1": @"contentSha1",
                                                            @"fileInfo": @{},
                                                            @"action": @"upload",
                                                            @"uploadTimestamp": @(0) } ]
                                              account:account
                                             bucketId:@"bucketId"
                                                error:nil];
    XCTAssertEqualObjects(@[ expectedFile ], files);
}

- (void)testInitWithJSONData
{
    B2File *expectedFile = [[B2File alloc] initWithFileId:@"fileId"
                                                 filename:@"fileName"
                                                accountId:@"accountId"
                                                 bucketId:@"bucketId"
                                            contentLength:@(1)
                                              contentType:@"contentType"
                                                 metadata:@{}
                                                   action:B2FileInfoActionUploaded
                                               uploadDate:[NSDate dateWithTimeIntervalSince1970:0]];
    B2File *file = [[B2File alloc] initWithJSONData:(NSData *)[NSJSONSerialization dataWithJSONObject:@{ @"fileId": @"fileId",
                                                                                                         @"accountId": @"accountId",
                                                                                                         @"fileName": @"fileName",
                                                                                                         @"bucketId": @"bucketId",
                                                                                                         @"accountId": @"accountId",
                                                                                                         @"contentLength": @(1),
                                                                                                         @"contentType": @"contentType",
                                                                                                         @"contentSha1": @"contentSha1",
                                                                                                         @"fileInfo": @{},
                                                                                                         @"action": @"upload",
                                                                                                         @"uploadTimestamp": @(0) }
                                                                                              options:0
                                                                                                error:nil]
                                              error:nil];
    XCTAssertEqualObjects(file, expectedFile);
}

@end
