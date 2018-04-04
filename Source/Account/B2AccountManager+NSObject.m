//
//  B2AccountManager+NSObject.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2AccountManager.h"

@implementation B2AccountManager (NSObject)

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2AccountManager %p> {client=%@}",
            (__bridge void *)self,
            [self client]];
}

@end
