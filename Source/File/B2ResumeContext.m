//
//  B2ResumeContext.m
//  B2Kit
//
//  Created by Andreas Meingast on 19.09.19.
//  Copyright © 2019 Andreas Meingast. All rights reserved.
//

#import "B2ResumeContext.h"

@implementation B2ResumeContext

@synthesize date = _date;
@synthesize chunkSize = _chunkSize;
@synthesize fileId = _fileId;
@synthesize completedChunks = _completedChunks;

- (B2ResumeContext *)init
{
    self = [super init];
    if (self) {
        _date = [NSDate date];
        _completedChunks = [NSMutableDictionary new];
    }
    return self;
}

- (void)addChunkWithPart:(NSNumber *)chunkPart
                    sha1:(NSString *)sha1
{
    @synchronized (self) {
        [self completedChunks][chunkPart] = sha1;
    }
}

- (void)encodeWithCoder:(nonnull NSCoder *)encoder
{
    [encoder encodeObject:[self date] forKey:@"date"];
    [encoder encodeObject:[self chunkSize] forKey:@"chunkSize"];
    [encoder encodeObject:[self fileId] forKey:@"fileId"];
    [encoder encodeObject:[self completedChunks] forKey:@"completedChunks"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)decoder
{
    self = [super init];
    if (self) {
        _date = [decoder decodeObjectForKey:@"date"];
        _chunkSize = [decoder decodeObjectForKey:@"chunkSize"];
        _fileId = [decoder decodeObjectForKey:@"fileId"];
        NSMutableDictionary *completedChunks = [decoder decodeObjectForKey:@"completedChunks"];
        if (completedChunks) {
            _completedChunks = completedChunks;
        } else {
            _completedChunks = [NSMutableDictionary new];
        }
    }
    return self;
}

@end
