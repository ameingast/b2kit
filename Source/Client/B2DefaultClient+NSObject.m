//
//  B2DefaultClient+NSObject.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2DefaultClient.h"

@implementation B2DefaultClient (NSObject)

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2DefaultClient %p> {session=%@}",
            (__bridge void *)self,
            [self session]];
}

@end
