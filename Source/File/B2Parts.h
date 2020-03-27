//
//  B2Parts.h
//  B2Kit
//
//  Created by Andreas Meingast on 11.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface B2Part : NSObject

@property (readonly, nonnull, nonatomic) NSString *fileId;
@property (readonly, nonnull, nonatomic) NSNumber *partNumber;
@property (readonly, nonnull, nonatomic) NSString *contentSha1;
@property (readonly, nonnull, nonatomic) NSDate *uploadTimestamp;

- (B2Part *)initWithFileId:(NSString *)fileId
                partNumber:(NSNumber *)partNumber
               contentSha1:(NSString *)contentSha1
           uploadTimestamp:(NSDate *)uploadTimestamp;

@end

@interface B2Parts : NSObject

@property (readonly, nonnull, nonatomic) NSArray<B2Part *> *parts;
@property (readonly, nonnull, nonatomic) NSNumber *nextPartNumber;

- (B2Parts *)initWithParts:(NSArray<B2Part *> *)parts
            nextPartNumber:(NSNumber *)nextPartNumber;

@end

NS_ASSUME_NONNULL_END
