//
//  B2+Accounts.m
//  B2Kit
//
//  Created by Andreas Meingast on 05.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2.h"
#import "B2AccountManager.h"

@implementation B2 (Accounts)

- (B2Account *)authorizeAccountWithAccountId:(NSString *)accountId
                              applicationKey:(NSString *)applicationKey
                                       error:(out NSError *__autoreleasing *)error
{
    return [[[self accountManager] initWithClient:[self client]] authorizeAccountWithAccountId:accountId
                                                                                applicationKey:applicationKey
                                                                                         error:error];
}

@end
