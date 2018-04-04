//
//  B2JSONValidatorTests.m
//  B2KitUnitTests
//
//  Created by Andreas Meingast on 12.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"
#import "B2JSONValidator.h"

@interface B2JSONValidatorTests : B2KitTestCase

@end

@implementation B2JSONValidatorTests

- (void)testValidateJSON
{
    NSError *error;
    BOOL result = [[B2JSONValidator sharedInstance] validateJSON:@{ @"a": @"a",
                                                                    @"b": @"b",
                                                                    @"c": @"c" }
                                                          fields:@[@"a", @"b"]
                                                           error:&error];
    XCTAssertTrue(result);
    XCTAssertNil(error);
}

- (void)testValidateJSONWithMissingFields
{
    NSError *error;
    BOOL result = [[B2JSONValidator sharedInstance] validateJSON:@{ @"a": @"a" }
                                                          fields:@[ @"b" ]
                                                           error:&error];
    XCTAssertFalse(result);
    XCTAssertNotNil(error);
}

@end
