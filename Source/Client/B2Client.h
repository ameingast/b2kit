//
//  B2Client.h
//  B2Kit
//
//  Created by Andreas Meingast on 04.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import <Foundation/Foundation.h>

@class B2Account;

NS_ASSUME_NONNULL_BEGIN

@protocol B2Client <NSObject>

- (nullable NSData *)performDownloadRequest:(NSMutableURLRequest *)request
                                    account:(nullable B2Account *)account
                                      error:(out NSError **)error;
- (BOOL)performDownloadRequest:(NSMutableURLRequest *)request
                       account:(nullable B2Account *)account
                       fileURL:(NSURL *)fileURL
                         error:(out NSError **)error;
- (nullable NSData *)performUploadRequest:(NSMutableURLRequest *)request
                                  account:(B2Account *)account
                                  fileURL:(NSURL *)fileURL
                                    error:(out NSError **)error;

@end

NS_ASSUME_NONNULL_END
