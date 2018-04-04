//
//  B2UnfinishedLargeFilesTests.m
//  B2KitUnitTests
//
//  Created by Andreas Meingast on 12.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"

@interface B2UnfinishedLargeFilesTests : B2KitTestCase

@end

@implementation B2UnfinishedLargeFilesTests

- (void)testInitWithFileId
{
    B2UnfinishedLargeFile *file = [[B2UnfinishedLargeFile alloc] initWithFileId:@"fileId"
                                                                       filename:@"filename"
                                                                      accountId:@"accountId"
                                                                       bucketId:@"bucketId"
                                                                    contentType:@"contentType"
                                                                       fileInfo:@{}
                                                                uploadTimestamp:[NSDate dateWithTimeIntervalSince1970:0]];
    XCTAssertEqualObjects(@"fileId", [file fileId]);
    XCTAssertEqualObjects(@"filename", [file filename]);
    XCTAssertEqualObjects(@"accountId", [file accountId]);
    XCTAssertEqualObjects(@"bucketId", [file bucketId]);
    XCTAssertEqualObjects(@"contentType", [file contentType]);
    XCTAssertEqualObjects(@{}, [file fileInfo]);
    XCTAssertEqualObjects([NSDate dateWithTimeIntervalSince1970:0], [file uploadTimestamp]);
}

- (void)testInitWithFiles
{
    B2UnfinishedLargeFiles *files = [[B2UnfinishedLargeFiles alloc] initWithFiles:@[]
                                                                       nextFileId:@"nextFileId"];
    XCTAssertEqualObjects(@[], [files files]);
    XCTAssertEqualObjects(@"nextFileId", [files nextFileId]);
}

@end
