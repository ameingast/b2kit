//
//  B2BucketLifeCycleRule+NSObject.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2BucketLifeCycleRule.h"

@implementation B2BucketLifeCycleRule (NSObject)

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
    B2BucketLifeCycleRule *other = obj;
    return ([self daysFromUploadingToHiding] == [other daysFromUploadingToHiding] || [[self daysFromUploadingToHiding] isEqual:[other daysFromUploadingToHiding]]) &&
    ([self daysFromHidingToDeleting] == [other daysFromHidingToDeleting] || [[self daysFromHidingToDeleting] isEqual:[other daysFromHidingToDeleting]]) &&
    ([self fileNamePrefix] == [other fileNamePrefix] || [[self fileNamePrefix] isEqual:[other fileNamePrefix]]);
}

- (NSUInteger)hash
{
    return [self daysFromUploadingToHiding].hash ^
    [self daysFromHidingToDeleting].hash ^
    [self fileNamePrefix].hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"B2BucketLifeCycleRule %p> {daysFromUploadingToHiding=%@, "
            "daysFromHidingToDeleting=%@, fileNamePrefix=%@}",
            (__bridge void*)self,
            [self daysFromUploadingToHiding],
            [self daysFromHidingToDeleting],
            [self fileNamePrefix]];
}

@end
