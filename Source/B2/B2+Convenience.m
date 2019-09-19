//
//  B2+Convenience.m
//  B2Kit
//
//  Created by Andreas Meingast on 14.09.19.
//  Copyright © 2019 Andreas Meingast. All rights reserved.
//

#import "B2.h"
#import "B2FileManager.h"

@implementation B2 (Convenience)

- (BOOL)downloadFileWithFileId:(NSString *)fileId
                       account:(B2Account *)account
                   locationURL:(NSURL *)locationURL
                         error:(out NSError *__autoreleasing *)error
{
    return [[[B2FileManager alloc] initWithClient:[self client]] downloadFileWithFileId:fileId
                                                                                account:account
                                                                            locationURL:locationURL
                                                                                  error:error];
}

- (nullable B2File *)uploadLargeFileAtURL:(NSURL *)localFileURL
                                  account:(B2Account *)account
                                 fileName:(NSString *)filename
                                 bucketId:(NSString *)bucketId
                              contentType:(NSString *)contentType
                              contentSha1:(NSString *)contentSha1
                           lastModifiedOn:(NSDate *)lastModifiedOn
                                 fileInfo:(NSDictionary<NSString *, NSString *> *)fileInfo
                            resumeContext:(out B2ResumeContext *)resumeContext
                     resumeContextChanged:(void (^)(B2ResumeContext *))callback
                                    error:(out NSError *__autoreleasing *)error
{
    return [[[B2FileManager alloc] initWithClient:[self client]] uploadLargeFileAtURL:localFileURL
                                                                              account:account
                                                                             fileName:filename
                                                                             bucketId:bucketId
                                                                          contentType:contentType
                                                                          contentSha1:contentSha1
                                                                       lastModifiedOn:lastModifiedOn
                                                                             fileInfo:fileInfo
                                                                        resumeContext:resumeContext
                                                                 resumeContextChanged:callback
                                                                                error:error];
}

@end
