//
//  B2+NSObject.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2.h"

@implementation B2 (NSObject)

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2 %p> {client=%@, accountManager=%@, bucketManager=%@, fileManager=%@}",
            (__bridge void *)self,
            [self client],
            [self accountManager],
            [self bucketManager],
            [self fileManager]];
}

@end
