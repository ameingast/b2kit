//
//  NSDictionaryTests+B2Kit.m
//  B2Kit
//
//  Created by Andreas Meingast on 31.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"
#import "NSDictionary+B2Kit.h"

@interface NSDictionaryTests : B2KitTestCase

@end

@implementation NSDictionaryTests

- (void)testSingleLineDescription
{
    NSDictionary<NSNumber *, NSNumber *> *d1 = @{};
    NSDictionary<NSNumber *, NSNumber *> *d2 = @{@(1): @(2)};
    NSDictionary<NSNumber *, NSNumber *> *d3 = @{@(1): @(2), @(3): @(4)};
    NSDictionary<NSDictionary<NSNumber *, NSNumber *> *, NSDictionary<NSNumber *, NSNumber *> *> *d4 = @{ @{ @(1): @(2) }: @ { @(3): @(4) } };
    XCTAssertEqualObjects(@"[]", [d1 singleLineDescription]);
    XCTAssertEqualObjects(@"[{1=2}]", [d2 singleLineDescription]);
    XCTAssertEqualObjects(@"[{3=4}, {1=2}]", [d3 singleLineDescription]);
    XCTAssertEqualObjects(@"[{[{1=2}]=[{3=4}]}]", [d4 singleLineDescription]);
}

@end
