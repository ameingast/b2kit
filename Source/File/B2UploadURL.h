//
//  B2UploadURL.h
//  B2Kit
//
//  Created by Andreas Meingast on 09.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface B2UploadURL : NSObject

@property (nonatomic, readonly, nonnull) NSURL *url;
@property (nonatomic, readonly, nonnull) NSString *authorizationToken;

- (B2UploadURL *)initWithURL:(NSURL *)url
          authorizationToken:(NSString *)authorizationToken;

@end

NS_ASSUME_NONNULL_END
