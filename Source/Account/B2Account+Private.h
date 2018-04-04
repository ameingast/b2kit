//
//  B2Account+Private.h
//  B2Kit
//
//  Created by Andreas Meingast on 14.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2Account.h"

NS_ASSUME_NONNULL_BEGIN

@interface B2Account (Private)

- (nullable B2Account *)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
                                     error:(out NSError **)error;

@end

NS_ASSUME_NONNULL_END
