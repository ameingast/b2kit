//
//  B2FileManager.m
//  B2Kit
//
//  Created by Andreas Meingast on 08.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2Bucket.h"

#import "B2Account.h"
#import "B2DefaultClient.h"
#import "B2File.h"
#import "B2File+Private.h"
#import "B2FileManager.h"
#import "B2Endpoint.h"
#import "B2JSONValidator.h"
#import "B2UploadURL.h"
#import "B2UnfinishedLargeFiles.h"
#import "B2UnfinishedLargeFiles+Private.h"
#import "B2Parts.h"
#import "B2Parts+Private.h"
#import "B2Range.h"

@implementation B2FileManager

@synthesize client = _client;

- (B2FileManager *)initWithClient:(id<B2Client>)client
{
    self = [super init];
    if (self) {
        _client = client;
    }
    return self;
}

// MARK: Meta

- (B2File *)fileInfoForFileId:(NSString *)fileId
                      account:(B2Account *)account
                        error:(out NSError *__autoreleasing *)error
{
    NSData *payload = [NSJSONSerialization dataWithJSONObject:@{ @"fileId": fileId }
                                                      options:NSJSONWritingPrettyPrinted
                                                        error:error];
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:B2EndpointFileInfo([account apiURL])];
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest setHTTPBody:payload];
    NSData *response = [[self client] performDownloadRequest:mutableRequest
                                                     account:account
                                                       error:error];
    return !response ? nil : [[B2File alloc] initWithJSONData:response
                                                        error:error];
}

- (BOOL)hideFileWithFileName:(NSString *)fileName
                     account:(B2Account *)account
                      bucket:(B2Bucket *)bucket
                       error:(out NSError *__autoreleasing *)error
{
    NSData *payload = [NSJSONSerialization dataWithJSONObject:@{ @"fileName": fileName,
                                                                 @"bucketId": [bucket bucketId] }
                                                      options:NSJSONWritingPrettyPrinted
                                                        error:error];
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:B2EndpointHideFile([account apiURL])];
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest setHTTPBody:payload];
    NSData *response = [[self client] performDownloadRequest:mutableRequest
                                                     account:account
                                                       error:error];
    return response ? YES : NO;
}

- (NSArray<B2File *> *)listFilesWithBucketId:(NSString *)bucketId
                                     account:(B2Account *)account
                               startFileName:(NSString *)startFileName
                                maxFileCount:(NSNumber *)maxFileCount
                                      prefix:(NSString *)prefix
                                       error:(out NSError *__autoreleasing *)error
{
    NSData *payload = [NSJSONSerialization dataWithJSONObject:@{ @"bucketId": bucketId,
                                                                 @"maxFileCount": maxFileCount != nil ? (NSNumber *)maxFileCount : [NSNull new],
                                                                 @"startFileName": startFileName ? (NSString *)startFileName : [NSNull new],
                                                                 @"prefix" : prefix ? (NSString *)prefix : [NSNull new] }
                                                      options:NSJSONWritingPrettyPrinted
                                                        error:error];
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:B2EndpointListFiles([account apiURL])];
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest setHTTPBody:payload];
    NSData *response = [[self client] performDownloadRequest:mutableRequest
                                                     account:account
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
    BOOL validationResult = [[B2JSONValidator sharedInstance] validateJSON:json
                                                                    fields:@[@"files", @"nextFileName"]
                                                                     error:error];
    if (!validationResult) {
        return nil;
    }
    NSArray<B2File *> *files = [B2File filesFromArray:(NSArray<NSDictionary<NSString *, id> *> *)json[@"files"]
                                              account:account
                                             bucketId:bucketId
                                                error:error];
    return files;
}

// MARK: Delete

- (BOOL)deleteFileWithFileId:(NSString *)fileId
                    filename:(NSString *)filename
                     account:(B2Account *)account
                       error:(out NSError *__autoreleasing *)error
{
    NSData *payload = [NSJSONSerialization dataWithJSONObject:@{ @"fileName": filename,
                                                                 @"fileId": fileId }
                                                      options:NSJSONWritingPrettyPrinted
                                                        error:error];
    if (!payload) {
        return NO;
    }
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:B2EndpointDeleteFileVersion([account apiURL])];
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest setHTTPBody:payload];
    NSData *response = [[self client] performDownloadRequest:mutableRequest
                                                     account:account
                                                       error:error];
    if (!response) {
        return NO;
    }
    NSDictionary<NSString *, id> *json = [NSJSONSerialization JSONObjectWithData:response
                                                                         options:0
                                                                           error:error];
    if (!json) {
        return NO;
    }
    BOOL validationResult = [[B2JSONValidator sharedInstance] validateJSON:json
                                                                    fields:@[@"fileId", @"fileName"]
                                                                     error:error];
    return validationResult;
}

