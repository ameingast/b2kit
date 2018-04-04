//
//  B2AccountManager.m
//  B2Kit
//
//  Created by Andreas Meingast on 07.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2AccountManager.h"
#import "B2Account.h"
#import "B2Account+Private.h"
#import "B2DefaultClient.h"
#import "B2Endpoint.h"
#import "B2JSONValidator.h"

@implementation B2AccountManager

@synthesize client = _client;

- (B2AccountManager *)initWithClient:(id<B2Client>)client
{
    self = [super init];
    if (self) {
        _client = client;
    }
    return self;
}

- (B2Account *)authorizeAccountWithAccountId:(NSString *)accountId
                              applicationKey:(NSString *)applicationKey
                                       error:(out NSError *__autoreleasing *)error
{
    NSString *credentials = [NSString stringWithFormat:@"%@:%@", accountId, applicationKey];
    NSString *formattedCredentials = [[credentials dataUsingEncoding:NSUTF8StringEncoding]
                                      base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
    NSString *payload = [NSString stringWithFormat:@"Basic %@", formattedCredentials];
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:B2EndpointAuthorizeAccountURL()];
    [mutableRequest addValue:payload
          forHTTPHeaderField:@"Authorization"];
    NSData *response = [[self client] performDownloadRequest:mutableRequest
                                                     account:nil
                                                       error:error];
    if (!response) {
        return nil;
    }
    NSDictionary<NSString *, id> *json = [NSJSONSerialization JSONObjectWithData:response
                                                                         options:0
                                                                           error:error];
    if (!json) {
        return nil;
    }
    return [[B2Account alloc] initWithDictionary:json
                                           error:error];
}

@end
