//
//  B2.h
//  B2Kit
//
//  Created by Andreas Meingast on 04.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

@import Foundation;

#import <B2Kit/B2Account.h>
#import <B2Kit/B2File.h>
#import <B2Kit/B2FileInfoAction.h>
#import <B2Kit/B2Bucket.h>
#import <B2Kit/B2BucketLifeCycleRule.h>
#import <B2Kit/B2Key.h>
#import <B2Kit/B2Range.h>
#import <B2Kit/B2UploadURL.h>
#import <B2Kit/B2Logger.h>
#import <B2Kit/B2UnfinishedLargeFiles.h>
#import <B2Kit/B2Parts.h>

NS_ASSUME_NONNULL_BEGIN

@protocol B2Client;

@interface B2 : NSObject

+ (B2 *)sharedInstance;

@property (readonly, nonnull, nonatomic) id<B2Client> client;

@end

@interface B2 (Accounts)

- (nullable B2Account *)authorizeAccountWithAccountId:(NSString *)accountId
                                       applicationKey:(NSString *)applicationKey
                                                error:(out NSError **)error;

@end

@interface B2 (Buckets)

- (nullable B2Bucket *)createBucketWithBucketName:(NSString *)bucketName
                                          account:(B2Account *)account
                                       bucketType:(B2BucketType)bucketType
                                             info:(nullable NSDictionary<NSString *, id> *)info
                                   lifeCycleRules:(nullable NSArray<B2BucketLifeCycleRule *> *)lifeCycleRules
                                            error:(out NSError **)error;
- (nullable NSArray<B2Bucket *>*)listBucketsForAccount:(B2Account *)account
                                              bucketId:(nullable NSString *)bucketId
                                            bucketName:(nullable NSString *)bucketName
                                           bucketTypes:(B2BucketType)bucketTypes
                                                 error:(out NSError **)error;
- (nullable B2Bucket *)deleteBucketWithBucketId:(NSString *)bucketId
                                        account:(B2Account *)account
                                          error:(out NSError **)error;
- (nullable B2Bucket *)updateBucketWithBucketId:(NSString *)bucketId
                                        account:(B2Account *)account
                                     bucketType:(B2BucketType)bucketType
                                           info:(nullable NSDictionary<NSString *, id> *)info
                                 lifeCycleRules:(nullable NSArray<B2BucketLifeCycleRule *> *)lifeCycleRules
                                          error:(out NSError **)error;

@end

@interface B2 (Files)

- (nullable B2File *)fileInfo:(NSString *)fileId
                      account:(B2Account *)account
                        error:(out NSError **)error;
- (nullable B2File *)uploadFileAtURL:(NSURL *)localFileURL
                             account:(B2Account *)account
                            fileName:(NSString *)filename
                        sha1Checksum:(NSString *)sha1Checksum
                            bucketId:(NSString *)bucketId
                         contentType:(NSString *)contentType
                      lastModifiedOn:(NSUInteger)lastModifiedOn
                            fileInfo:(nullable NSDictionary<NSString *, NSString *> *)fileInfo
                               error:(out NSError **)error;
- (BOOL)downloadFileWithFileId:(NSString *)fileId
                       account:(nullable B2Account *)account
                         range:(nullable B2Range *)range
                   locationURL:(NSURL *)locationURL
                         error:(out NSError **)error;
- (BOOL)downloadFileWithFileName:(NSString *)fileName
                      bucketName:(NSString *)bucketName
                         account:(B2Account *)account
                           range:(nullable B2Range *)range
                     locationURL:(NSURL *)locationURL
                           error:(out NSError **)error;
- (BOOL)hideFileWithFileName:(NSString *)fileName
                     account:(B2Account *)account
                      bucket:(B2Bucket *)bucket
                       error:(out NSError **)error;
- (BOOL)deleteFileWithFileId:(NSString *)fileId
                    fileName:(NSString *)filename
                     account:(B2Account *)account
                       error:(out NSError **)error;
- (nullable NSArray<B2File *> *)listFilesWithBucketId:(NSString *)bucketId
                                              account:(B2Account *)account
                                        startFileName:(nullable NSString *)startFileName
                                         maxFileCount:(nullable NSNumber *)maxFileCount
                                               prefix:(nullable NSString *)prefix
                                                error:(out NSError **)error;

@end

@interface B2 (LargeFiles)

- (nullable B2UploadURL *)uploadPartURLForFileId:(NSString *)fileId
                                         account:(B2Account *)account
                                           error:(out NSError **)error;
- (nullable NSString *)startUploadForFilename:(NSString *)filename
                                      account:(B2Account *)account
                                     bucketId:(NSString *)bucketId
                                  contentType:(NSString *)contentType
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
                       data:(NSURL *)dataLocation
                     number:(NSNumber *)partNumber
              contentLength:(NSNumber *)contentLength
        contentSha1Checksum:(NSString *)contentSha1Checksum
                      error:(out NSError **)error;
- (nullable B2UnfinishedLargeFiles *)listUnfinishedFilesForBucketId:(NSString *)bucketId
                                                            account:(B2Account *)account
                                                        startFileId:(nullable NSString *)startFileId
                                                       maxFileCount:(nullable NSNumber *)maxFileCount
                                                              error:(out NSError **)error;
- (nullable id)listPartsForFileId:(NSString *)fileId
                          account:(B2Account *)account
                  startPartNumber:(nullable NSNumber *)startPartNumber
                     maxPartCount:(nullable NSNumber *)maxPartCount
                            error:(out NSError **)error;

@end

@interface B2 (Logging)

@property (atomic) B2LogLevel logLevel;

@end

@interface B2 (Keys)

@end

@interface B2 (Versions)

@end

NS_ASSUME_NONNULL_END
