//
//  B2KitTestCase.m
//  B2KitTests
//
//  Created by Andreas Meingast on 05.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"

static const NSString *B2KitTestBucketNamePrefix = @"B2Kit";

@interface B2KitTestCase (Private)

- (void)cleanUp;
- (NSDictionary<NSString *, NSString *> *)secrets;
- (void)raiseTestException:(NSString *)message;

@end

@implementation B2KitTestCase

@synthesize b2 = _b2;
@synthesize client = _client;

- (NSString *)accountId
{
    NSString *accountId = [self secrets][@"ACCOUNT_ID"];
    if (!accountId) {
        [self raiseTestException:@"ACCOUNT_ID environment variable not set. Check 'Resources/Secrets.json'."];
    }
    return accountId;
}

- (NSString *)applicationKey
{
    NSString *applicationKey = [self secrets][@"APPLICATION_KEY"];
    if (!applicationKey) {
        [self raiseTestException:@"APPLICATION_KEY environment variable not set. Check 'Resources/Secrets.json'."];
    }
    return applicationKey;
}

- (void)setUp
{
    [super setUp];
    [self setB2:[B2 sharedInstance]];
    [self setClient:[B2MockClient new]];
    [[self b2] setLogLevel:B2LogLevelDebug];
    [self cleanUp];
}

- (void)tearDown
{
    [self cleanUp];
    [super tearDown];
}

- (NSURL *)randomDataURL
{
    return (NSURL *)[[NSBundle bundleForClass:[self class]] URLForResource:@"Blob"
                                                             withExtension:@"bin"];
}

- (NSURL *)alternativeRandomDataURL
{
    return (NSURL *)[[NSBundle bundleForClass:[self class]] URLForResource:@"Blib"
                                                             withExtension:@"bin"];
}

- (NSData *)randomData
{
    return (NSData *)[NSData dataWithContentsOfURL:[self randomDataURL]];
}

- (NSString *)randomDataSha1Checksum
{
    return @"93d6ac13d63ba22038ec9b827b8944ad0b44bd38";
}

- (NSString *)alternativeRandomDataSha1Checksum
{
    return @"10857559cd204a3a9ef6de53fac6ed84f3164cfd";
}

- (NSString *)randomBucketName
{
    return [NSString stringWithFormat:@"%@-%@", B2KitTestBucketNamePrefix, [[NSUUID UUID] UUIDString]];
}

- (NSURL *)targetURL
{
    NSURL *tempDirectory = [NSURL fileURLWithPath:NSTemporaryDirectory()
                                      isDirectory:true];
    return (NSURL *)[[tempDirectory URLByAppendingPathComponent:@"download"] URLByAppendingPathExtension:@"bin"];
}

- (void)addMockResponse:(NSDictionary<NSString *, id> *)responseData
{
    [[self client] addDataResponse:(NSData *)[NSJSONSerialization dataWithJSONObject:responseData
                                                                             options:0
                                                                               error:nil]];
}

- (void)verifyURLRequest:(NSURLRequest *)request
{
    NSMutableURLRequest *expectedRequest = [[self client] nextRequest];
    XCTAssertEqualObjects(request, expectedRequest);
    XCTAssertEqualObjects([expectedRequest HTTPBody], [request HTTPBody]);
}

@end

@implementation B2KitTestCase (Private)

- (void)cleanUp
{
    (void)[[NSFileManager defaultManager] removeItemAtURL:[self targetURL]
                                                    error:nil];
}

- (NSDictionary<NSString *, NSString *> *)secrets
{
    NSURL *url = [[NSBundle bundleForClass:[self class]]
                  URLForResource:@"Secrets"
                  withExtension:@"json"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDictionary<NSString *, NSString *> *result =  [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:0
                                                                                      error:nil];
    return result;
}

- (void)raiseTestException:(NSString *)message __attribute__((noreturn))
{
    @throw [NSException exceptionWithName:@"com.operationalsemantics.B2Kit.TestException"
                                   reason:message
                                 userInfo:@{}];
}

@end

@implementation NSMutableURLRequest (Private)

+ (NSMutableURLRequest *)requestWithURL:(NSURL *)URL
                             httpMethod:(NSString *)httpMethod
                               httpBody:(NSDictionary<NSString *, id> *)httpBody
                                headers:(NSDictionary<NSString *, NSString *> *)headers
{
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:URL];
    [mutableRequest setHTTPMethod:httpMethod];
    if (httpBody) {
        [mutableRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:httpBody
                                                                    options:NSJSONWritingPrettyPrinted
                                                                      error:nil]];
    }
    for (NSString *field in headers) {
        [mutableRequest addValue:(NSString *)headers[field]
              forHTTPHeaderField:field];
    }
    return mutableRequest;
}

@end
