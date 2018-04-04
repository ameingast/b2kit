//
//  B2Range.h
//  B2Kit
//
//  Created by Andreas Meingast on 05.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface B2Range : NSObject

@property (nonatomic, readonly) NSNumber *start;
@property (nonatomic, readonly) NSNumber *end;

- (nullable B2Range *)initWithStart:(NSNumber *)start
                                end:(NSNumber *)end;

@end

NS_ASSUME_NONNULL_END
