//
//  B2UnfinishedLargeFiles+Private.h
//  B2Kit
//
//  Created by Andreas Meingast on 14.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2UnfinishedLargeFiles.h"

NS_ASSUME_NONNULL_BEGIN

@interface B2UnfinishedLargeFile (Private)

- (nullable B2UnfinishedLargeFile *)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
                                                 error:(out NSError **)error;

@end

@interface B2UnfinishedLargeFiles (Private)

- (nullable B2UnfinishedLargeFiles *)initWithJSONData:(NSData *)data
                                                error:(out NSError **)error;
- (nullable B2UnfinishedLargeFiles *)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
                                                  error:(out NSError **)error;

@end

NS_ASSUME_NONNULL_END
