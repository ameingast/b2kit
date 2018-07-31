//
//  NSURL+B2Kit.h
//  B2Kit
//
//  Created by Andreas Meingast on 31.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (B2Kit)

- (nullable NSString *)SHA1:(out NSError **)error;
- (nullable NSDate *)modificationDate:(out NSError **)error;

@end

NS_ASSUME_NONNULL_END
