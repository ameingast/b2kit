//
//  NSData+B2Kit.m
//  B2Kit
//
//  Created by Andreas Meingast on 14.09.19.
//  Copyright © 2019 Andreas Meingast. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

#import "B2Error.h"
#import "NSData+B2Kit.h"
#import "NSFileManager+B2Kit.h"

@implementation NSData (B2Kit)

+ (NSData *)dataWithContentsOfURL:(NSURL *)url
                         atOffset:(unsigned long long)offset
                         withSize:(NSUInteger)size
                            error:(out NSError *__autoreleasing *)error
{
    NSString *path = [url path];
    if (!path) {
        return nil;
    }
    @try {
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:path];
        [fileHandle seekToFileOffset:offset];
        NSData *data = [fileHandle readDataOfLength:size];
        return data;
    } @catch (NSException *exception) {
        if (error) {
            *error = B2CreateErrorFromException(exception);
        }
        return nil;
    }

}

- (NSString *)sha1
{
    uint8_t digest[CC_SHA1_DIGEST_LENGTH] = { 0 };
    CC_SHA1([self bytes], (CC_LONG)[self length], digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH*2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

@end
