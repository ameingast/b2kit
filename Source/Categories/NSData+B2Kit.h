//
//  NSData+B2Kit.h
//  B2Kit
//
//  Created by Andreas Meingast on 14.09.19.
//  Copyright © 2019 Andreas Meingast. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface NSData (B2Kit)

+ (nullable NSData *)dataWithContentsOfURL:(NSURL *)url
                                  atOffset:(unsigned long long)offset
                                  withSize:(NSUInteger)size
                                     error:(out NSError **)error;

- (NSString *)sha1;

@end

NS_ASSUME_NONNULL_END
