//
//  B2RangeTests.m
//  B2KitTests
//
//  Created by Andreas Meingast on 27.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"

@interface B2RangeTests : B2KitTestCase

@end

@implementation B2RangeTests

- (void)testInitWithStart
{
    B2Range *range = [[B2Range alloc] initWithStart:@(1)
                                                end:@(2)];
    XCTAssertEqualObjects(@(1), [range start]);
    XCTAssertEqualObjects(@(2), [range end]);
}

@end
