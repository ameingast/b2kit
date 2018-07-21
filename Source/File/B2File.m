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
@synthesize metadata = _metadata;
@synthesize action = _action;
@synthesize uploadDate = _uploadDate;

- (B2File *)initWithFileId:(NSString *)fileId
                  filename:(NSString *)filename
                 accountId:(NSString *)accountId
                  bucketId:(NSString *)bucketId
             contentLength:(NSNumber *)contentLength
               contentType:(NSString *)contentType
                  metadata:(NSDictionary<NSString *, NSString *> *)metadata
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
        _contentType = contentType;
        _metadata = metadata;
        _action = action;
        _uploadDate = uploadDate;
    }
    return self;
}

@end
