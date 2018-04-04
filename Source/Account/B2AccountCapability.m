//
//  B2AccountCapability.m
//  B2Kit
//
//  Created by Andreas Meingast on 07.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2AccountCapability.h"

inline B2AccountCapability B2AccountCapabilityFromNSArray(NSArray<NSString *> *capabilites)
{
    B2AccountCapability accountCapability = B2AccountCapabilityNone;
    if (!capabilites) {
        return accountCapability;
    }
    for (NSString *capability in capabilites) {
        if ([capability isEqualToString:@"listKeys"]) {
            accountCapability |= B2AccountCapabilityListKeys;
        } else if ([capability isEqualToString:@"writeKeys"]) {
            accountCapability |= B2AccountCapabilityWriteKeys;
        } else if ([capability isEqualToString:@"deleteKeys"]) {
            accountCapability |= B2AccountCapabilityDeleteKeys;
        } else if ([capability isEqualToString:@"listBuckets"]) {
            accountCapability |= B2AccountCapabilityListBuckets;
        } else if ([capability isEqualToString:@"writeBuckets"]) {
            accountCapability |= B2AccountCapabilityWriteBuckets;
        } else if ([capability isEqualToString:@"deleteBuckets"]) {
            accountCapability |= B2AccountCapabilityDeleteBuckets;
        } else if ([capability isEqualToString:@"listFiles"]) {
            accountCapability |= B2AccountCapabilityListFiles;
        } else if ([capability isEqualToString:@"readFiles"]) {
            accountCapability |= B2AccountCapabilityReadFiles;
        } else if ([capability isEqualToString:@"shareFiles"]) {
            accountCapability |= B2AccountCapabilityShareFiles;
        } else if ([capability isEqualToString:@"writeFiles"]) {
            accountCapability |= B2AccountCapabilityWriteFiles;
        } else if ([capability isEqualToString:@"deleteFiles"]) {
            accountCapability |= B2AccountCapabilityDeleteFiles;
        }
    }
    return accountCapability;
}

inline NSString *NSStringFromB2AccountCapability(B2AccountCapability capability)
{
    switch (capability) {
        case B2AccountCapabilityNone:
            return @"";
        case B2AccountCapabilityListKeys:
            return @"listKeys";
        case B2AccountCapabilityWriteKeys:
            return @"writeKeys";
        case B2AccountCapabilityDeleteKeys:
            return @"deleteKeys";
        case B2AccountCapabilityListBuckets:
            return @"listBuckets";
        case B2AccountCapabilityWriteBuckets:
            return @"writeBuckets";
        case B2AccountCapabilityDeleteBuckets:
            return @"deleteBuckets";
        case B2AccountCapabilityListFiles:
            return @"listFiles";
        case B2AccountCapabilityReadFiles:
            return @"readFiles";
        case B2AccountCapabilityShareFiles:
            return @"shareFiles";
        case B2AccountCapabilityWriteFiles:
            return @"writeFiles";
        case B2AccountCapabilityDeleteFiles:
            return @"deleteFiles";
    }
    return @"";
}
