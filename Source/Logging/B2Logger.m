//
//  B2Logger.m
//  B2Kit
//
//  Created by Andreas Meingast on 27.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2Logger.h"

@implementation B2Logger

@synthesize logLevel = _logLevel;

+ (B2Logger *)sharedInstance
{
    static B2Logger *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (B2Logger *)init
{
    self = [super init];
    if (self) {
        _logLevel = B2LogLevelWarn;
    }
    return self;
}

- (BOOL)isLogLevel:(B2LogLevel)level
{
    return [self logLevel] <= level;
}

@end
