//
//  B2+Files.m
//  B2Kit
//
//  Created by Andreas Meingast on 05.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2.h"
#import "B2FileManager.h"

@implementation B2 (Files)

- (B2File *)fileInfo:(NSString *)fileId
             account:(B2Account *)account
               error:(out NSError *__autoreleasing *)error
{
    return [[[B2FileManager alloc] initWithClient:[self client]] fileInfoForFileId:fileId
                                                                           account:account
                                                                             error:error];
}

- (B2File *)uploadFileAtURL:(NSURL *)localFileURL
                    account:(B2Account *)account
                   fileName:(NSString *)filename
               sha1Checksum:(NSString *)sha1Checksum
                   bucketId:(NSString *)bucketId
                contentType:(NSString *)contentType
             lastModifiedOn:(NSUInteger)lastModifiedOn
                   fileInfo:(NSDictionary<NSString *, NSString *> *)fileInfo
                      error:(out NSError *__autoreleasing *)error
{
    return [[[B2FileManager alloc] initWithClient:[self client]] uploadFileAtURL:localFileURL
                                                                         account:account
                                                                        fileName:filename
                                                                    sha1Checksum:sha1Checksum
                                                                      intoBucket:bucketId
                                                                     contentType:contentType
                                                                  lastModifiedOn:lastModifiedOn
                                                                        fileInfo:fileInfo
                                                                           error:error];
}

- (BOOL)downloadFileWithFileId:(NSString *)fileId
                       account:(B2Account *)account
                         range:(B2Range *)range
                   locationURL:(NSURL *)locationURL
                         error:(out NSError *__autoreleasing *)error
{
    return [[[B2FileManager alloc] initWithClient:[self client]] downloadFileWithFileId:fileId
                                                                                account:account
                                                                                  range:range
                                                                            locationURL:locationURL
                                                                                  error:error];
}

- (BOOL)downloadFileWithFileName:(NSString *)fileName
                      bucketName:(NSString *)bucketName
                         account:(B2Account *)account
                           range:(B2Range *)range
                     locationURL:(NSURL *)locationURL
                           error:(out NSError *__autoreleasing *)error
{
    return [[[B2FileManager alloc] initWithClient:[self client]] downloadFileWithFileName:fileName
                                                                               bucketName:bucketName
                                                                                  account:account
                                                                                    range:range
                                                                              locationURL:locationURL
                                                                                    error:error];
}

- (BOOL)hideFileWithFileName:(NSString *)fileName
                     account:(B2Account *)account
                      bucket:(B2Bucket *)bucket
                       error:(out NSError *__autoreleasing *)error
{
    return [[[B2FileManager alloc] initWithClient:[self client]] hideFileWithFileName:fileName
                                                                              account:account
                                                                               bucket:bucket
                                                                                error:error];
}

- (BOOL)deleteFileWithFileId:(NSString *)fileId
                    fileName:(NSString *)filename
                     account:(B2Account *)account
                       error:(out NSError *__autoreleasing *)error
{
    return [[[B2FileManager alloc] initWithClient:[self client]] deleteFileWithFileId:fileId
                                                                             filename:filename
                                                                              account:account
                                                                                error:error];
}

- (NSArray<B2File *> *)listFilesWithBucketId:(NSString *)bucketId
                                     account:(B2Account *)account
                               startFileName:(NSString *)startFileName
                                maxFileCount:(NSNumber *)maxFileCount
                                      prefix:(NSString *)prefix
                                       error:(out NSError *__autoreleasing *)error
{
    return [[[B2FileManager alloc] initWithClient:[self client]] listFilesWithBucketId:bucketId
                                                                               account:account
                                                                         startFileName:startFileName
                                                                          maxFileCount:maxFileCount
                                                                                prefix:prefix
                                                                                 error:error];
}

@end
