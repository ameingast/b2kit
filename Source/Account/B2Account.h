//
//  B2Account.h
//  B2Kit
//
//  Created by Andreas Meingast on 04.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

@import Foundation;

#import "B2AccountCapability.h"

NS_ASSUME_NONNULL_BEGIN

@interface B2Account : NSObject

@property (nonatomic, nonnull, readonly) NSString *accountId;
@property (nonatomic, nonnull, readonly) NSString *token;
@property (nonatomic, readonly) B2AccountCapability accountCapabilities;
@property (nonatomic, nonnull, readonly) NSURL *apiURL;
@property (nonatomic, nonnull, readonly) NSURL *downloadURL;
@property (nonatomic, nonnull, readonly) NSNumber *recommendedPartSize;
@property (nonatomic, nonnull, readonly) NSNumber *absoluteMinimumPartSize;

- (B2Account *)initWithIdentifier:(NSString *)identifier
                            token:(NSString *)token
              accountCapabilities:(B2AccountCapability)accountCapabilities
                           apiURL:(NSURL *)apiURL
                      downloadURL:(NSURL *)downloadURL
              recommendedPartSize:(NSNumber *)recommendedPartSize
          absoluteMinimumPartSize:(NSNumber *)absoluteMinimumPartSize;

@end

NS_ASSUME_NONNULL_END
