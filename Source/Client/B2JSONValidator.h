//
//  B2JSONValidator.h
//  B2Kit
//
//  Created by Andreas Meingast on 08.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface B2JSONValidator : NSObject

+ (B2JSONValidator *)sharedInstance;

- (BOOL)validateJSON:(NSDictionary<NSString *, id> *)dictionary
              fields:(NSArray<NSString *> *)fields
               error:(out NSError **)error;

@end

NS_ASSUME_NONNULL_END
