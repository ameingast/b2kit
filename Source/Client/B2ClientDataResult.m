//
//  B2ClientDataResult.m
//  B2Kit
//
//  Created by Andreas Meingast on 08.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2ClientDataResult.h"
#import "B2Error.h"

@implementation B2ClientDataResult

@synthesize data = _data;
@synthesize response = _response;

- (B2ClientDataResult *)initWithData:(NSData *)data
                            response:(NSHTTPURLResponse *)response
{
    self = [self init];
    if (self) {
        _data = data;
        _response = response;
    }
    return self;
}

- (BOOL)validate:(out NSError *__autoreleasing *)error
{
    if ([[self response] statusCode] != 200) {
        if (error) {
            B2ClientError *clientError = [[B2ClientError alloc] initWithJSONData:[self data]
                                                                           error:error];
            *error = [clientError createError];
        }
        return NO;
    }
    return YES;
}

@end
