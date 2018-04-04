//
//  B2+LargeFiles.m
//  B2Kit
//
//  Created by Andreas Meingast on 09.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2.h"
#import "B2FileManager.h"

@implementation B2 (LargeFiles)

- (B2UploadURL *)uploadPartURLForFileId:(NSString *)fileId
                                account:(B2Account *)account
                                  error:(out NSError *__autoreleasing *)error
{
    return [[[B2FileManager alloc] initWithClient:[self client]] uploadPartURLForFileId:fileId
                                                                                account:account
                                                                                  error:error];
}

- (NSString *)startUploadForFilename:(NSString *)filename
                             account:(B2Account *)account
                            bucketId:(NSString *)bucketId
                         contentType:(NSString *)contentType
                            fileInfo:(NSDictionary<NSString *, NSString *> *)fileInfo
                               error:(out NSError *__autoreleasing *)error
{
    return [[[B2FileManager alloc] initWithClient:[self client]] startUploadForFileName:filename
                                                                                account:account
                                                                               bucketId:bucketId
                                                                            contentType:contentType
                                                                               fileInfo:fileInfo
                                                                                  error:error];
}

- (BOOL)cancelUploadForFileId:(NSString *)fileId
                      account:(B2Account *)account
                        error:(out NSError *__autoreleasing *)error
{
    return [[[B2FileManager alloc] initWithClient:[self client]] cancelUploadForFileId:fileId
                                                                               account:account
                                                                                 error:error];
}

- (BOOL)finishUploadForFileId:(NSString *)fileId
                      account:(B2Account *)account
         contentSha1Checksums:(NSArray<NSString *> *)contentSha1Checksums
                        error:(out NSError *__autoreleasing *)error
{
    return [[[B2FileManager alloc] initWithClient:[self client]] finishUploadForFileId:fileId
                                                                               account:account
                                                                  contentSha1Checksums:contentSha1Checksums
                                                                                 error:error];
}

- (BOOL)uploadPartForFileId:(NSString *)fileId
                    account:(B2Account *)account
                       data:(NSURL *)dataLocation
                     number:(NSNumber *)partNumber
              contentLength:(NSNumber *)contentLength
        contentSha1Checksum:(NSString *)contentSha1Checksum
                      error:(out NSError *__autoreleasing *)error
{
    return [[[B2FileManager alloc] initWithClient:[self client]] uploadPartForFileId:fileId
                                                                             account:account
                                                                        dataLocation:dataLocation
                                                                          partNumber:partNumber
                                                                       contentLength:contentLength
                                                                 contentSha1Checksum:contentSha1Checksum
                                                                               error:error];
}

- (B2UnfinishedLargeFiles *)listUnfinishedFilesForBucketId:(NSString *)bucketId
                                                   account:(B2Account *)account
                                               startFileId:(NSString *)startFileId
                                              maxFileCount:(NSNumber *)maxFileCount
                                                     error:(out NSError *__autoreleasing *)error
{
    return [[[B2FileManager alloc] initWithClient:[self client]] listUnfinishedFilesForBucketId:bucketId
                                                                                        account:account
                                                                                    startFileId:startFileId
                                                                                   maxFileCount:maxFileCount
                                                                                          error:error];
}

- (id)listPartsForFileId:(NSString *)fileId
                 account:(B2Account *)account
         startPartNumber:(NSNumber *)startPartNumber
            maxPartCount:(NSNumber *)maxPartCount
                   error:(out NSError *__autoreleasing *)error
{
    return [[[B2FileManager alloc] initWithClient:[self client]] listPartsForFileId:fileId
                                                                            account:account
                                                                    startPartNumber:startPartNumber
                                                                       maxPartCount:maxPartCount
                                                                              error:error];
}

@end
