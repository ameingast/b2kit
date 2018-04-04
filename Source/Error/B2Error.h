//
//  B2Error.h
//  B2Kit
//
//  Created by Andreas Meingast on 07.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

extern NSString *B2KitDomain;
extern int B2ErrorCodeChecksumCreationError;
extern int B2ErrorCodeIncompleteResponse;

NSError *B2CreateError(NSInteger code, NSDictionary<NSErrorUserInfoKey, id> * _Nullable dictionary);

@interface B2ClientError : NSObject

@property (nonatomic, readonly, nonnull) NSNumber *status;
@property (nonatomic, readonly, nonnull) NSString *code;
@property (nonatomic, readonly, nonnull) NSString *message;

- (nullable B2ClientError *)initWithJSONData:(NSData *)data
                                       error:(out NSError **)error;
- (NSError *)createError;

@end

NS_ASSUME_NONNULL_END
