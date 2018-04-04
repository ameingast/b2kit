//
//  B2BucketLifeCycleRule+Private.h
//  B2Kit
//
//  Created by Andreas Meingast on 08.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2BucketLifeCycleRule.h"

NS_ASSUME_NONNULL_BEGIN

@interface B2BucketLifeCycleRule (Private)

+ (NSArray<NSDictionary<NSString *, id> *> *)toDictionaries:(NSArray<B2BucketLifeCycleRule *> *)lifeCycleRules;
+ (NSArray<B2BucketLifeCycleRule *> *)fromDictionaries:(NSArray<NSDictionary<NSString *, id> *> *)dictionaries;

- (B2BucketLifeCycleRule *)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
                                        error:(out NSError **)error;
- (NSDictionary<NSString *, id> *)toDictionary;

@end

NS_ASSUME_NONNULL_END
