//
//  B2Error+NSObject.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2Error.h"

@implementation B2ClientError (NSObject)

- (BOOL)isEqual:(id)obj
{
    if (obj == nil) {
        return NO;
    }
    if (self == obj) {
        return YES;
    }
    if (![obj isKindOfClass:[self class]]) {
        return NO;
    }
    B2ClientError *other = obj;
    return ([self status] == [other status] || [[self status] isEqual:[other status]]) &&
    ([self code] == [other code] || [[self code] isEqual:[other code]]) &&
    ([self message] == [other message] || [[self message] isEqual:[other message]]);
}

- (NSUInteger)hash
{
    return [self status].hash ^
    [self code].hash ^
    [self message].hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2ClientError %p> {status=%@, code=%@, message=%@}",
            (__bridge void *)self,
            [self status],
            [self code],
            [self message]];
}

@end
