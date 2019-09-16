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
        _logLevel = B2LogLevelFromNSString([[NSProcessInfo processInfo] environment][@"B2_LOG_LEVEL"]);
    }
    return self;
}

- (BOOL)isLogLevel:(B2LogLevel)level
{
    return [self logLevel] <= level;
}

inline B2LogLevel B2LogLevelFromNSString(NSString *logLevel) {
    if ([logLevel isEqualToString:@"trace"]) {
        return B2LogLevelTrace;
    } else if ([logLevel isEqualToString:@"debug"]) {
        return B2LogLevelDebug;
    } else if ([logLevel isEqualToString:@"info"]) {
        return B2LogLevelInfo;
    } else if ([logLevel isEqualToString:@"warn"]) {
        return B2LogLevelWarn;
    } else if ([logLevel isEqualToString:@"error"]) {
        return B2LogLevelError;
    } else if ([logLevel isEqualToString:@"none"]) {
        return B2LogLevelNone;
    } else {
        return B2LogLevelWarn;
    }
}

inline NSString *NSStringFromB2LogLevel(B2LogLevel logLevel) {
    switch (logLevel) {
        case B2LogLevelTrace:
            return @"trace";
        case B2LogLevelDebug:
            return @"debug";
        case B2LogLevelInfo:
            return @"info";
        case B2LogLevelWarn:
            return @"warn";
        case B2LogLevelError:
            return @"error";
        case B2LogLevelNone:
            return @"none";
    }
}

@end
