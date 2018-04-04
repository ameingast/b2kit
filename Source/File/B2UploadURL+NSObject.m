//
//  B2UploadURL+NSObject.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2UploadURL.h"

@implementation B2UploadURL (NSObject)

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
    B2UploadURL *other = obj;
    return ([self url] == [other url] || [[self url] isEqual:[other url]]) &&
    ([self authorizationToken] == [other authorizationToken] || [[self authorizationToken] isEqual:[other authorizationToken]]);
}

- (NSUInteger)hash
{
    return [self url].hash ^
    [self authorizationToken].hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2UploadURL %p> {url=%@, authorizationToken=%@}",
            (__bridge void *)self,
            [self url],
            [self authorizationToken]];
}

@end
