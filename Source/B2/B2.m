//
//  B2.m
//  B2Kit
//
//  Created by Andreas Meingast on 04.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2.h"
#import "B2DefaultClient.h"
#import "B2AccountManager.h"
#import "B2BucketManager.h"
#import "B2FileManager.h"

@implementation B2

@synthesize client = _client;
@synthesize accountManager = _accountManager;
@synthesize bucketManager = _bucketManager;
@synthesize fileManager = _fileManager;

+ (B2 *)sharedInstance
{
    static B2 *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (B2 *)init
{
    self = [super init];
    if (self) {
        _client = [B2DefaultClient new];
        _accountManager = [B2AccountManager new];
        _bucketManager = [B2BucketManager new];
        _fileManager = [B2FileManager new];
    }
    return self;
}

/// MARK: Lifecycle

- (void)start
{

}

- (void)stop
{
    [[self fileManager] stop];
}

@end
