//
//  B2UploadURL.m
//  B2Kit
//
//  Created by Andreas Meingast on 09.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2UploadURL.h"

@implementation B2UploadURL

@synthesize url = _url;
@synthesize authorizationToken = _authorizationToken;

- (B2UploadURL *)initWithURL:(NSURL *)url
          authorizationToken:(NSString *)authorizationToken
{
    self = [self init];
    if (self) {
        _url = url;
        _authorizationToken = authorizationToken;
    }
    return self;
}

@end
