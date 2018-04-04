//
//  B2BucketManager+NSObject.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2BucketManager.h"

@implementation B2BucketManager (NSObject)

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2BucketManager %p> {client=%@}",
            (__bridge void *)self,
            [self client]];
}

@end
