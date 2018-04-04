//
//  B2Account+Private.m
//  B2Kit
//
//  Created by Andreas Meingast on 14.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2Account+Private.h"
#import "B2JSONValidator.h"

@implementation B2Account (Private)

- (B2Account *)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
                            error:(out NSError *__autoreleasing *)error
{
    BOOL validationResult = [[B2JSONValidator sharedInstance] validateJSON:dictionary
                                                                    fields:@[ @"accountId",
                                                                              @"authorizationToken",
                                                                              @"apiUrl",
                                                                              @"downloadUrl",
                                                                              @"recommendedPartSize",
                                                                              @"minimumPartSize",
                                                                              @"absoluteMinimumPartSize" ]
                                                                     error:error];
    if (!validationResult) {
        return nil;
    }
    return [self initWithIdentifier:(NSString *)dictionary[@"accountId"]
                              token:(NSString *)dictionary[@"authorizationToken"]
                accountCapabilities:dictionary[@"capabilities"] ? B2AccountCapabilityFromNSArray((NSArray<NSString *> *)dictionary[@"capabilities"]) : B2AccountCapabilityNone
                             apiURL:(NSURL *)[NSURL URLWithString:(NSString *)dictionary[@"apiUrl"]]
                        downloadURL:(NSURL *)[NSURL URLWithString:(NSString *)dictionary[@"downloadUrl"]]
                recommendedPartSize:(NSNumber *)dictionary[@"recommendedPartSize"]
            absoluteMinimumPartSize:(NSNumber *)dictionary[@"absoluteMinimumPartSize"]];
}

@end
