//
//  B2Logger.h
//  B2Kit
//
//  Created by Andreas Meingast on 27.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, B2LogLevel) {
    B2LogLevelTrace = 1,
    B2LogLevelDebug = 2,
    B2LogLevelInfo  = 3,
    B2LogLevelWarn  = 4,
    B2LogLevelError = 5,
    B2LogLevelNone  = 6
};

@interface B2Logger : NSObject

@property (atomic) B2LogLevel logLevel;

+ (B2Logger *)sharedInstance;

- (BOOL)isLogLevel:(B2LogLevel)level;

@end

B2LogLevel B2LogLevelFromNSString(NSString * _Nullable logLevel);
NSString *NSStringFromB2LogLevel(B2LogLevel logLevel);

#define B2LogTrace(fmt, ...)                                                                                             \
    do {                                                                                                                 \
        if ([[B2Logger sharedInstance] isLogLevel:B2LogLevelTrace]) {                                                    \
            NSLog((@"[#%d]%s(%p) [TRACE] → " fmt), __LINE__, __PRETTY_FUNCTION__, (__bridge void *)self, ##__VA_ARGS__); \
        }                                                                                                                \
    } while (0)

#define B2LogDebug(fmt, ...)                                                                                             \
    do {                                                                                                                 \
        if ([[B2Logger sharedInstance] isLogLevel:B2LogLevelDebug]) {                                                    \
            NSLog((@"[#%d]%s(%p) [DEBUG] → " fmt), __LINE__, __PRETTY_FUNCTION__, (__bridge void *)self, ##__VA_ARGS__); \
        }                                                                                                                \
    } while (0)

#define B2LogInfo(fmt, ...)                                                                                              \
    do {                                                                                                                 \
        if ([[B2Logger sharedInstance] isLogLevel:B2LogLevelInfo]) {                                                     \
            NSLog((@"[#%d]%s(%p) [INFO]  → " fmt), __LINE__, __PRETTY_FUNCTION__, (__bridge void *)self, ##__VA_ARGS__); \
        }                                                                                                                \
    } while (0)

#define B2LogWarn(fmt, ...)                                                                                              \
    do {                                                                                                                 \
        if ([[B2Logger sharedInstance] isLogLevel:B2LogLevelWarn]) {                                                     \
            NSLog((@"[#%d]%s(%p) [WARN]  → " fmt), __LINE__, __PRETTY_FUNCTION__, (__bridge void *)self, ##__VA_ARGS__); \
        }                                                                                                                \
    } while (0)

#define B2LogError(fmt, ...)                                                                                             \
    do {                                                                                                                 \
        if ([[B2Logger sharedInstance] isLogLevel:B2LogLevelError]) {                                                    \
            NSLog((@"[#%d]%s(%p) [ERROR] → " fmt), __LINE__, __PRETTY_FUNCTION__, (__bridge void *)self, ##__VA_ARGS__); \
        }                                                                                                                \
    } while (0)

NS_ASSUME_NONNULL_END
