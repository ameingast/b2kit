//
//  B2PartsTests.m
//  B2KitUnitTests
//
//  Created by Andreas Meingast on 12.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"

@interface B2PartsTests : B2KitTestCase

@end

@implementation B2PartsTests

- (void)testInitWithFileId
{
    B2Part *part = [[B2Part alloc] initWithFileId:@"fileId"
                                       partNumber:@(1)
                                      contentSha1:@"contentSha1"
                                  uploadTimestamp:[NSDate dateWithTimeIntervalSince1970:0]];
    XCTAssertEqualObjects(@"fileId", [part fileId]);
    XCTAssertEqualObjects(@(1), [part partNumber]);
    XCTAssertEqualObjects(@"contentSha1", [part contentSha1]);
    XCTAssertEqualObjects([NSDate dateWithTimeIntervalSince1970:0], [part uploadTimestamp]);
}

- (void)testInitWithParts
{
    B2Parts *parts = [[B2Parts alloc] initWithParts:@[]
                                     nextPartNumber:@(1)];
    XCTAssertEqualObjects(@[], [parts parts]);
    XCTAssertEqualObjects(@(1), [parts nextPartNumber]);
}

@end
