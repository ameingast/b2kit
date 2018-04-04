//
//  B2BucketTypeTests.m
//  B2KitTests
//
//  Created by Andreas Meingast on 27.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"

@interface B2BucketTypeTests : B2KitTestCase

@end

@implementation B2BucketTypeTests

- (void)testNSStringFromB2BucketType
{
    XCTAssertEqualObjects(@"allPrivate", NSStringFromB2BucketType(B2BucketTypeAllPrivate));
    XCTAssertEqualObjects(@"allPublic", NSStringFromB2BucketType(B2BucketTypeAllPublic));
    XCTAssertEqualObjects(@"snapshot", NSStringFromB2BucketType(B2BucketTypeSnapshot));
    XCTAssertEqualObjects(@"all", NSStringFromB2BucketType(B2BucketTypeAll));
    XCTAssertEqualObjects(@"", NSStringFromB2BucketType(B2BucketTypeNone));
}

- (void)testNSArrayFromB2BucketType
{
    XCTAssertEqualObjects(@[], NSArrayFromB2BucketType(B2BucketTypeNone));
    XCTAssertEqualObjects(@[@"allPublic"], NSArrayFromB2BucketType(B2BucketTypeAllPublic));
    XCTAssertEqualObjects(@[@"allPrivate"], NSArrayFromB2BucketType(B2BucketTypeAllPrivate));
    XCTAssertEqualObjects(@[@"snapshot"], NSArrayFromB2BucketType(B2BucketTypeSnapshot));
    XCTAssertEqualObjects(@[@"all"], NSArrayFromB2BucketType(B2BucketTypeAll));
    NSArray<NSString *> *expected = @[@"allPublic", @"allPrivate", @"snapshot", @"all"];
    XCTAssertEqualObjects(expected, NSArrayFromB2BucketType(B2BucketTypeAllPublic | B2BucketTypeAllPrivate | B2BucketTypeSnapshot | B2BucketTypeAll));
}

- (void)testB2BucketTypeFromNSString
{
    XCTAssertEqual(B2BucketTypeAllPrivate, B2BucketTypeFromNSString(@"allPrivate"));
    XCTAssertEqual(B2BucketTypeAllPublic, B2BucketTypeFromNSString(@"allPublic"));
    XCTAssertEqual(B2BucketTypeSnapshot, B2BucketTypeFromNSString(@"snapshot"));
    XCTAssertEqual(B2BucketTypeAll, B2BucketTypeFromNSString(@"all"));
    XCTAssertEqual(B2BucketTypeNone, B2BucketTypeFromNSString(@""));
}

@end
