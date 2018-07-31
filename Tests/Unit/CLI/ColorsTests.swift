//
//  ColorsTests.swift
//  B2Kit
//
//  Created by Andreas Meingast on 30.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

import XCTest

internal final class ColorsTests: XCTestCase {
    override func setUp() {
        super.setUp()
        Color.enabled = true
    }

    func testPlus() {
        XCTAssertEqual("\u{001B}[0;31m", "" + Color.red)
        XCTAssertEqual("\u{001B}[0;31m", Color.red + "")
    }

    func testColors() {
        XCTAssertEqual("\u{001B}[0;0m", "" + .normal)
        XCTAssertEqual("\u{001B}[0;30m", "" + .black)
        XCTAssertEqual("\u{001B}[0;31m", "" + .red)
        XCTAssertEqual("\u{001B}[0;32m", "" + .green)
        XCTAssertEqual("\u{001B}[0;33m", "" + .yellow)
        XCTAssertEqual("\u{001B}[0;34m", "" + .blue)
        XCTAssertEqual("\u{001B}[0;35m", "" + .magenta)
        XCTAssertEqual("\u{001B}[0;36m", "" + .cyan)
        XCTAssertEqual("\u{001B}[0;37m", "" + .white)
    }

    func testColorize() {
        XCTAssertEqual("\u{001B}[0;37mA\u{001B}[0;0m", Color.white.colorize("A"))
    }
}
