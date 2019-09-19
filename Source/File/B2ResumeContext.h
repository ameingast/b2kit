//
//  B2ResumeContext.h
//  B2Kit
//
//  Created by Andreas Meingast on 19.09.19.
//  Copyright © 2019 Andreas Meingast. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface B2ResumeContext : NSObject

@property (nonatomic, nullable) NSNumber *chunkSize;
@property (nonatomic, nullable) NSString *fileId;
@property (nonatomic, nonnull) NSMutableDictionary<NSNumber *, NSString *> *completedChunks;

- (B2ResumeContext *)init;

- (void)addChunkWithPart:(NSNumber *)chunkPart
                    sha1:(NSString *)sha1;

@end

NS_ASSUME_NONNULL_END
