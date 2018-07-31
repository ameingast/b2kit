//
//  CategoriesTests.swift
//  B2Kit
//
//  Created by Andreas Meingast on 30.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

import XCTest

internal final class CategoriesTests: XCTestCase {
    func testArraySafeSubscript() {
        XCTAssertNil([][safe: 1])
        XCTAssertEqual(0, [0][safe: 0])
    }

    func testStringColorized() {
        Color.enabled = true
        XCTAssertNotEqual("", "".colorized(with: .red))
    }
}
