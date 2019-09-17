//
//  B2File.m
//  B2Kit
//
//  Created by Andreas Meingast on 04.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2File.h"
#import "B2Account.h"
#import "B2FileInfoAction.h"

@implementation B2File

@synthesize fileId = _fileId;
@synthesize filename = _filename;
@synthesize accountId = _accountId;
@synthesize contentSha1 = _contentSha1;
@synthesize bucketId = _bucketId;
@synthesize contentLength = _contentLength;
@synthesize contentType = _contentType;
@synthesize fileInfo = _fileInfo;
@synthesize action = _action;
@synthesize uploadDate = _uploadDate;

- (B2File *)initWithFileId:(NSString *)fileId
                  filename:(NSString *)filename
                 accountId:(NSString *)accountId
                  bucketId:(NSString *)bucketId
             contentLength:(NSNumber *)contentLength
               contentSha1:(NSString *)contentSha1
               contentType:(NSString *)contentType
                  fileInfo:(NSDictionary<NSString *, NSString *> *)fileInfo
                    action:(B2FileInfoAction)action
                uploadDate:(NSDate *)uploadDate
{
    self = [self init];
    if (self) {
        _fileId = fileId;
        _filename = filename;
        _accountId = accountId;
        _bucketId = bucketId;
        _contentLength = contentLength;
        _contentSha1 = contentSha1;
        _contentType = contentType;
        _fileInfo = fileInfo;
        _action = action;
        _uploadDate = uploadDate;
    }
    return self;
}

@end

@implementation B2FileNames

@synthesize nextFileName = _nextFileName;
@synthesize files = _files;

- (B2FileNames *)initWithNextFileName:(NSString *)nextFileName
                                files:(NSArray<B2File *> *)files
{
    self = [self init];
    if (self) {
        _nextFileName = nextFileName;
        _files = files;
    }
    return self;
}

@end

@implementation B2FileVersions

@synthesize nextFileId = _nextFileId;
@synthesize nextFileName = _nextFileName;
@synthesize files = _files;

- (B2FileVersions *)initWithNextFileId:(NSString *)nextFileId
                          nextFileName:(NSString *)nextFileName
                                 files:(NSArray<B2File *> *)files
{
    self = [self init];
    if (self) {
        _nextFileId = nextFileId;
        _nextFileName = nextFileName;
        _files = files;
    }
    return self;
}

@end
