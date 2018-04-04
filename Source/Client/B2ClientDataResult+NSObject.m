//
//  B2ClientDataResult+NSObject.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2ClientDataResult.h"

@implementation B2ClientDataResult (NSObject)

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
    B2ClientDataResult *other = obj;
    return ([self data] == [other data] || [[self data] isEqual:[other data]]) &&
    ([self response] == [other response] || [[self response] isEqual:[other response]]);
}

- (NSUInteger)hash
{
    return [self data].hash ^
    [self response].hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2ClientDataResult %p> {data=<%ld bytes>, response=%@}",
            (__bridge void *)self,
            [[self data] length],
            [self response]];
}

@end
