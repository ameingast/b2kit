//
//  Colors.swift
//  B2Kit
//
//  Created by Andreas Meingast on 30.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

import Foundation

internal enum Color: String {
    case normal = "\u{001B}[0;0m"
    case black = "\u{001B}[0;30m"
    case red = "\u{001B}[0;31m"
    case green = "\u{001B}[0;32m"
    case yellow = "\u{001B}[0;33m"
    case blue = "\u{001B}[0;34m"
    case magenta = "\u{001B}[0;35m"
    case cyan = "\u{001B}[0;36m"
    case white = "\u{001B}[0;37m"

    static var enabled = ProcessInfo.processInfo.environment["TERM"]?.contains("xterm") ?? false

    static func + (left: Color, right: String) -> String {
        return left.rawValue + right
    }

    static func + (left: String, right: Color) -> String {
        return left + right.rawValue
    }

    func colorize(_ string: String) -> String {
        return Color.enabled ?  self + string + .normal : string
    }
}
