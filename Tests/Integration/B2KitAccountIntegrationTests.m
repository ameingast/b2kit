//
//  B2KitAccountIntegrationTests.m
//  B2KitIntegrationTests
//
//  Created by Andreas Meingast on 05.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2KitTestCase.h"

@interface B2KitAccountIntegrationTests : B2KitTestCase

@end

@implementation B2KitAccountIntegrationTests

- (void)testAccounts
{
    NSError *error;
    B2Account *account = [[self b2] authorizeAccountWithAccountId:[self accountId]
                                                   applicationKey:[self applicationKey]
                                                            error:&error];
    if (!account) {
        XCTFail(@"Authorization failed: %@", error);
        return;
    }
}

@end
