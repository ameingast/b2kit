//
//  B2FileInfoActionTests.m
//  B2KitTests
//
//  Created by Andreas Meingast on 27.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"

@interface B2FileInfoActionTests : B2KitTestCase

@end

@implementation B2FileInfoActionTests

- (void)testB2FileInfoActionFromString
{
    XCTAssertEqual(B2FileInfoActionUploaded, B2FileInfoActionFromString(@"upload"));
    XCTAssertEqual(B2FileInfoActionHidden, B2FileInfoActionFromString(@"hidden"));
    XCTAssertEqual(B2FileInfoActionNone, B2FileInfoActionFromString(@""));
}

- (void)testNSStringFromB2FileInfoAction
{
    XCTAssertEqualObjects(@"upload", NSStringFromB2FileInfoAction(B2FileInfoActionUploaded));
    XCTAssertEqualObjects(@"hidden", NSStringFromB2FileInfoAction(B2FileInfoActionHidden));
    XCTAssertEqualObjects(@"", NSStringFromB2FileInfoAction(B2FileInfoActionNone));
}

@end
