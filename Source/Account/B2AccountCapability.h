//
//  B2AccountCapability.h
//  B2Kit
//
//  Created by Andreas Meingast on 07.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, B2AccountCapability) {
    B2AccountCapabilityNone = 0,
    B2AccountCapabilityListKeys = 1 << 0,
    B2AccountCapabilityWriteKeys = 1 << 1,
    B2AccountCapabilityDeleteKeys = 1 << 2,
    B2AccountCapabilityListBuckets = 1 << 3,
    B2AccountCapabilityWriteBuckets = 1 << 4,
    B2AccountCapabilityDeleteBuckets = 1 << 5,
    B2AccountCapabilityListFiles = 1 << 6,
    B2AccountCapabilityReadFiles = 1 << 7,
    B2AccountCapabilityShareFiles = 1 << 8,
    B2AccountCapabilityWriteFiles = 1 << 9,
    B2AccountCapabilityDeleteFiles = 1 << 10
};

B2AccountCapability B2AccountCapabilityFromNSArray(NSArray<NSString *> * _Nullable capabilites);
NSString *NSStringFromB2AccountCapability(B2AccountCapability capability);

NS_ASSUME_NONNULL_END
