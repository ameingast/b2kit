//
//  B2File.h
//  B2Kit
//
//  Created by Andreas Meingast on 04.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "B2FileInfoAction.h"

NS_ASSUME_NONNULL_BEGIN

@class B2Account;

@interface B2File : NSObject

@property (nonatomic, readonly, nonnull) NSString *fileId;
@property (nonatomic, readonly, nonnull) NSString *filename;
@property (nonatomic, readonly, nonnull) NSString *accountId;
@property (nonatomic, readonly, nonnull) NSString *contentSha1;
@property (nonatomic, readonly, nonnull) NSString *bucketId;
@property (nonatomic, readonly, nonnull) NSNumber *contentLength;
@property (nonatomic, readonly, nonnull) NSString *contentType;
@property (nonatomic, readonly, nonnull) NSDictionary<NSString *, NSString *> *fileInfo;
@property (nonatomic, readonly, nonnull) NSDate *uploadDate;
@property (nonatomic, readonly) B2FileInfoAction action;

- (B2File *)initWithFileId:(NSString *)fileId
                  filename:(NSString *)filename
                 accountId:(NSString *)accountId
                  bucketId:(NSString *)bucketId
             contentLength:(NSNumber *)contentLength
               contentSha1:(NSString *)contentSha1
               contentType:(NSString *)contentType
                  fileInfo:(NSDictionary<NSString *, NSString *> *)fileInfo
                    action:(B2FileInfoAction)action
                uploadDate:(NSDate *)uploadDate;

@end

@interface B2FileNames : NSObject

@property (nonatomic, readonly, nullable) NSString *nextFileName;
@property (nonatomic, readonly, nonnull) NSArray<B2File *> *files;

- (B2FileNames *)initWithNextFileName:(nullable NSString *)nextFileName
                                files:(NSArray<B2File *> *)files;

@end

@interface B2FileVersions : NSObject

@property (nonatomic, readonly, nullable) NSString *nextFileId;
@property (nonatomic, readonly, nullable) NSString *nextFileName;
@property (nonatomic, readonly, nonnull) NSArray<B2File *> *files;

- (B2FileVersions *)initWithNextFileId:(nullable NSString *)nextFileId
                          nextFileName:(nullable NSString *)nextFileName
                                 files:(NSArray<B2File *> *)files;

@end

NS_ASSUME_NONNULL_END
