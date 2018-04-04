//
//  B2ClientDataResultTests.m
//  B2KitUnitTests
//
//  Created by Andreas Meingast on 12.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"
#import "B2ClientDataResult.h"

@interface B2ClientDataResultTests : B2KitTestCase

@end

@implementation B2ClientDataResultTests

- (void)testInitWithData
{
    NSData *data = [NSData new];
    NSHTTPURLResponse *response = [NSHTTPURLResponse new];
    B2ClientDataResult *result = [[B2ClientDataResult alloc] initWithData:data
                                                                 response:response];
    XCTAssertEqual(data, [result data]);
    XCTAssertEqual(response, [result response]);
}

- (void)testValidate
{
    NSError *error;
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com"]
                                                              statusCode:200
                                                             HTTPVersion:@"1.0"
                                                            headerFields:nil];
    B2ClientDataResult *result = [[B2ClientDataResult alloc] initWithData:[NSData new]
                                                                 response:response];
    BOOL validationResult = [result validate:&error];
    XCTAssertTrue(validationResult);
    XCTAssertNil(error);
}

- (void)testValidateFailure
{
    NSError *error;
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com"]
                                                              statusCode:400
                                                             HTTPVersion:@"1.0"
                                                            headerFields:nil];
    B2ClientDataResult *result = [[B2ClientDataResult alloc] initWithData:(NSData *)[NSJSONSerialization dataWithJSONObject:@{ @"status": @(400),
                                                                                                                               @"code": @"code",
                                                                                                                               @"message": @"message"}
                                                                                                                    options:0
                                                                                                                      error:nil]
                                                                 response:response];
    BOOL validationResult = [result validate:&error];
    XCTAssertFalse(validationResult);
    XCTAssertNotNil(error);
}

@end
