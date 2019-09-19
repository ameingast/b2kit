//
//  B2ResumeContext+NSObject.m
//  B2Kit
//
//  Created by Andreas Meingast on 19.09.19.
//  Copyright © 2019 Andreas Meingast. All rights reserved.
//

#import "B2ResumeContext.h"

@implementation B2ResumeContext (NSObject)

- (BOOL)isEqual:(id)obj
{
    if (obj == nil) {
        return NO;
    }
    if (self == obj) {
        return YES;
    }
    if (![obj isKindOfClass:[self class]]) {
        return NO;
    }
    B2ResumeContext *other = obj;
    return ([self date] == [other date] || [[self date] isEqual:[other date]]) &&
    ([self chunkSize] == [other chunkSize] || [[self chunkSize] isEqual:[other chunkSize]]) &&
    ([self fileId] == [other fileId] || [[self fileId] isEqual:[other fileId]]) &&
    ([self completedChunks] == [other completedChunks] || [[self completedChunks] isEqual:[other completedChunks]]);
}

- (NSUInteger)hash
{
    return [self date].hash ^
    [self chunkSize].hash ^
    [self fileId].hash ^
    [self completedChunks].hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2ResumeContext %p> {date=%@, chunkSize=%@, fileId=%@, completedChunks=%@}",
            (__bridge void *)self,
            [self date],
            [self chunkSize],
            [self fileId],
            [self completedChunks]];
}

@end
