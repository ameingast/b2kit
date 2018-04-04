//
//  B2BucketType.h
//  B2Kit
//
//  Created by Andreas Meingast on 07.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, B2BucketType) {
    B2BucketTypeNone = 0,
    B2BucketTypeAllPublic = 1 << 0,
    B2BucketTypeAllPrivate = 1 << 1,
    B2BucketTypeSnapshot = 1 << 2,
    B2BucketTypeAll = 1 << 3
};

NSString *NSStringFromB2BucketType(B2BucketType bucketType);
NSArray<NSString *> *NSArrayFromB2BucketType(B2BucketType bucketType);
B2BucketType B2BucketTypeFromNSString(NSString *bucketType);

NS_ASSUME_NONNULL_END
