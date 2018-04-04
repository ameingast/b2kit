//
//  B2Account.m
//  B2Kit
//
//  Created by Andreas Meingast on 04.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2Account.h"

@implementation B2Account

@synthesize accountId = _accountId;
@synthesize token = _token;
@synthesize accountCapabilities = _accountCapabilities;
@synthesize apiURL = _apiURL;
@synthesize downloadURL = _downloadURL;
@synthesize recommendedPartSize = _recommendedPartSize;
@synthesize absoluteMinimumPartSize = _absoluteMinimumPartSize;

- (B2Account *)initWithIdentifier:(NSString *)accountId
                            token:(NSString *)token
              accountCapabilities:(B2AccountCapability)accountCapabilities
                           apiURL:(NSURL *)apiURL
                      downloadURL:(NSURL *)downloadURL
              recommendedPartSize:(NSNumber *)recommendedPartSize
          absoluteMinimumPartSize:(NSNumber *)absoluteMinimumPartSize
{
    self = [super init];
    if (self) {
        _accountId = accountId;
        _token = token;
        _accountCapabilities = accountCapabilities;
        _apiURL = apiURL;
        _downloadURL = downloadURL;
        _recommendedPartSize = recommendedPartSize;
        _absoluteMinimumPartSize = absoluteMinimumPartSize;
    }
    return self;
}

@end
