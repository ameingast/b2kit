//
//  B2ResumeContext.m
//  B2Kit
//
//  Created by Andreas Meingast on 19.09.19.
//  Copyright © 2019 Andreas Meingast. All rights reserved.
//

#import "B2ResumeContext.h"

@implementation B2ResumeContext

@synthesize chunkSize = _chunkSize;
@synthesize fileId = _fileId;
@synthesize completedChunks = _completedChunks;

- (B2ResumeContext *)init
{
    self = [super init];
    if (self) {
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

@end
