//
//  Credentials.swift
//  B2Kit
//
//  Created by Andreas Meingast on 30.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

import B2Kit

internal struct Credentials: Equatable {
    static let ACCOUNT_ID = "B2_ACCOUNT_ID"
    static let APPLICATION_KEY = "B2_APPLICATION_KEY"

    let accountId: String
    let applicationKey: String

    static func from(environment: [String:String]) throws -> Credentials {
        guard let accountId = environment[ACCOUNT_ID], let applicationKey = environment[APPLICATION_KEY] else {
            throw "No credentials set in environment"
        }
        return Credentials(accountId: accountId, applicationKey: applicationKey)
    }

    func account() throws -> B2Account {
        return try B2.sharedInstance().authorizeAccount(withAccountId: accountId, applicationKey: applicationKey)
    }
}
