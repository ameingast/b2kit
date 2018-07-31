//
//  NSArrayTests+B2Kit.m
//  B2Kit
//
//  Created by Andreas Meingast on 31.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"
#import "NSArray+B2Kit.h"

@interface NSArrayTests : B2KitTestCase

@end

@implementation NSArrayTests

- (void)testSingleLineDescription
{
    NSArray<NSNumber *> *a1 = @[];
    NSArray<NSNumber *> *a2 = @[ @(1) ];
    NSArray<NSNumber *> *a3 = @[ @(1), @(2) ];
    NSArray<NSArray<NSNumber *> *> *a4 = @[ @[ @(1), @(2) ], @[ @(3), @(4) ] ] ;
    XCTAssertEqualObjects(@"[]", [a1 singleLineDescription]);
    XCTAssertEqualObjects(@"[1]", [a2 singleLineDescription]);
    XCTAssertEqualObjects(@"[1, 2]", [a3 singleLineDescription]);
    XCTAssertEqualObjects(@"[[1, 2], [3, 4]]", [a4 singleLineDescription]);
}

@end
