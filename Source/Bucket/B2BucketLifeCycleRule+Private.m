//
//  B2BucketLifeCycleRule+Private.m
//  B2Kit
//
//  Created by Andreas Meingast on 08.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2BucketLifeCycleRule+Private.h"

@implementation B2BucketLifeCycleRule (Private)

+ (NSArray<NSDictionary<NSString *, id> *> *)toDictionaries:(NSArray<B2BucketLifeCycleRule *> *)lifeCycleRules
{
    NSMutableArray<NSDictionary<NSString *, id> *> *result = [NSMutableArray new];
    for (B2BucketLifeCycleRule *lifeCycleRule in lifeCycleRules) {
        [result addObject:[lifeCycleRule toDictionary]];
    }
    return result;
}

+ (NSArray<B2BucketLifeCycleRule *> *)fromDictionaries:(NSArray<NSDictionary<NSString *, id> *> *)dictionaries
{
    NSMutableArray<B2BucketLifeCycleRule *> *result = [NSMutableArray new];
    for (NSDictionary<NSString *, id> *dictionary in dictionaries) {
        [result addObject:[[B2BucketLifeCycleRule alloc] initWithDictionary:dictionary
                                                                      error:nil]];
    }
    return result;
}

- (B2BucketLifeCycleRule *)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
                                        error:(out NSError __unused * __autoreleasing *)error
{
    return [[B2BucketLifeCycleRule alloc] initWithDaysFromUploadingToHiding:dictionary[@"daysFromUploadingToHiding"]
                                                   daysFromHidingToDeleting:dictionary[@"daysFromHidingToDeleting"]
                                                             fileNamePrefix:dictionary[@"fileNamePrefix"]];
}

- (NSDictionary<NSString *, id> *)toDictionary
{
    NSMutableDictionary<NSString *, id> *result = [NSMutableDictionary new];
    if ([self daysFromUploadingToHiding] != nil) {
        [result setObject:(NSNumber *)[self daysFromUploadingToHiding]
                   forKey:@"daysFromUploadingToHiding"];
    }
    if ([self daysFromHidingToDeleting] != nil) {
        [result setObject:(NSNumber *)[self daysFromHidingToDeleting]
                   forKey:@"daysFromHidingToDeleting"];
    }
    if ([self fileNamePrefix]) {
        [result setObject:(NSString *)[self fileNamePrefix]
                   forKey:@"fileNamePrefix"];
    }
    return result;
}

@end
