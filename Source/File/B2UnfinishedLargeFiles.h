//
//  B2UnfinishedLargeFiles.h
//  B2Kit
//
//  Created by Andreas Meingast on 10.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@class B2File;

@interface B2UnfinishedLargeFile : NSObject

@property (nonatomic, readonly, nonnull) NSString *fileId;
@property (nonatomic, readonly, nonnull) NSString *filename;
@property (nonatomic, readonly, nonnull) NSString *accountId;
@property (nonatomic, readonly, nonnull) NSString *bucketId;
@property (nonatomic, readonly, nonnull) NSString *contentType;
@property (nonatomic, readonly, nonnull) NSDictionary<NSString *, NSString *> *fileInfo;
@property (nonatomic, readonly, nonnull) NSDate *uploadTimestamp;

- (B2UnfinishedLargeFile *)initWithFileId:(NSString *)fileId
                                 filename:(NSString *)filename
                                accountId:(NSString *)accountId
                                 bucketId:(NSString *)bucketId
                              contentType:(NSString *)contentType
                                 fileInfo:(NSDictionary<NSString *, NSString *> *)fileInfo
                          uploadTimestamp:(NSDate *)uploadTimestamp;

@end

@interface B2UnfinishedLargeFiles : NSObject

@property (nonatomic, readonly, nonnull) NSArray<B2UnfinishedLargeFile *> *files;
@property (nonatomic, readonly, nullable) NSString *nextFileId;

- (B2UnfinishedLargeFiles *)initWithFiles:(NSArray<B2UnfinishedLargeFile *> *)files
                               nextFileId:(nullable NSString *)nextFileId;

@end

NS_ASSUME_NONNULL_END
