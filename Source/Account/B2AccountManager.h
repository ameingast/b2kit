//
//  B2AccountManager.h
//  B2Kit
//
//  Created by Andreas Meingast on 07.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import <Foundation/Foundation.h>

@class B2Account;
@protocol B2Client;

NS_ASSUME_NONNULL_BEGIN

@interface B2AccountManager : NSObject

@property (readonly, nonatomic) id<B2Client> client;

- (B2AccountManager *)initWithClient:(id<B2Client>)client;
- (nullable B2Account *)authorizeAccountWithAccountId:(NSString *)accountId
                                       applicationKey:(NSString *)applicationKey
                                                error:(out NSError **)error;

@end

NS_ASSUME_NONNULL_END
