//
//  B2DefaultClient.m
//  B2Kit
//
//  Created by Andreas Meingast on 26.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2DefaultClient.h"
#import "B2ClientDataResult.h"
#import "B2Account.h"
#import "B2Error.h"
#import "B2Logger.h"

@implementation B2DefaultClient

@synthesize session = _session;

+ (id<B2Client>)sharedInstance
{
    static id<B2Client> instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (B2DefaultClient *)init
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.URLCredentialStorage = nil;
        _session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    }
    return self;
}

- (NSData *)performDownloadRequest:(NSMutableURLRequest *)mutableRequest
                           account:(B2Account *)account
                             error:(out NSError *__autoreleasing *)error
{
    B2ClientDataResult __block *result;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    if (account) {
        [mutableRequest addValue:[(B2Account *)account token]
              forHTTPHeaderField:@"Authorization"];
    }
    NSURLSessionTask *task = [[self session] dataTaskWithRequest:mutableRequest
                                               completionHandler:^(NSData *data,
                                                                   NSURLResponse *response,
                                                                   NSError *requestError) {
                                                   if (!data && requestError) {
                                                       if (error) {
                                                           *error = requestError;
                                                       }
                                                   } else if (data && response) {
                                                       result = [[B2ClientDataResult alloc] initWithData:(NSData *)data
                                                                                                response:(NSHTTPURLResponse *)response];
                                                   }
                                                   dispatch_semaphore_signal(semaphore);
                                               }];
    B2LogDebug("Enqueuing download request: %@ for account: %@", mutableRequest, account);
    [task resume];
    (void)dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    B2LogDebug("Finished download request: %@ (error=%@)", result, error ? *error : nil);
    return result && [result validate:error] ? [result data] : nil;
}

- (BOOL)performDownloadRequest:(NSMutableURLRequest *)mutableRequest
                       account:(B2Account *)account
                       fileURL:(NSURL *)fileURL
                         error:(out NSError *__autoreleasing *)error
{
    BOOL __block downloadResult = NO;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    if (account) {
        [mutableRequest addValue:[(B2Account *)account token]
              forHTTPHeaderField:@"Authorization"];
    }
    NSURLSessionDownloadTask *task = [[self session] downloadTaskWithRequest:mutableRequest
                                                           completionHandler:^(NSURL *location,
                                                                               NSURLResponse *response,
                                                                               NSError *requestError) {
                                                               if (!location && requestError) {
                                                                   if (error) {
                                                                       *error = requestError;
                                                                   }
                                                               } else if (location && response) {
                                                                   downloadResult = [[NSFileManager defaultManager] moveItemAtURL:(NSURL *)location
                                                                                                                            toURL:fileURL
                                                                                                                            error:error];
                                                               }
                                                               dispatch_semaphore_signal(semaphore);
                                                           }];
    B2LogDebug("Enqueuing download request: %@ for account: %@ to url: %@", mutableRequest, account, fileURL);
    [task resume];
    (void)dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    B2LogDebug("Finished download request: %d to url: %@ (error=%@)", downloadResult, fileURL, error ? *error : nil);
    return downloadResult;
}

- (NSData *)performUploadRequest:(NSMutableURLRequest *)mutableRequest
                         account:(B2Account *)account
                         fileURL:(NSURL *)fileURL
                           error:(out NSError *__autoreleasing *)error
{
    B2ClientDataResult __block *result;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSURLSessionTask *task = [[self session] uploadTaskWithRequest:mutableRequest
                                                          fromFile:fileURL
                                                 completionHandler:^(NSData *data,
                                                                     NSURLResponse *response,
                                                                     NSError *requestError) {
                                                     if (!data && requestError) {
                                                         if (error) {
                                                             *error = requestError;
                                                         }
                                                     } else if (data && response) {
                                                         result = [[B2ClientDataResult alloc] initWithData:(NSData *)data
                                                                                                  response:(NSHTTPURLResponse *)response];
                                                     }
                                                     dispatch_semaphore_signal(semaphore);
                                                 }];
    B2LogDebug("Enqueuing upload request: %@ for account: %@", mutableRequest, account);
    [task resume];
    (void)dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    B2LogDebug("Finished upload request: %@ (error=%@)", result, error ? *error : nil);
    return result && [result validate:error] ? [result data] : nil;
}

@end
