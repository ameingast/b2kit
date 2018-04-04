//
//  B2FileManager+NSObject.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2FileManager.h"

@implementation B2FileManager (NSObject)

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2FileManager %p> {client=%@}",
            (__bridge void *)self,
            [self client]];
}

@end