// MARK: Upload

- (B2UploadURL *)uploadURLForBucketWithBucketId:(NSString *)bucketId
                                        account:(B2Account *)account
                                          error:(out NSError *__autoreleasing *)error
{
    NSData *payload = [NSJSONSerialization dataWithJSONObject:@{ @"bucketId": bucketId }
                                                      options:NSJSONWritingPrettyPrinted
                                                        error:error];
    if (!payload) {
        return nil;
    }
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:B2EndpointGetUploadUrl([account apiURL])];
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest setHTTPBody:payload];
    NSData *response = [[self client] performDownloadRequest:mutableRequest
                                                     account:account
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
    BOOL validationResult = [[B2JSONValidator sharedInstance] validateJSON:json
                                                                    fields:@[@"uploadUrl", @"authorizationToken"]
                                                                     error:error];
    if (!validationResult) {
        return nil;
    }
    B2UploadURL *uploadURL =  [[B2UploadURL alloc] initWithURL:(NSURL *)[NSURL URLWithString:(NSString *)json[@"uploadUrl"]]
                                            authorizationToken:(NSString *)json[@"authorizationToken"]];
    return uploadURL;
}

- (B2File *)uploadFileAtURL:(NSURL *)localFileURL
                    account:(B2Account *)account
                   fileName:(NSString *)filename
               sha1Checksum:(NSString *)sha1Checksum
                 intoBucket:(NSString *)bucketId
                contentType:(NSString *)contentType
             lastModifiedOn:(NSUInteger)lastModifiedOn
                   fileInfo:(NSDictionary<NSString *, NSString *> *)fileInfo
                      error:(out NSError *__autoreleasing *)error
{
    B2UploadURL *uploadURL = [self uploadURLForBucketWithBucketId:bucketId
                                                          account:account
                                                            error:error];
    if (!uploadURL) {
        return nil;
    }
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:[uploadURL url]];
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest addValue:[uploadURL authorizationToken]
          forHTTPHeaderField:@"Authorization"];
    [mutableRequest addValue:filename
          forHTTPHeaderField:@"X-Bz-File-Name"];
    [mutableRequest addValue:contentType
          forHTTPHeaderField:@"Content-Type"];
    [mutableRequest addValue:sha1Checksum
          forHTTPHeaderField:@"X-Bz-Content-Sha1"];
    if (lastModifiedOn != 0) {
        [mutableRequest addValue:[NSString stringWithFormat:@"%lu", (unsigned long)lastModifiedOn]
              forHTTPHeaderField:@"X-Bz-Info-src_last_modified_millis"];
    }
    if (fileInfo) {
        for (NSString *key in fileInfo) {
            [mutableRequest addValue:(NSString *)fileInfo[key]
                  forHTTPHeaderField:[NSString stringWithFormat:@"X-Bz-Info-%@", key]];
        }
    }
    NSData *result = [[self client] performUploadRequest:mutableRequest
                                                 account:account
                                                 fileURL:localFileURL
                                                   error:error];
    return !result ? nil : [[B2File alloc] initWithJSONData:result
                                                      error:error];
}


// MARK: Download

- (BOOL)downloadFileWithFileId:(NSString *)fileId
                       account:(B2Account *)account
                         range:(B2Range *)range
                   locationURL:(NSURL *)locationURL
                         error:(out NSError *__autoreleasing *)error
{
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:B2EndpointDownloadFileById([account apiURL])
                                                resolvingAgainstBaseURL:NO];
    [urlComponents setQuery:[NSString stringWithFormat:@"fileId=%@", fileId]];
    NSURL *requestURL = [urlComponents URL];
    if (!requestURL) {
        return NO;
    }
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:requestURL];
    [mutableRequest setHTTPMethod:@"GET"];
    [mutableRequest addValue:[NSString stringWithFormat:@"bytes=%@-%@", [range start], [range end]]
          forHTTPHeaderField:@"Range"];
    BOOL response = [[self client] performDownloadRequest:mutableRequest
                                                  account:account
                                                  fileURL:locationURL
                                                    error:error];
    return response;
}


