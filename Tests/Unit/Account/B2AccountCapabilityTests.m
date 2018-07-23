//
//  B2AccountCapabilityTests.m
//  B2KitTests
//
//  Created by Andreas Meingast on 27.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"

@interface B2AccountCapabilityTests : B2KitTestCase

@end

@implementation B2AccountCapabilityTests

- (void)testB2AccountCapabilityFromNSArray
{
    B2AccountCapability capability = B2AccountCapabilityFromNSArray(@[ @"listKeys", @"writeKeys", @"deleteKeys",
                                                                       @"listBuckets", @"writeBuckets", @"deleteBuckets",
                                                                       @"listFiles", @"readFiles", @"shareFiles",
                                                                       @"writeFiles", @"deleteFiles"]);
    XCTAssertFalse(capability & B2AccountCapabilityNone);
    for (NSUInteger i = 0; i <= 10; i++) {
        B2AccountCapability capabilityToCheck = (NSInteger)(1 << i);
        XCTAssertTrue(capability & capabilityToCheck);
    }
    XCTAssertEqual(B2AccountCapabilityNone, B2AccountCapabilityFromNSArray(nil));
}

- (void)testNSStringFromB2AccountCapability
{
    NSDictionary<NSString *, NSNumber *> *capabilityMap = @{ @"": @(B2AccountCapabilityNone),
                                                             @"listKeys": @(B2AccountCapabilityListKeys),
                                                             @"writeKeys": @(B2AccountCapabilityWriteKeys),
                                                             @"deleteKeys": @(B2AccountCapabilityDeleteKeys),
                                                             @"listBuckets": @(B2AccountCapabilityListBuckets),
                                                             @"writeBuckets": @(B2AccountCapabilityWriteBuckets),
                                                             @"deleteBuckets": @(B2AccountCapabilityDeleteBuckets),
                                                             @"listFiles": @(B2AccountCapabilityListFiles),
                                                             @"readFiles": @(B2AccountCapabilityReadFiles),
                                                             @"shareFiles": @(B2AccountCapabilityShareFiles),
                                                             @"writeFiles": @(B2AccountCapabilityWriteFiles),
                                                             @"deleteFiles": @(B2AccountCapabilityDeleteFiles) };
    for (NSString *capabilityName in capabilityMap) {
        B2AccountCapability capabilityToCheck = [capabilityMap[capabilityName] integerValue];
        XCTAssertEqualObjects(capabilityName, NSStringFromB2AccountCapability(capabilityToCheck));
    }
}

@end
