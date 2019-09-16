//
//  NSFileManager+B2Kit.h
//  B2Kit
//
//  Created by Andreas Meingast on 14.09.19.
//  Copyright © 2019 Andreas Meingast. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (B2Kit)

- (long long)fileSize:(NSURL *)url
                error:(out NSError **)error;

- (NSURL *)temporaryFileURL;

- (nullable NSString *)sha1ForFileAtURL:(NSURL *)url
                                  error:(out NSError **)error;

@end

NS_ASSUME_NONNULL_END
