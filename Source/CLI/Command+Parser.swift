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
        switch (arguments[safe: 1]?.lowercased()) {
        case "listbuckets":
            return .listBuckets(bucketId: arguments[safe: 2],
                                bucketName: arguments[safe: 3],
                                bucketTypes: B2BucketTypeFromNSString(arguments[safe: 4] ?? "all"))
        case "createbucket":
            if (arguments.count < 3) { return .help }
            return .createBucket(bucketName: arguments[2],
                                 bucketType: B2BucketTypeFromNSString(arguments[safe: 3] ?? "allPrivate"),
                                 info: [:],
                                 lifeCycleRules: [])
        case "deletebucket":
            if (arguments.count < 3) { return .help }
            return .deleteBucket(bucketId: arguments[2])
        case "updatebucket":
            if (arguments.count < 3) { return .help }
            return .updateBucket(bucketId: arguments[2],
                                 bucketType: B2BucketTypeFromNSString(arguments[safe: 3] ?? "none"),
                                 info: [:],
                                 lifeCycleRules: [])
        case "fileinfo":
            if (arguments.count < 3) { return .help }
            return .fileInfo(fileId: arguments[2])
        case "listfiles":
            if (arguments.count < 3) { return .help }
            return .listFiles(bucketId: arguments[2],
                              startFileName: arguments[safe: 3],
                              maxFileCount: arguments[safe: 4].flatMap({ Int($0) }).map({ NSNumber(integerLiteral: $0) }),
                              prefix: arguments[safe: 5])
        case "deletefile":
            if (arguments.count < 3) { return .help }
            return .deleteFile(fileId: arguments[2],
                               fileName: arguments[3])
        case "uploadfile":
            if (arguments.count < 6) { return .help }
            return .uploadFile(fileName: arguments[2],
                               bucketId: arguments[3],
                               contentType: arguments[4],
                               location: arguments[5],
                               info: [:])
        default:
            return .help;
        }
    }
}
