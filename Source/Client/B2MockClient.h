//
//  B2MockClient.h
//  B2KitTests
//
//  Created by Andreas Meingast on 27.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2Client.h"

@class B2Account;

NS_ASSUME_NONNULL_BEGIN

@interface B2MockClient : NSObject <B2Client>

@property (nullable, nonatomic, readonly) NSMutableArray<NSMutableURLRequest *> *requests;
@property (nullable, nonatomic, readonly) NSMutableArray<NSData *> *dataResponses;
@property (nullable, nonatomic, readwrite) NSError *error;
@property (nullable, nonatomic, readwrite) B2Account *account;
@property (nullable, nonatomic, readwrite) NSURL *fileURL;
@property (nonatomic) BOOL fileDownloadResponse;

- (void)addRequest:(NSMutableURLRequest *)request;
- (nullable NSMutableURLRequest *)nextRequest;
- (void)addDataResponse:(NSData *)dataResponse;
- (nullable NSData *)nextDataResponse;


@end

NS_ASSUME_NONNULL_END
