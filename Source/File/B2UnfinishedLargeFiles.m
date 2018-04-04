//
//  B2UnfinishedLargeFiles.m
//  B2Kit
//
//  Created by Andreas Meingast on 10.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2UnfinishedLargeFiles.h"
#import "B2File.h"

@implementation B2UnfinishedLargeFile

@synthesize accountId = _accountId;
@synthesize bucketId = _bucketId;
@synthesize contentType = _contentType;
@synthesize fileId = _fileId;
@synthesize filename = _filename;
@synthesize fileInfo = _fileInfo;
@synthesize uploadTimestamp = _uploadTimestamp;

- (B2UnfinishedLargeFile *)initWithFileId:(NSString *)fileId
                                 filename:(NSString *)filename
                                accountId:(NSString *)accountId
                                 bucketId:(NSString *)bucketId
                              contentType:(NSString *)contentType
                                 fileInfo:(NSDictionary<NSString *, NSString *> *)fileInfo
                          uploadTimestamp:(NSDate *)uploadTimestamp
{
    self = [super init];
    if (self) {
        _fileId = fileId;
        _filename = filename;
        _accountId = accountId;
        _bucketId = bucketId;
        _contentType = contentType;
        _fileInfo = fileInfo;
        _uploadTimestamp = uploadTimestamp;
    }
    return self;
}

@end

@implementation B2UnfinishedLargeFiles

@synthesize files = _files;
@synthesize nextFileId = _nextFileId;

- (B2UnfinishedLargeFiles *)initWithFiles:(NSArray<B2UnfinishedLargeFile *> *)files
                               nextFileId:(NSString *)nextFileId
{
    self = [super init];
    if (self) {
        _files = files;
        _nextFileId = nextFileId;
    }
    return self;
}

@end
