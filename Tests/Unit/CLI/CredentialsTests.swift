//
//  CredentialsTests.swift
//  B2Kit
//
//  Created by Andreas Meingast on 30.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

import XCTest
import B2Kit

internal final class CredentialsTests: XCTestCase {
    func testFromEnvironment() throws {
        let credentials = try Credentials.from(environment: ["B2_ACCOUNT_ID": "accountId",
                                                             "B2_APPLICATION_KEY": "applicationKey"])
        XCTAssertEqual(Credentials(accountId: "accountId", applicationKey: "applicationKey"), credentials)
    }
}
