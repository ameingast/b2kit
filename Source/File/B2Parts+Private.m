//
//  B2Parts+Private.m
//  B2Kit
//
//  Created by Andreas Meingast on 14.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2Parts+Private.h"
#import "B2JSONValidator.h"

@implementation B2Part (Private)

- (B2Part *)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
                         error:(out NSError *__autoreleasing *)error
{
    BOOL validationResult = [[B2JSONValidator sharedInstance] validateJSON:dictionary
                                                                    fields:@[ @"fileId",
                                                                              @"partNumber",
                                                                              @"contentLength",
                                                                              @"contentSha1",
                                                                              @"uploadTimestamp" ]
                                                                     error:error];
    if (!validationResult) {
        return nil;
    }
    return [[B2Part alloc] initWithFileId:(NSString *)dictionary[@"fileId"]
                               partNumber:(NSNumber *)dictionary[@"partNumber"]
                              contentSha1:(NSString *)dictionary[@"contentSha1"]
                          uploadTimestamp:[NSDate dateWithTimeIntervalSince1970:[(NSNumber *)dictionary[@"uploadTimestamp"] integerValue] / 1000]];
}

@end

@implementation B2Parts (Private)

- (B2Parts *)initWithJSONData:(NSData *)data
                        error:(out NSError *__autoreleasing *)error
{
    NSDictionary<NSString *, id> *json = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:0
                                                                           error:error];
    if (!json) {
        return nil;
    }
    return [self initWithDictionary:json
                              error:error];
}

- (B2Parts *)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
                          error:(out NSError *__autoreleasing *)error
{
    BOOL validationResult = [[B2JSONValidator sharedInstance] validateJSON:dictionary
                                                                    fields:@[@"parts", @"nextPartNumber" ]
                                                                     error:error];
    if (!validationResult) {
        return nil;
    }
    NSMutableArray<B2Part *> *parts = [NSMutableArray new];
    for (NSDictionary<NSString *, id> *partDictionary in dictionary[@"parts"]) {
        B2Part *part = [[B2Part alloc] initWithDictionary:partDictionary
                                                    error:error];
        if (!part) {
            return nil;
        }
        [parts addObject:part];
    }
    return [[B2Parts alloc] initWithParts:parts
                           nextPartNumber:(NSNumber *)dictionary[@"nextPartNumber"]];
}

@end
