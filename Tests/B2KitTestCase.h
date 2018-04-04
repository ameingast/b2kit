//
//  B2KitTestCase.h
//  B2Kit
//
//  Created by Andreas Meingast on 05.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

@import B2Kit;
@import XCTest;

#import "B2MockClient.h"

NS_ASSUME_NONNULL_BEGIN

@interface B2KitTestCase : XCTestCase

@property (nonatomic) B2 *b2;
@property (nonatomic) B2MockClient *client;

- (NSString *)accountId;
- (NSString *)applicationKey;
- (NSURL *)randomDataURL;
- (NSURL *)alternativeRandomDataURL;
- (NSData *)randomData;
- (NSString *)randomDataSha1Checksum;
- (NSString *)alternativeRandomDataSha1Checksum;
- (NSString *)randomBucketName;
- (NSURL *)targetURL;
- (void)addMockResponse:(NSDictionary<NSString *, id> *)responseData;
- (void)verifyURLRequest:(NSURLRequest *)request;

@end

@interface NSMutableURLRequest (Private)

+ (NSMutableURLRequest *)requestWithURL:(NSURL *)URL
                             httpMethod:(NSString *)httpMethod
                               httpBody:(nullable NSDictionary<NSString *, id> *)httpBody
                                headers:(NSDictionary<NSString *, NSString *> *)headers;

@end

NS_ASSUME_NONNULL_END
