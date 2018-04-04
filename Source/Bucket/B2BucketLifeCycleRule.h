//
//  B2BucketLifeCycleRule.h
//  B2Kit
//
//  Created by Andreas Meingast on 05.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface B2BucketLifeCycleRule : NSObject

@property (nonatomic, readonly, nullable) NSNumber *daysFromUploadingToHiding;
@property (nonatomic, readonly, nullable) NSNumber *daysFromHidingToDeleting;
@property (nonatomic, readonly, nullable) NSString *fileNamePrefix;

- (B2BucketLifeCycleRule *)initWithDaysFromUploadingToHiding:(nullable NSNumber *)daysFromUploadingToHiding
                                    daysFromHidingToDeleting:(nullable NSNumber *)daysFromHidingToDeleting
                                              fileNamePrefix:(nullable NSString *)fileNamePrefix;

@end

NS_ASSUME_NONNULL_END
