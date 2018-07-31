//
//  main.swift
//  B2Kit
//
//  Created by Andreas Meingast on 30.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

import Foundation

do {
    try Command.parse(from: CommandLine.arguments).execute(with: Credentials.from(environment: ProcessInfo.processInfo.environment))
} catch let error as NSError {
    print("\("Error".colorized(with: .red)): \(error.localizedDescription)")
}
