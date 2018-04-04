//
//  B2JSONValidator+NSObject.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2JSONValidator.h"

@implementation B2JSONValidator (NSObject)

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2JSONValidator %p> {}",
            (__bridge void *)self];
}

@end