- (BOOL)downloadFileWithFileName:(NSString *)fileName
                      bucketName:(NSString *)bucketName
                         account:(B2Account *)account
                           range:(B2Range *)range
                     locationURL:(NSURL *)locationURL
                           error:(out NSError *__autoreleasing *)error
{
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:B2EndpointDownloadFileByName([account downloadURL],
                                                                                                           bucketName,
                                                                                                           fileName)];
    [mutableRequest setHTTPMethod:@"GET"];
    [mutableRequest addValue:[NSString stringWithFormat:@"bytes=%@-%@", [range start], [range end]]
          forHTTPHeaderField:@"Range"];
    BOOL response = [[self client] performDownloadRequest:mutableRequest
                                                  account:account
                                                  fileURL:locationURL
                                                    error:error];
    return response;
}

// MARK: Large Files

- (B2UploadURL *)uploadPartURLForFileId:(NSString *)fileId
                                account:(B2Account *)account
                                  error:(out NSError *__autoreleasing *)error
{
    NSData *payload = [NSJSONSerialization dataWithJSONObject:@{ @"fileId": fileId }
                                                      options:NSJSONWritingPrettyPrinted
                                                        error:error];
    if (!payload) {
        return nil;
    }
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:B2EndpointGetUploadPartURL([account apiURL])];
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest setHTTPBody:payload];
    NSData *response = [[self client] performDownloadRequest:mutableRequest
                                                     account:account
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
    BOOL validationResult = [[B2JSONValidator sharedInstance] validateJSON:json
                                                                    fields:@[@"uploadUrl", @"authorizationToken"]
                                                                     error:error];
    if (!validationResult) {
        return nil;
    }
    B2UploadURL *uploadURL = [[B2UploadURL alloc] initWithURL:(NSURL *)[NSURL URLWithString:(NSString *)json[@"uploadUrl"]]
                                           authorizationToken:(NSString *)json[@"authorizationToken"]];
    return uploadURL;
}

- (NSString *)startUploadForFileName:(NSString *)filename
                             account:(B2Account *)account
                            bucketId:(NSString *)bucketId
                         contentType:(NSString *)contentType
                            fileInfo:(NSDictionary<NSString *, NSString *> *)fileInfo
                               error:(out NSError *__autoreleasing *)error
{
    NSData *payload = [NSJSONSerialization dataWithJSONObject:@{ @"fileName": filename,
                                                                 @"bucketId": bucketId,
                                                                 @"contentType": contentType,
                                                                 @"fileInfo": fileInfo ? (NSDictionary<NSString *, NSString *> *)fileInfo : [NSNull new] }
                                                      options:NSJSONWritingPrettyPrinted
                                                        error:error];
    if (!payload) {
        return nil;
    }
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:B2EndpointStartLargeFile([account apiURL])];
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest setHTTPBody:payload];
    NSData *response = [[self client] performDownloadRequest:mutableRequest
                                                     account:account
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
    BOOL validationResult = [[B2JSONValidator sharedInstance] validateJSON:json
                                                                    fields:@[ @"fileId" ]
                                                                     error:error];
    if (!validationResult) {
        return nil;
    }
    return json[@"fileId"];
}

- (BOOL)cancelUploadForFileId:(NSString *)fileId
                      account:(B2Account *)account
                        error:(out NSError *__autoreleasing *)error
{
    NSData *payload = [NSJSONSerialization dataWithJSONObject:@{ @"fileId": fileId }
                                                      options:NSJSONWritingPrettyPrinted
                                                        error:error];
    if (!payload) {
        return NO;
    }
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:B2EndpointCancelLargeFile([account apiURL])];
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest setHTTPBody:payload];
    NSData *response = [[self client] performDownloadRequest:mutableRequest
                                                     account:account
                                                       error:error];
    if (!response) {
        return NO;
    }
    NSDictionary<NSString *, id> *json = [NSJSONSerialization JSONObjectWithData:response
                                                                         options:0
                                                                           error:error];
    if (!json) {
        return NO;
    }
    BOOL validationResult = [[B2JSONValidator sharedInstance] validateJSON:json
                                                                    fields:@[ @"fileId",
                                                                              @"accountId",
                                                                              @"bucketId",
                                                                              @"fileName" ]
                                                                     error:error];
    return validationResult;
}

