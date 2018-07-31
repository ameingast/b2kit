//
//  Categories.swift
//  B2Kit
//
//  Created by Andreas Meingast on 30.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

import Foundation

internal extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

internal extension String {
    func colorized(with color: Color) -> String {
        return color.colorize(self)
    }
}

extension String: Error, LocalizedError {
    public var errorDescription: String? { return self }
}
