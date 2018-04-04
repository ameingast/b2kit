//
//  B2Range.m
//  B2Kit
//
//  Created by Andreas Meingast on 05.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2Range.h"

@implementation B2Range

@synthesize start = _start;
@synthesize end = _end;

- (B2Range *)initWithStart:(NSNumber *)start
                       end:(NSNumber *)end
{
    self = [super init];
    if (self) {
        _start  = start;
        _end = end;
    }
    return self;
}

@end
