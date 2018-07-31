//
//  B2Error.m
//  B2Kit
//
//  Created by Andreas Meingast on 07.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2Error.h"
#import "B2Client.h"
#import "B2JSONValidator.h"

NSString *B2KitDomain = @"com.operationalsemantics.b2kit";
int B2ErrorCodeIncompleteResponse = 1;
int B2ErrorCodeChecksumCreationError = 2;

@implementation B2ClientError

@synthesize status = _status;
@synthesize code = _code;
@synthesize message = _message;

- (B2ClientError *)initWithJSONData:(NSData *)data
                              error:(out NSError *__autoreleasing *)error
{
    self = [self init];
    if (self) {
        NSDictionary<NSString *, id> *json = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:0
                                                                               error:error];
        BOOL validationResult = [[B2JSONValidator sharedInstance] validateJSON:json
                                                                        fields:@[ @"status", @"code", @"message" ]
                                                                         error:error];
        if (!validationResult) {
            return nil;
        }
        _status = (NSNumber *)json[@"status"];
        _code = (NSString *)json[@"code"];
        _message = (NSString *)json[@"message"];
    }
    return self;
}

- (NSError *)createError
{
    return B2CreateError([[self status] integerValue], @{ NSLocalizedDescriptionKey: [self message] });
}

@end

NSError *B2CreateError(NSInteger code, NSDictionary<NSErrorUserInfoKey, id> * _Nullable dictionary) {
    return [[NSError alloc] initWithDomain:B2KitDomain
                                      code:code
                                  userInfo:dictionary];
}
