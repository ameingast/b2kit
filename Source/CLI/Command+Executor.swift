//
//  Command+Executor.swift
//  B2Kit
//
//  Created by Andreas Meingast on 30.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

import B2Kit

extension Command {
    func execute(with credentials: Credentials) throws {
        switch (self) {
        case .listBuckets(let bucketId, let bucketName, let bucketTypes):
            let buckets = try b2.listBuckets(for: credentials.account(),
                                             bucketId: bucketId,
                                             bucketName: bucketName,
                                             bucketTypes: bucketTypes)
            print("\(buckets)")
        case .createBucket(let bucketName, let bucketType, let info, let lifeCycleRules):
            let bucket = try b2.createBucket(withBucketName: bucketName,
                                             account: credentials.account(),
                                             bucketType: bucketType,
                                             info: info,
                                             lifeCycleRules: lifeCycleRules)
            print("Created \(bucket)")
        case .deleteBucket(let bucketId):
            let bucket = try b2.deleteBucket(withBucketId: bucketId,
                                             account: credentials.account())
            print("Deleted \(bucket)")
        case .updateBucket(let bucketId, let bucketType, let info, let lifeCycleRules):
            let bucket = try b2.updateBucket(withBucketId: bucketId,
                                             account: credentials.account(),
                                             bucketType: bucketType,
                                             info: info,
                                             lifeCycleRules: lifeCycleRules)
            print("Updated \(bucket)")
        case .fileInfo(let fileId):
            let file = try b2.fileInfo(forFileId: fileId,
                                       account: credentials.account())
            print("File \(file)")
        case .listFiles(let bucketId, let startFileName, let maxFileCount, let prefix):
            let files = try b2.listFiles(withBucketId: bucketId,
                                         account: credentials.account(),
                                         startFileName: startFileName,
                                         maxFileCount: maxFileCount,
                                         prefix: prefix)
            print("Files \(files)")
        case let (.deleteFile(fileId, fileName)):
            try b2.deleteFile(withFileId: fileId,
                              fileName: fileName,
                              account: credentials.account())
            print("Deleted \(fileId)/\(fileName)")
        case .help:
            print("Usage: \(CommandLine.arguments[0]) <command> [arguments...]")
            print("Environment Variables")
            print(" * B2_ACCOUNT_ID")
            print(" * B2_APPLICATION_KEY")
            print("Bucket Commands")
            print(" * \("listBuckets".colorized(with: .green))\t<bucketId?> <bucketName?> <bucketType?>")
            print(" * \("createBucket".colorized(with: .green))\t<bucketName> <bucketType?>")
            print(" * \("deleteBucket".colorized(with: .green))\t<bucketId>")
            print(" * \("updateBucket".colorized(with: .green))\t<bucketId> <bucketType?>")
            print("File Commands")
            print(" * \("fileInfo".colorized(with: .green))\t<fileId>")
            print(" * \("listFiles".colorized(with: .green))\t<bucketId> <startFileName?> <maxFileCount?> <prefix?>")
            print(" * \("deleteFile".colorized(with: .green))\t<fileId> <fileName>")
        }
    }
}
