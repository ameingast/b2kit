//
//  NSFileManager+B2Kit.m
//  B2Kit
//
//  Created by Andreas Meingast on 14.09.19.
//  Copyright © 2019 Andreas Meingast. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

#import "B2Error.h"
#import "NSFileManager+B2Kit.h"

static NSUInteger B2KitDigestStreamBufferSize = 1024 * 1024;

@implementation NSFileManager (B2Kit)

- (long long)fileSize:(NSURL *)url
                error:(out NSError *__autoreleasing *)error
{
    NSString *path = [url path];
    if (!path) {
        return -1;
    }
    NSDictionary *fileAttributes = [self attributesOfItemAtPath:path
                                                          error:error];
    NSNumber *fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
    return [fileSizeNumber longLongValue];
}

- (NSURL *)temporaryFileURL
{
    NSString *uuid = [[NSUUID UUID] UUIDString];
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:uuid];
    return [NSURL fileURLWithPath:path];
}

- (nullable NSString *)sha1ForFileAtURL:(NSURL *)url
                                  error:(out NSError *__autoreleasing *)error
{
    NSMutableData *digestData = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH];
    NSMutableData *buffer = [NSMutableData dataWithLength:B2KitDigestStreamBufferSize];
    NSInputStream *inputStream = [NSInputStream inputStreamWithURL:url];
    @try {
        CC_SHA1_CTX  ctx = {};
        CC_SHA1_Init(&ctx);
        [inputStream open];
        for (;;) {
            NSInteger bytesRead = [inputStream read:[buffer mutableBytes]
                                          maxLength:[buffer length]];
            if (bytesRead < 0) {
                if (error) {
                    *error = [inputStream streamError];
                }
                return nil;
            } else if (bytesRead == 0) {
                break;
            } else {
                CC_SHA1_Update(&ctx, [buffer bytes], (CC_LONG)bytesRead);
            }
        }
        CC_SHA1_Final([digestData mutableBytes], &ctx);
        NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH*2];
        for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
            [output appendFormat:@"%02x", ((const uint8_t *)[digestData bytes])[i]];
        }
        return output;
    } @finally {
        [inputStream close];
    }
}

@end
