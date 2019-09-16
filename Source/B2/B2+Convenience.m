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

- (nullable B2File *)uploadLargeFileAtURL:(NSURL *)localFileURL
                                  account:(B2Account *)account
                                 fileName:(NSString *)filename
                                 bucketId:(NSString *)bucketId
                              contentType:(NSString *)contentType
                           lastModifiedOn:(NSDate *)lastModifiedOn
                                 fileInfo:(nullable NSDictionary<NSString *, NSString *> *)fileInfo
                                    error:(out NSError *__autoreleasing *)error
{
    return [[[B2FileManager alloc] initWithClient:[self client]] uploadLargeFileAtURL:localFileURL
                                                                              account:account
                                                                             fileName:filename
                                                                             bucketId:bucketId
                                                                          contentType:contentType
                                                                       lastModifiedOn:lastModifiedOn
                                                                             fileInfo:fileInfo
                                                                                error:error];
}

@end
