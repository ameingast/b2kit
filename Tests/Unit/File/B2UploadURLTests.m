//
//  B2UploadURLTests.m
//  B2KitTests
//
//  Created by Andreas Meingast on 27.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"

@interface B2UploadURLTests : B2KitTestCase

@end

@implementation B2UploadURLTests

- (void)testInitWithURL
{
    B2UploadURL *URL = [[B2UploadURL alloc] initWithURL:(NSURL *)[NSURL URLWithString:@"http://example.com"]
                                     authorizationToken:@"token"];
    XCTAssertEqualObjects([NSURL URLWithString:@"http://example.com"], [URL url]);
    XCTAssertEqualObjects(@"token", [URL authorizationToken]);
}

@end
