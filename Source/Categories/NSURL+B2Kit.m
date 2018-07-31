//
//  NSURL+B2Kit.m
//  B2Kit
//
//  Created by Andreas Meingast on 31.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import <CommonCrypto/CommonCrypto.h>
#import "NSURL+B2Kit.h"
#import "B2Error.h"

@implementation NSURL (B2Kit)

- (NSString *)SHA1:(out NSError *__autoreleasing *)error
{
    NSMutableData *digest = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH];
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingFromURL:self
                                                                   error:error];
    if (!fileHandle) {
        return nil;
    }
    CC_SHA1_CTX ctx;
    CC_SHA1_Init(&ctx);
    @try {
        while (true) {
            NSData *data = [fileHandle readDataOfLength:1024 * 1024];
            if ([data length] > 0) {
                CC_SHA1_Update(&ctx, [data bytes], (CC_LONG)[data length]);
            } else {
                break;
            }
        }
    } @catch (NSException *exception) {
        [fileHandle closeFile];
        if (error) {
            *error = B2CreateErrorFromException(exception);
        }
        return nil;
    }
    CC_SHA1_Final([digest mutableBytes], &ctx);
    [fileHandle closeFile];
    const unsigned char *digestBytes = (const unsigned char *)[digest bytes];
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (NSUInteger i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digestBytes[i]];
    }
    return result;
}

- (NSDate *)modificationDate:(out NSError *__autoreleasing *)error
{
    NSDate *date;
    BOOL result = [self getResourceValue:&date
                                  forKey:NSURLContentModificationDateKey
                                   error:error];
    return result ? date : nil;
    
}

@end
