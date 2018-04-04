//
//  B2BucketType.m
//  B2Kit
//
//  Created by Andreas Meingast on 07.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2BucketType.h"

inline NSString *NSStringFromB2BucketType(B2BucketType bucketType) {
    switch (bucketType) {
        case B2BucketTypeAllPrivate:
            return @"allPrivate";
        case B2BucketTypeAllPublic:
            return @"allPublic";
        case B2BucketTypeSnapshot:
            return @"snapshot";
        case B2BucketTypeNone:
            return @"";
        case B2BucketTypeAll:
            return @"all";
        default:
            return @"";
    }
}

inline NSArray<NSString *> *NSArrayFromB2BucketType(B2BucketType bucketType) {
    NSMutableArray<NSString *> *result = [NSMutableArray new];
    if (bucketType == B2BucketTypeNone) {
        return @[];
    }
    if (bucketType & B2BucketTypeAllPublic) {
        [result addObject:@"allPublic"];
    }
    if (bucketType & B2BucketTypeAllPrivate) {
        [result addObject:@"allPrivate"];
    }
    if (bucketType & B2BucketTypeSnapshot) {
        [result addObject:@"snapshot"];
    }
    if (bucketType / B2BucketTypeAll) {
        [result addObject:@"all"];
    }
    return result;
}

inline B2BucketType B2BucketTypeFromNSString(NSString *bucketType) {
    if ([bucketType isEqualToString:@"allPrivate"]) {
        return B2BucketTypeAllPrivate;
    } else if ([bucketType isEqualToString:@"allPublic"]) {
        return B2BucketTypeAllPublic;
    } else if ([bucketType isEqualToString:@"snapshot"]) {
        return B2BucketTypeSnapshot;
    } else if ([bucketType isEqualToString:@"all"]) {
        return B2BucketTypeAll;
    } else {
        return B2BucketTypeNone;
    }
}
