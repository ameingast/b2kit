//
//  B2Parts.m
//  B2Kit
//
//  Created by Andreas Meingast on 11.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2Parts.h"

@implementation B2Part

@synthesize fileId = _fileId;
@synthesize partNumber = _partNumber;
@synthesize contentSha1 = _contentSha1;
@synthesize uploadTimestamp = _uploadTimestamp;

- (B2Part *)initWithFileId:(NSString *)fileId
                partNumber:(NSNumber *)partNumber
               contentSha1:(NSString *)contentSha1
           uploadTimestamp:(NSDate *)uploadTimestamp
{
    self = [super init];
    if (self) {
        _fileId = fileId;
        _partNumber = partNumber;
        _contentSha1 = contentSha1;
        _uploadTimestamp = uploadTimestamp;
    }
    return self;
}

@end

@implementation B2Parts

@synthesize parts = _parts;
@synthesize nextPartNumber = _nextPartNumber;

- (B2Parts *)initWithParts:(NSArray<B2Part *> *)parts
            nextPartNumber:(NSNumber *)nextPartNumber
{
    self = [super init];
    if (self) {
        _parts = parts;
        _nextPartNumber = nextPartNumber;
    }
    return self;
}

@end
