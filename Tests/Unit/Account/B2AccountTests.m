//
//  B2AccountTests.m
//  B2KitTests
//
//  Created by Andreas Meingast on 27.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"
#import "B2Account+Private.h"

@interface B2AccountTests : B2KitTestCase

@end

@implementation B2AccountTests

- (void)testInitWithIdentifier
{
    B2Account *account = [[B2Account alloc] initWithIdentifier:@"identifier"
                                                         token:@"token"
                                           accountCapabilities:B2AccountCapabilityListKeys
                                                        apiURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL"]
                                                   downloadURL:(NSURL *)[NSURL URLWithString:@"http://example.com/downloadURL"]
                                           recommendedPartSize:@(1)
                                       absoluteMinimumPartSize:@(2)];
    XCTAssertEqualObjects(@"identifier", [account accountId]);
    XCTAssertEqualObjects(@"token", [account token]);
    XCTAssertEqual(B2AccountCapabilityListKeys, [account accountCapabilities]);
    XCTAssertEqualObjects([NSURL URLWithString:@"http://example.com/apiURL"], [account apiURL]);
    XCTAssertEqualObjects([NSURL URLWithString:@"http://example.com/downloadURL"], [account downloadURL]);
    XCTAssertEqualObjects(@(1), [account recommendedPartSize]);
    XCTAssertEqualObjects(@(2), [account absoluteMinimumPartSize]);
}

- (void)testInitWithDictionary
{
    NSError *error;
    B2Account *account = [[B2Account alloc] initWithDictionary:@{ @"accountId": @"identifier",
                                                                  @"authorizationToken": @"token",
                                                                  @"capabilities": @[ @"listKeys" ],
                                                                  @"apiUrl": @"http://example.com/apiURL",
                                                                  @"downloadUrl": @"http://example.com/downloadURL",
                                                                  @"recommendedPartSize": @(1),
                                                                  @"minimumPartSize": @(2),
                                                                  @"absoluteMinimumPartSize": @(3) }
                                                         error:&error];
    XCTAssertEqualObjects(@"identifier", [account accountId]);
    XCTAssertEqualObjects(@"token", [account token]);
    XCTAssertEqual(B2AccountCapabilityListKeys, [account accountCapabilities]);
    XCTAssertEqualObjects([NSURL URLWithString:@"http://example.com/apiURL"], [account apiURL]);
    XCTAssertEqualObjects([NSURL URLWithString:@"http://example.com/downloadURL"], [account downloadURL]);
    XCTAssertEqualObjects(@(1), [account recommendedPartSize]);
    XCTAssertEqualObjects(@(3), [account absoluteMinimumPartSize]);
}

- (void)testInitWithDictionaryFailsWithMissingKeys
{
    NSError *error;
    B2Account *account = [[B2Account alloc] initWithDictionary:@{}
                                                         error:&error];
    XCTAssertNil(account);
}

@end
