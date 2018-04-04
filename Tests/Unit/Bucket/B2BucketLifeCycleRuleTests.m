//
//  B2BucketLifeCycleRuleTests.m
//  B2KitTests
//
//  Created by Andreas Meingast on 27.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"

@interface B2BucketLifeCycleRuleTests : B2KitTestCase

@end

@implementation B2BucketLifeCycleRuleTests

- (void)testInitWithDaysFromUploadingToHiding
{
    B2BucketLifeCycleRule *rule = [[B2BucketLifeCycleRule alloc] initWithDaysFromUploadingToHiding:@(1)
                                                                          daysFromHidingToDeleting:@(2)
                                                                                    fileNamePrefix:@"prefix"];
    XCTAssertEqual(@(1), [rule daysFromUploadingToHiding]);
    XCTAssertEqual(@(2), [rule daysFromHidingToDeleting]);
    XCTAssertEqual(@"prefix", [rule fileNamePrefix]);
}

@end
