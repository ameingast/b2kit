//
//  B2ClientDataResult.h
//  B2Kit
//
//  Created by Andreas Meingast on 08.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface B2ClientDataResult : NSObject

@property (nonatomic, nonnull, readonly) NSData *data;
@property (nonatomic, nonnull, readonly) NSHTTPURLResponse *response;

- (B2ClientDataResult *)initWithData:(NSData *)data
                            response:(NSHTTPURLResponse *)response;
- (BOOL)validate:(out NSError **)error;

@end

NS_ASSUME_NONNULL_END
