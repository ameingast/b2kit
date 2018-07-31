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
    NSData *payload = [NSJSONSerialization dataWithJSONObject:@{ @"status": @(400),
                                                                 @"code": @"code",
                                                                 @"message": @"message" }
                                                      options:0
                                                        error:nil];
    B2ClientError *clientError = [[B2ClientError alloc] initWithJSONData:payload
                                                                   error:nil];
    NSError *error = [clientError createError];
    XCTAssertEqualObjects(@"com.operationalsemantics.b2kit", [error domain]);
    XCTAssertEqual(400, [error code]);
    XCTAssertEqualObjects(@"message", [error localizedDescription]);
    XCTAssertEqualObjects(@{ NSLocalizedDescriptionKey : @"message"} , [error userInfo]);
}

- (void)testB2CreateError
{
    NSError *error = B2CreateError(0, @{});
    XCTAssertEqualObjects(@"com.operationalsemantics.b2kit", [error domain]);
    XCTAssertEqual(0, [error code]);
    XCTAssertEqualObjects(@{}, [error userInfo]);
}

- (void)testB2CreateErrorFromException
{
    NSException *exception = [NSException exceptionWithName:@"name"
                                                     reason:@"reason"
                                                   userInfo:@{ @(1): @(2) }];
    NSError *error = B2CreateErrorFromException(exception);
    XCTAssertEqualObjects(B2KitDomain, [error domain]);
    XCTAssertEqual(1, [error code]);
    XCTAssertEqualObjects(@{ @(1): @(2) }, [error userInfo]);
}

@end
