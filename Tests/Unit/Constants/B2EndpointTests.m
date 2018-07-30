//
//  B2EndpointTests.m
//  B2KitUnitTests
//
//  Created by Andreas Meingast on 12.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"
#import "B2Endpoint.h"

@interface B2EndpointTests : B2KitTestCase

@end

@implementation B2EndpointTests

- (void)testEndpoints
{
    XCTAssertEqualObjects((NSURL *)[NSURL URLWithString:@"http://example.com/b2api/v1/b2_create_bucket"],
                          B2EndpointCreateBucketURL((NSURL *)[NSURL URLWithString:@"http://example.com"]));
    XCTAssertEqualObjects((NSURL *)[NSURL URLWithString:@"http://example.com/b2api/v1/b2_list_buckets"],
                          B2EndpointListBucketsURL((NSURL *)[NSURL URLWithString:@"http://example.com"]));
    XCTAssertEqualObjects((NSURL *)[NSURL URLWithString:@"http://example.com/b2api/v1/b2_delete_bucket"],
                          B2EndpointDeleteBucketURL((NSURL *)[NSURL URLWithString:@"http://example.com"]));
    XCTAssertEqualObjects((NSURL *)[NSURL URLWithString:@"http://example.com/b2api/v1/b2_update_bucket"],
                          B2EndpointUpdateBucketURL((NSURL *)[NSURL URLWithString:@"http://example.com"]));
    XCTAssertEqualObjects((NSURL *)[NSURL URLWithString:@"http://example.com/b2api/v1/b2_get_upload_url"],
                          B2EndpointGetUploadUrl((NSURL *)[NSURL URLWithString:@"http://example.com"]));
    XCTAssertEqualObjects((NSURL *)[NSURL URLWithString:@"http://example.com/b2api/v1/b2_delete_file_version"],
                          B2EndpointDeleteFileVersion((NSURL *)[NSURL URLWithString:@"http://example.com"]));
    XCTAssertEqualObjects((NSURL *)[NSURL URLWithString:@"http://example.com/b2api/v1/b2_list_file_names"],
                          B2EndpointListFileNames((NSURL *)[NSURL URLWithString:@"http://example.com"]));
    XCTAssertEqualObjects((NSURL *)[NSURL URLWithString:@"http://example.com/b2api/v1/b2_download_file_by_id"],
                          B2EndpointDownloadFileById((NSURL *)[NSURL URLWithString:@"http://example.com"]));
    XCTAssertEqualObjects((NSURL *)[NSURL URLWithString:@"http://example.com/file/bucketName/fileName"],
                          B2EndpointDownloadFileByName((NSURL *)[NSURL URLWithString:@"http://example.com"], @"bucketName", @"fileName"));
    XCTAssertEqualObjects((NSURL *)[NSURL URLWithString:@"http://example.com/b2api/v1/b2_get_file_info"],
                          B2EndpointFileInfo((NSURL *)[NSURL URLWithString:@"http://example.com"]));
    XCTAssertEqualObjects((NSURL *)[NSURL URLWithString:@"http://example.com/b2api/v1/b2_hide_file"],
                          B2EndpointHideFile((NSURL *)[NSURL URLWithString:@"http://example.com"]));
    XCTAssertEqualObjects((NSURL *)[NSURL URLWithString:@"http://example.com/b2api/v1/b2_get_upload_part_url"],
                          B2EndpointGetUploadPartURL((NSURL *)[NSURL URLWithString:@"http://example.com"]));
    XCTAssertEqualObjects((NSURL *)[NSURL URLWithString:@"http://example.com/b2api/v1/b2_start_large_file"],
                          B2EndpointStartLargeFile((NSURL *)[NSURL URLWithString:@"http://example.com"]));
    XCTAssertEqualObjects((NSURL *)[NSURL URLWithString:@"http://example.com/b2api/v1/b2_cancel_large_file"],
                          B2EndpointCancelLargeFile((NSURL *)[NSURL URLWithString:@"http://example.com"]));
    XCTAssertEqualObjects((NSURL *)[NSURL URLWithString:@"http://example.com/b2api/v1/b2_finish_large_file"],
                          B2EndpointFinishLargeFile((NSURL *)[NSURL URLWithString:@"http://example.com"]));
    XCTAssertEqualObjects((NSURL *)[NSURL URLWithString:@"http://example.com/b2api/v1/b2_list_unfinished_large_files"],
                          B2EndpointListUnfinishedLargeFiles((NSURL *)[NSURL URLWithString:@"http://example.com"]));
    XCTAssertEqualObjects((NSURL *)[NSURL URLWithString:@"http://example.com/b2api/v1/b2_list_parts"],
                          B2EndpointListParts((NSURL *)[NSURL URLWithString:@"http://example.com"]));
}

@end