- (BOOL)finishUploadForFileId:(NSString *)fileId
                      account:(B2Account *)account
         contentSha1Checksums:(NSArray<NSString *> *)contentSha1Checksums
                        error:(out NSError *__autoreleasing *)error
{
    NSData *payload = [NSJSONSerialization dataWithJSONObject:@{ @"fileId": fileId,
                                                                 @"partSha1Array": contentSha1Checksums }
                                                      options:NSJSONWritingPrettyPrinted
                                                        error:error];
    if (!payload) {
        return NO;
    }
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:B2EndpointFinishLargeFile([account apiURL])];
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest setHTTPBody:payload];
    NSData *response = [[self client] performDownloadRequest:mutableRequest
                                                     account:account
                                                       error:error];
    return response ? YES : NO;
}

- (BOOL)uploadPartForFileId:(NSString *)fileId
                    account:(B2Account *)account
               dataLocation:(NSURL *)dataLocation
                 partNumber:(NSNumber *)partNumber
              contentLength:(NSNumber *)contentLength
        contentSha1Checksum:(NSString *)contentSha1Checksum
                      error:(out NSError *__autoreleasing *)error
{
    B2UploadURL *uploadURL = [self uploadPartURLForFileId:fileId
                                                  account:account
                                                    error:error];
    if (!uploadURL) {
        return NO;
    }
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:[uploadURL url]];
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest addValue:[uploadURL authorizationToken]
          forHTTPHeaderField:@"Authorization"];
    [mutableRequest addValue:[NSString stringWithFormat:@"%@", partNumber]
          forHTTPHeaderField:@"X-Bz-Part-Number"];
    [mutableRequest addValue:[NSString stringWithFormat:@"%@", contentLength]
          forHTTPHeaderField:@"Content-Length"];
    [mutableRequest addValue:contentSha1Checksum
          forHTTPHeaderField:@"X-Bz-Content-Sha1"];
    NSData *response = [[self client] performUploadRequest:mutableRequest
                                                   account:account
                                                   fileURL:dataLocation
                                                     error:error];
    return response ? YES : NO;
}

- (B2UnfinishedLargeFiles *)listUnfinishedFilesForBucketId:(NSString *)bucketId
                                                   account:(B2Account *)account
                                               startFileId:(NSString *)startFileId
                                              maxFileCount:(NSNumber *)maxFileCount
                                                     error:(out NSError *__autoreleasing *)error
{
    NSData *payload = [NSJSONSerialization dataWithJSONObject:@{ @"bucketId": bucketId,
                                                                 @"startFileId": startFileId ? (NSString *)startFileId : [NSNull new],
                                                                 @"maxFileCount": maxFileCount != nil ? (NSNumber *)maxFileCount : [NSNull new] }
                                                      options:NSJSONWritingPrettyPrinted
                                                        error:error];
    if (!payload) {
        return nil;
    }
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:B2EndpointListUnfinishedLargeFiles([account apiURL])];
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest setHTTPBody:payload];
    NSData *response = [[self client] performDownloadRequest:mutableRequest
                                                     account:account
                                                       error:error];
    return response ? [[B2UnfinishedLargeFiles alloc] initWithJSONData:response
                                                                 error:error] : nil;
}

- (B2Parts *)listPartsForFileId:(NSString *)fileId
                        account:(B2Account *)account
                startPartNumber:(NSNumber *)startPartNumber
                   maxPartCount:(NSNumber *)maxPartCount
                          error:(out NSError *__autoreleasing *)error
{
    NSData *payload = [NSJSONSerialization dataWithJSONObject:@{ @"fileId": fileId,
                                                                 @"startPartNumber" : startPartNumber != nil ? (NSNumber *)startPartNumber : [NSNull new],
                                                                 @"maxPartCount" : maxPartCount != nil ? (NSNumber *)maxPartCount : [NSNull new] }
                                                      options:NSJSONWritingPrettyPrinted
                                                        error:error];
    if (!payload) {
        return nil;
    }
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:B2EndpointListParts([account apiURL])];
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest setHTTPBody:payload];
    NSData *response = [[self client] performDownloadRequest:mutableRequest
                                                     account:account
                                                       error:error];
    return response ? [[B2Parts alloc] initWithJSONData:response
                                                  error:error]: nil;
}

@end
