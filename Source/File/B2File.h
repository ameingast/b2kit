//
//  B2File.h
//  B2Kit
//
//  Created by Andreas Meingast on 04.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

@import Foundation;

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
@property (nonatomic, readonly, nonnull) NSDictionary<NSString *, NSString *> *metadata;
@property (nonatomic, readonly, nonnull) NSDate *uploadDate;
@property (nonatomic, readonly) B2FileInfoAction action;

- (B2File *)initWithFileId:(NSString *)fileId
                  filename:(NSString *)filename
                 accountId:(NSString *)accountId
                  bucketId:(NSString *)bucketId
             contentLength:(NSNumber *)contentLength
               contentSha1:(NSString *)contentSha1
               contentType:(NSString *)contentType
                  metadata:(NSDictionary<NSString *, NSString *> *)metadata
                    action:(B2FileInfoAction)action
                uploadDate:(NSDate *)uploadDate;

@end

@interface B2FileNames : NSObject

@property (nonatomic, readonly, nonnull) NSString *nextFileName;
@property (nonatomic, readonly, nonnull) NSArray<B2File *> *files;

- (B2FileNames *)initWithNextFileName:(NSString *)nextFileName
                                files:(NSArray<B2File *> *)files;

@end

@interface B2FileVersions : NSObject

@property (nonatomic, readonly, nonnull) NSString *nextFileId;
@property (nonatomic, readonly, nonnull) NSString *nextFileName;
@property (nonatomic, readonly, nonnull) NSArray<B2File *> *files;

- (B2FileVersions *)initWithNextFileId:(NSString *)nextFileId
                          nextFileName:(NSString *)nextFileName
                                 files:(NSArray<B2File *> *)files;

@end

NS_ASSUME_NONNULL_END
