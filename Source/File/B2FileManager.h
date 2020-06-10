//
//  B2FileManager.h
//  B2Kit
//
//  Created by Andreas Meingast on 08.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "B2Lifecycle.h"

NS_ASSUME_NONNULL_BEGIN

extern long long B2UploadChunkSize;
extern long long B2DownloadChunkSize;
extern NSInteger B2KitUploadConcurrency;
extern NSInteger B2KitDownloadConcurrency;
extern NSInteger B2KitUploadRetries;
extern NSInteger B2KitDownloadRetries;

@class B2File;
@class B2FileNames;
@class B2FileVersions;
@class B2Account;
@class B2Bucket;
@class B2UploadURL;
@class B2Range;
@class B2UnfinishedLargeFiles;
@class B2Parts;
@class B2ResumeContext;
@protocol B2Client;

@interface B2FileManager : NSObject<B2Stop>

@property (readonly, nullable, nonatomic) id<B2Client> client;
@property (readonly, nonnull, nonatomic) NSMutableArray<NSURL *> *staleChunks;

- (B2FileManager *)initWithClient:(id<B2Client>)client;

// MARK: Meta

- (nullable B2File *)fileInfoForFileId:(NSString *)fileId
                               account:(B2Account *)account
                                 error:(out NSError **)error;
- (BOOL)hideFileWithFileName:(NSString *)fileName
                     account:(B2Account *)account
                      bucket:(B2Bucket *)bucket
                       error:(out NSError **)error;
- (nullable B2FileNames *)listFilesWithBucketId:(NSString *)bucketId
                                        account:(B2Account *)account
                                  startFileName:(nullable NSString *)startFileName
                                   maxFileCount:(nullable NSNumber *)maxFileCount
                                         prefix:(nullable NSString *)prefix
                                          error:(out NSError **)error;
- (nullable B2FileVersions *)listFileVersionsWithBucketId:(NSString *)bucketId
                                                  account:(B2Account *)account
                                              startFileId:(nullable NSString *)startFileId
                                            startFileName:(nullable NSString *)startFileName
                                             maxFileCount:(nullable NSNumber *)maxFileCount
                                                   prefix:(nullable NSString *)prefix
                                                    error:(out NSError **)error;

// MARK: Delete

- (BOOL)deleteFileWithFileId:(NSString *)fileId
                    filename:(NSString *)filename
                     account:(B2Account *)account
                       error:(out NSError **)error;

// MARK: Upload

- (nullable B2UploadURL *)uploadURLForBucketWithBucketId:(NSString *)bucketId
                                                 account:(B2Account *)account
                                                   error:(out NSError **)error;
- (nullable B2File *)uploadFileAtURL:(NSURL *)localFileURL
                             account:(B2Account *)account
                            fileName:(NSString *)filename
                        sha1Checksum:(NSString *)sha1Checksum
                          intoBucket:(NSString *)bucketId
                         contentType:(NSString *)contentType
                      lastModifiedOn:(NSDate *)lastModifiedOn
                            fileInfo:(nullable NSDictionary<NSString *, NSString *> *)fileInfo
                               error:(out NSError **)error;

// MARK: Download

- (BOOL)downloadFileWithFileId:(NSString *)fileId
                       account:(B2Account *)account
                         range:(nullable B2Range *)range
                   locationURL:(NSURL *)locationURL
                         error:(out NSError **)error;
- (BOOL)downloadFileWithFileName:(NSString *)fileName
                      bucketName:(NSString *)bucketName
                         account:(B2Account *)account
                           range:(nullable B2Range *)range
                     locationURL:(NSURL *)locationURL
                           error:(out NSError **)error;

// MARK: Large Files

- (nullable B2UploadURL *)uploadPartURLForFileId:(NSString *)fileId
                                         account:(B2Account *)account
                                           error:(out NSError **)error;
- (nullable NSString *)startUploadForFileName:(NSString *)filename
                                      account:(B2Account *)account
                                     bucketId:(NSString *)bucketId
                                  contentType:(NSString *)contentType
                                  contentSha1:(nullable NSString *)contentSha1
                                     fileInfo:(nullable NSDictionary<NSString *, NSString *> *)fileInfo
                                        error:(out NSError **)error;
- (BOOL)cancelUploadForFileId:(NSString *)fileId
                      account:(B2Account *)account
                        error:(out NSError **)error;
- (BOOL)finishUploadForFileId:(NSString *)fileId
                      account:(B2Account *)account
         contentSha1Checksums:(NSArray<NSString *> *)contentSha1Checksums
                        error:(out NSError **)error;
- (BOOL)uploadPartForFileId:(NSString *)fileId
                    account:(B2Account *)account
               dataLocation:(NSURL *)dataLocation
                 partNumber:(NSNumber *)partNumber
              contentLength:(NSNumber *)contentLength
        contentSha1Checksum:(NSString *)contentSha1Checksum
                      error:(out NSError **)error;
- (nullable B2UnfinishedLargeFiles *)listUnfinishedFilesForBucketId:(NSString *)bucketId
                                                            account:(B2Account *)account
                                                        startFileId:(nullable NSString *)startFileId
                                                       maxFileCount:(nullable NSNumber *)maxFileCount
                                                              error:(out NSError **)error;
- (nullable B2Parts *)listPartsForFileId:(NSString *)fileId
                                 account:(B2Account *)account
                         startPartNumber:(nullable NSNumber *)startPartNumber
                            maxPartCount:(nullable NSNumber *)maxPartCount
                                   error:(out NSError **)error;

// MARK: Convenience

- (BOOL)downloadFileWithFileId:(NSString *)fileId
                       account:(B2Account *)account
                   locationURL:(NSURL *)locationURL
                      progress:(nullable void (^)(NSNumber *))callback
                         error:(out NSError **)error;

- (nullable B2File *)uploadLargeFileAtURL:(NSURL *)localFileURL
                                  account:(B2Account *)account
                                 fileName:(NSString *)filename
                                 bucketId:(NSString *)bucketId
                              contentType:(NSString *)contentType
                              contentSha1:(nullable NSString *)contentSha1
                           lastModifiedOn:(NSDate *)lastModifiedOn
                                 fileInfo:(nullable NSDictionary<NSString *, NSString *> *)fileInfo
                            resumeContext:(nullable B2ResumeContext *)resumeContext
                     resumeContextChanged:(nullable void (^)(B2ResumeContext *))callback
                                    error:(out NSError **)error;

@end

NS_ASSUME_NONNULL_END
