//
//  NSURLTests+B2Kit.m
//  B2Kit
//
//  Created by Andreas Meingast on 31.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"
#import "NSURL+B2Kit.h"

@interface NSURLTests : B2KitTestCase

@end

@implementation NSURLTests

- (void)testSHA1
{
    NSError *error;
    NSData *data = [@"123456789" dataUsingEncoding:NSUTF8StringEncoding];
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:[[NSUUID UUID] UUIDString]];
    (void)[data writeToFile:path
                 atomically:NO];
    NSString *result = [[NSURL fileURLWithPath:path] SHA1:&error];
    XCTAssertEqualObjects(@"f7c3bc1d808e04732adf679965ccc34ca7ae3441", result);
}

- (void)testModificationDate
{
    NSError *error;
    NSDate *date = [[NSURL fileURLWithPath:NSTemporaryDirectory()] modificationDate:&error];
    XCTAssertNotNil(date);
}

@end
