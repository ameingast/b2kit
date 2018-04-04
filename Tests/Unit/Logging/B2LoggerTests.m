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

@end
