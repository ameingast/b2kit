//
//  B2MockClient.m
//  B2KitTests
//
//  Created by Andreas Meingast on 27.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2MockClient.h"

@implementation B2MockClient

@synthesize requests = _requests;
@synthesize error = _error;
@synthesize account = _account;
@synthesize dataResponses = _dataResponses;
@synthesize fileDownloadResponse = _fileDownloadResponse;
@synthesize fileURL = _fileURL;

- (B2MockClient *)init
{
    self = [super init];
    if (self) {
        _requests = [NSMutableArray new];
        _dataResponses = [NSMutableArray new];
    }
    return self;
}

- (void)addRequest:(NSMutableURLRequest *)request
{
    [[self requests] addObject:request];
}

- (NSMutableURLRequest *)nextRequest
{
    NSMutableURLRequest *request = [[self requests] firstObject];
    if (!request) {
        return nil;
    }
    [[self requests] removeObjectAtIndex:0];
    return request;
}

- (void)addDataResponse:(NSData *)dataResponse
{
    [[self dataResponses] addObject:dataResponse];
}

- (NSData *)nextDataResponse
{
    NSData *response = [[self dataResponses] firstObject];
    if (!response) {
        return nil;
    }
    [[self dataResponses] removeObjectAtIndex:0];
    return response;
}

// MARK: B2Client

- (NSData *)performDownloadRequest:(NSMutableURLRequest *)request
                           account:(B2Account *)account
                             error:(out NSError * __autoreleasing *)error {
    [[self requests] addObject:request];
    [self setAccount:account];
    if ([self error] && error) {
        *error = [self error];
    }
    return [self nextDataResponse];
}

- (BOOL)performDownloadRequest:(NSMutableURLRequest *)request
                       account:(B2Account *)account
                       fileURL:(NSURL *)fileURL
                         error:(out NSError *__autoreleasing *)error
{
    [[self requests] addObject:request];
    [self setAccount:account];
    [self setFileURL:fileURL];
    if ([self error] && error) {
        *error = [self error];
    }
    return [self fileDownloadResponse];
}

- (NSData *)performUploadRequest:(NSMutableURLRequest *)request
                         account:(B2Account *)account
                         fileURL:(NSURL *)fileURL
                           error:(out NSError * __autoreleasing *)error {
    [[self requests] addObject:request];
    [self setAccount:account];
    [self setFileURL:fileURL];
    if ([self error] && error) {
        *error = [self error];
    }
    return [self nextDataResponse];
}

@end
