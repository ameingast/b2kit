//
//  NSDataTests+B2Kit.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.09.19.
//  Copyright © 2019 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"
#import "NSData+B2Kit.h"

@interface NSDataTests : B2KitTestCase

@end

@implementation NSDataTests

- (void)testDataWithContentsOfURL
{
    NSError *error;
    NSURL *fileURL = (NSURL *)[[NSBundle bundleForClass:[self class]] URLForResource:@"Blib"
                                                                       withExtension:@"bin"];
    NSData *data = [NSData dataWithContentsOfURL:fileURL
                                        atOffset:1024
                                        withSize:1024
                                           error:&error];
    XCTAssertEqual(1024, [data length]);
}

- (void)testSha1
{
    NSString *sha1String = [[@"123456789" dataUsingEncoding:NSUTF8StringEncoding] sha1];
    XCTAssertEqualObjects(@"f7c3bc1d808e04732adf679965ccc34ca7ae3441", sha1String);
}

@end
