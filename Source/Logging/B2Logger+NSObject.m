//
//  B2Logger+NSObject.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2Logger.h"

@implementation B2Logger (NSObject)

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
    B2Logger *other = obj;
    return [self logLevel] == [other logLevel];
}

- (NSUInteger)hash
{
    return @([self logLevel]).hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2Logger %p> {logLevel=%@}",
            (__bridge void *)self,
            NSStringFromB2LogLevel([self logLevel])];
}

@end
