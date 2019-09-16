//
//  NSFileManagerTests+B2Kit.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.09.19.
//  Copyright © 2019 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"
#import "NSFileManager+B2Kit.h"

@interface NSFileManagerTests: B2KitTestCase

@end

@implementation NSFileManagerTests

- (void)testFileSize
{
    NSError *error;
    NSURL *fileURL = (NSURL *)[[NSBundle bundleForClass:[self class]] URLForResource:@"Blib"
                                                                       withExtension:@"bin"];
    long long fileSize = [[NSFileManager defaultManager] fileSize:fileURL
                                                            error:&error];
    XCTAssertEqual(6291456LL, fileSize);
}

- (void)testTemporaryFileURL
{
    NSURL *url = [[NSFileManager defaultManager] temporaryFileURL];
    XCTAssertNotNil([url path]);
}

- (void)testSha1ForFileAtURL
{
    NSError *error;
    NSURL *fileURL = (NSURL *)[[NSBundle bundleForClass:[self class]] URLForResource:@"Blib"
                                                                       withExtension:@"bin"];
    NSString *sha1 = [[NSFileManager defaultManager] sha1ForFileAtURL:fileURL
                                                                error:&error];
    XCTAssertEqualObjects(@"10857559cd204a3a9ef6de53fac6ed84f3164cfd", sha1);
}

@end
