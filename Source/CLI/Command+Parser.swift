//
//  Command+Parser.swift
//  B2Kit
//
//  Created by Andreas Meingast on 30.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

import B2Kit

extension Command {
    static func parse(from arguments: [String]) -> Command {
        switch (arguments[safe: 1]) {
        case "listBuckets":
            return .listBuckets(bucketId: arguments[safe: 2],
                                bucketName: arguments[safe: 3],
                                bucketTypes: B2BucketTypeFromNSString(arguments[safe: 4] ?? "all"))
        case "createBucket":
            if (arguments.count < 3) { return .help }
            return .createBucket(bucketName: arguments[2],
                                 bucketType: B2BucketTypeFromNSString(arguments[safe: 3] ?? "allPrivate"),
                                 info: [:],
                                 lifeCycleRules: [])
        case "deleteBucket":
            if (arguments.count < 3) { return .help }
            return .deleteBucket(bucketId: arguments[2])
        case "updateBucket":
            if (arguments.count < 3) { return .help }
            return .updateBucket(bucketId: arguments[2],
                                 bucketType: B2BucketTypeFromNSString(arguments[safe: 3] ?? "none"),
                                 info: [:],
                                 lifeCycleRules: [])
        case "fileInfo":
            if (arguments.count < 3) { return .help }
            return .fileInfo(fileId: arguments[2])
        case "listFiles":
            if (arguments.count < 3) { return .help }
            return .listFiles(bucketId: arguments[2],
                              startFileName: arguments[safe: 3],
                              maxFileCount: arguments[safe: 4].flatMap({ Int($0) }).map({ NSNumber(integerLiteral: $0) }),
                              prefix: arguments[safe: 5])
        default:
            return .help;
        }
    }
}
