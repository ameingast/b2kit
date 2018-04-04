//
//  B2AccountManagerTests.m
//  B2KitTests
//
//  Created by Andreas Meingast on 27.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"
#import "B2AccountManager.h"

@interface B2AccountManagerTests : B2KitTestCase

@property (readwrite, nonatomic, nullable) B2AccountManager *accountManager;

@end

@implementation B2AccountManagerTests

@synthesize accountManager = _accountManager;

- (void)setUp
{
    [super setUp];
    [self setAccountManager:[[B2AccountManager alloc] initWithClient:[self client]]];
}

- (void)testAuthorizeAccountWithId
{
    NSError *error;
    [self addMockResponse:@{ @"accountId": @"identifier",
                             @"authorizationToken": @"token",
                             @"apiUrl": @"http://example.com/apiURL",
                             @"downloadUrl": @"http://example.com/downloadURL",
                             @"recommendedPartSize": @(1),
                             @"minimumPartSize": @(2),
                             @"absoluteMinimumPartSize": @(3) }];
    NSMutableURLRequest *expectedRequest = [NSMutableURLRequest requestWithURL:(NSURL *)[NSURL URLWithString:@"https://api.backblazeb2.com/b2api/v1/b2_authorize_account"]
                                                                    httpMethod:@"GET"
                                                                      httpBody:nil
                                                                       headers:@{ @"Authorization":  @"Basic dGVzdC1pZDp0ZXN0LWtleQ==" }];
    B2Account *expectedAccount = [[B2Account alloc] initWithIdentifier:@"identifier"
                                                                 token:@"token"
                                                   accountCapabilities:B2AccountCapabilityNone
                                                                apiURL:(NSURL *)[NSURL URLWithString:@"http://example.com/apiURL"]
                                                           downloadURL:(NSURL *)[NSURL URLWithString:@"http://example.com/downloadURL"]
                                                   recommendedPartSize:@(1)
                                               absoluteMinimumPartSize:@(3)];
    B2Account *account = [[self accountManager] authorizeAccountWithAccountId:@"test-id"
                                                               applicationKey:@"test-key"
                                                                        error:&error];
    [self verifyURLRequest:expectedRequest];
    XCTAssertEqualObjects(expectedAccount, account);
}

- (void)testAuthorizeAccountWithIdFailsWithError
{
    NSError *error, *thrownError = [NSError new];
    [[self client] setError:thrownError];
    B2Account *account = [[self accountManager] authorizeAccountWithAccountId:@"test-id"
                                                               applicationKey:@"test-key"
                                                                        error:&error];
    XCTAssertNil(account);
    XCTAssertEqualObjects(thrownError, error);
}

@end
