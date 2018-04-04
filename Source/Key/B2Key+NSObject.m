//
//  B2Key+NSObject.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2Key.h"

@implementation B2Key (NSObject)

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2Key %p> {}",
            (__bridge void *)self];
}

@end
