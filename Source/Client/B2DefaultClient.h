//
//  B2DefaultClient.h
//  B2Kit
//
//  Created by Andreas Meingast on 26.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

@import Foundation;

#import "B2Client.h"

NS_ASSUME_NONNULL_BEGIN

@interface B2DefaultClient : NSObject<B2Client>

@property (nonatomic, readonly, nonnull) NSURLSession *session;

+ (id<B2Client>)sharedInstance;

@end

NS_ASSUME_NONNULL_END
