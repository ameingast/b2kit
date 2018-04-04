//
//  B2Bucket+Private.h
//  B2Kit
//
//  Created by Andreas Meingast on 14.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2Bucket.h"

NS_ASSUME_NONNULL_BEGIN

@interface B2Bucket (Private)

+ (nullable NSArray<B2Bucket *> *)bucketsFromJSONData:(NSData *)response
                                                error:(out NSError **)error;
- (nullable B2Bucket *)initWithJSONData:(NSData *)data
                                  error:(out NSError **)error;

@end

NS_ASSUME_NONNULL_END
