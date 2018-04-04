//
//  B2+Logging.m
//  B2Kit
//
//  Created by Andreas Meingast on 06.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2.h"

@implementation B2 (Logging)

- (void)setLogLevel:(B2LogLevel)logLevel
{
    [[B2Logger sharedInstance] setLogLevel:logLevel];
}

- (B2LogLevel)logLevel
{
    return [[B2Logger sharedInstance] logLevel];
}

@end
