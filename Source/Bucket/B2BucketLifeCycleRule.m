//
//  B2BucketLifeCycleRule.m
//  B2Kit
//
//  Created by Andreas Meingast on 05.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2BucketLifeCycleRule.h"

@implementation B2BucketLifeCycleRule

@synthesize daysFromUploadingToHiding = _daysFromUploadingToHiding;
@synthesize daysFromHidingToDeleting = _daysFromHidingToDeleting;
@synthesize fileNamePrefix = _fileNamePrefix;

- (B2BucketLifeCycleRule *)initWithDaysFromUploadingToHiding:(NSNumber *)daysFromUploadingToHiding
                                    daysFromHidingToDeleting:(NSNumber *)daysFromHidingToDeleting
                                              fileNamePrefix:(NSString *)fileNamePrefix
{
    self = [self init];
    if (self) {
        _daysFromUploadingToHiding = daysFromUploadingToHiding;
        _daysFromHidingToDeleting = daysFromHidingToDeleting;
        _fileNamePrefix = fileNamePrefix;
    }
    return self;
}

@end
