//
//  B2Lifecycle.h
//  B2Kit
//
//  Created by Andreas Meingast on 22.09.19.
//  Copyright © 2019 Andreas Meingast. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol B2Start <NSObject>

- (void)start;

@end

@protocol B2Stop <NSObject>

- (void)stop;

@end

NS_ASSUME_NONNULL_END
