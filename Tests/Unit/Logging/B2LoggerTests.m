//
//  B2LoggerTests.m
//  B2KitUnitTests
//
//  Created by Andreas Meingast on 12.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"

@interface B2LoggerTests : B2KitTestCase

@end

@implementation B2LoggerTests

- (void)testIsLogLevelTrace
{
    B2Logger *logger = [B2Logger sharedInstance];
    [logger setLogLevel:B2LogLevelTrace];
    XCTAssertTrue([logger isLogLevel:B2LogLevelTrace]);
    XCTAssertTrue([logger isLogLevel:B2LogLevelDebug]);
    XCTAssertTrue([logger isLogLevel:B2LogLevelInfo]);
    XCTAssertTrue([logger isLogLevel:B2LogLevelWarn]);
    XCTAssertTrue([logger isLogLevel:B2LogLevelError]);
    XCTAssertTrue([logger isLogLevel:B2LogLevelNone]);
}

- (void)testIsLogLevelDebug
{
    B2Logger *logger = [B2Logger sharedInstance];
    [logger setLogLevel:B2LogLevelDebug];
    XCTAssertFalse([logger isLogLevel:B2LogLevelTrace]);
    XCTAssertTrue([logger isLogLevel:B2LogLevelDebug]);
    XCTAssertTrue([logger isLogLevel:B2LogLevelInfo]);
    XCTAssertTrue([logger isLogLevel:B2LogLevelWarn]);
    XCTAssertTrue([logger isLogLevel:B2LogLevelError]);
    XCTAssertTrue([logger isLogLevel:B2LogLevelNone]);
}

- (void)testIsLogLevelInfo
{
    B2Logger *logger = [B2Logger sharedInstance];
    [logger setLogLevel:B2LogLevelInfo];
    XCTAssertFalse([logger isLogLevel:B2LogLevelTrace]);
    XCTAssertFalse([logger isLogLevel:B2LogLevelDebug]);
    XCTAssertTrue([logger isLogLevel:B2LogLevelInfo]);
    XCTAssertTrue([logger isLogLevel:B2LogLevelWarn]);
    XCTAssertTrue([logger isLogLevel:B2LogLevelError]);
    XCTAssertTrue([logger isLogLevel:B2LogLevelNone]);
}

- (void)testIsLogLevelWarn
{
    B2Logger *logger = [B2Logger sharedInstance];
    [logger setLogLevel:B2LogLevelWarn];
    XCTAssertFalse([logger isLogLevel:B2LogLevelTrace]);
    XCTAssertFalse([logger isLogLevel:B2LogLevelDebug]);
    XCTAssertFalse([logger isLogLevel:B2LogLevelInfo]);
    XCTAssertTrue([logger isLogLevel:B2LogLevelWarn]);
    XCTAssertTrue([logger isLogLevel:B2LogLevelError]);
    XCTAssertTrue([logger isLogLevel:B2LogLevelNone]);
}

- (void)testIsLogLevelError
{
    B2Logger *logger = [B2Logger sharedInstance];
    [logger setLogLevel:B2LogLevelError];
    XCTAssertFalse([logger isLogLevel:B2LogLevelTrace]);
    XCTAssertFalse([logger isLogLevel:B2LogLevelDebug]);
    XCTAssertFalse([logger isLogLevel:B2LogLevelInfo]);
    XCTAssertFalse([logger isLogLevel:B2LogLevelWarn]);
    XCTAssertTrue([logger isLogLevel:B2LogLevelError]);
    XCTAssertTrue([logger isLogLevel:B2LogLevelNone]);
}

- (void)testIsLogLevelNone
{
    B2Logger *logger = [B2Logger sharedInstance];
    [logger setLogLevel:B2LogLevelNone];
    XCTAssertFalse([logger isLogLevel:B2LogLevelTrace]);
    XCTAssertFalse([logger isLogLevel:B2LogLevelDebug]);
    XCTAssertFalse([logger isLogLevel:B2LogLevelInfo]);
    XCTAssertFalse([logger isLogLevel:B2LogLevelWarn]);
    XCTAssertFalse([logger isLogLevel:B2LogLevelError]);
    XCTAssertTrue([logger isLogLevel:B2LogLevelNone]);
}

- (void)testB2LogLevelFromNSString
{
    XCTAssertEqual(B2LogLevelTrace, B2LogLevelFromNSString(@"trace"));
    XCTAssertEqual(B2LogLevelDebug, B2LogLevelFromNSString(@"debug"));
    XCTAssertEqual(B2LogLevelInfo, B2LogLevelFromNSString(@"info"));
    XCTAssertEqual(B2LogLevelWarn, B2LogLevelFromNSString(@"warn"));
    XCTAssertEqual(B2LogLevelError, B2LogLevelFromNSString(@"error"));
    XCTAssertEqual(B2LogLevelNone, B2LogLevelFromNSString(@"none"));
}

- (void)testNSStringFromB2LogLevel
{
    XCTAssertEqualObjects(@"trace", NSStringFromB2LogLevel(B2LogLevelTrace));
    XCTAssertEqualObjects(@"debug", NSStringFromB2LogLevel(B2LogLevelDebug));
    XCTAssertEqualObjects(@"info", NSStringFromB2LogLevel(B2LogLevelInfo));
    XCTAssertEqualObjects(@"warn", NSStringFromB2LogLevel(B2LogLevelWarn));
    XCTAssertEqualObjects(@"error", NSStringFromB2LogLevel(B2LogLevelError));
    XCTAssertEqualObjects(@"none", NSStringFromB2LogLevel(B2LogLevelNone));
}

@end
