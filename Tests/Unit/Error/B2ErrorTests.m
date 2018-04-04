//
//  B2ErrorTests.m
//  B2KitTests
//
//  Created by Andreas Meingast on 27.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"
#import "B2Error.h"

@interface B2ErrorTests : B2KitTestCase

@end

@implementation B2ErrorTests

- (void)testInitWithJSONData
{
    NSError *error;
    NSData *payload = [NSJSONSerialization dataWithJSONObject:@{ @"status": @(400),
                                                                 @"code": @"code",
                                                                 @"message": @"message" }
                                                      options:0
                                                        error:nil];
    B2ClientError *clientError = [[B2ClientError alloc] initWithJSONData:payload
                                                                   error:&error];
    XCTAssertEqualObjects(@(400), [clientError status]);
    XCTAssertEqualObjects(@"code", [clientError code]);
    XCTAssertEqualObjects(@"message", [clientError message]);
}

- (void)testInitWithJSONDataFailsWithInvalidJSON
{
    NSError *error;
    NSData *payload = [NSJSONSerialization dataWithJSONObject:@{}
                                                      options:0
                                                        error:nil];
    B2ClientError *clientError = [[B2ClientError alloc] initWithJSONData:payload
                                                                   error:&error];
    XCTAssertNil(clientError);
}

- (void)testCreateError
{
    NSError *error = B2CreateError(0, @{});
    XCTAssertEqualObjects(@"com.operationalsemantics.b2kit", [error domain]);
    XCTAssertEqual(0, [error code]);
    XCTAssertEqualObjects(@{}, [error userInfo]);
}

@end
