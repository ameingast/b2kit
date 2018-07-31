//
//  B2JSONValidator.m
//  B2Kit
//
//  Created by Andreas Meingast on 08.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2JSONValidator.h"
#import "B2Error.h"
#import "B2Logger.h"
#import "NSArray+B2Kit.h"
#import "NSDictionary+B2Kit.h"

@implementation B2JSONValidator

+ (B2JSONValidator *)sharedInstance
{
    static B2JSONValidator *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (BOOL)validateJSON:(NSDictionary<NSString *, id> *)dictionary
              fields:(NSArray<NSString *> *)fields
               error:(NSError *__autoreleasing *)error
{
    B2LogDebug("Validating JSON dictionary against fields: %@ - %@",
               [fields singleLineDescription],
               [dictionary singleLineDescription]);
    for (NSString *field in fields) {
        if (!dictionary[field]) {
            if (error) {
                *error = B2CreateError(B2ErrorCodeIncompleteResponse, @{ @"response": dictionary,
                                                                         @"missingField": field });
            }
            B2LogWarn("JSON validation failed. Missing field: %@", field);
            return NO;
        }
    }
    B2LogDebug("JSON validation succeeded");
    return YES;
}

@end
