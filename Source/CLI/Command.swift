//
//  Command.swift
//  B2Kit
//
//  Created by Andreas Meingast on 30.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

import B2Kit

internal enum Command: Equatable {
    var b2: B2 { return B2.sharedInstance() }

    // MARK: Commands
    case listBuckets(bucketId: String?, bucketName: String?, bucketTypes: B2BucketType)
    case createBucket(bucketName: String, bucketType: B2BucketType, info: [String:String], lifeCycleRules: [B2BucketLifeCycleRule])
    case deleteBucket(bucketId: String)
    case updateBucket(bucketId: String, bucketType: B2BucketType, info: [String:String], lifeCycleRules: [B2BucketLifeCycleRule])

    // MARK: Files
    case fileInfo(fileId: String)
    case listFiles(bucketId: String, startFileName: String?, maxFileCount: NSNumber?, prefix: String?)
    case deleteFile(fileId: String, fileName: String)
    case uploadFile(fileName: String, bucketId: String, contentType: String, location: String, info: [String:String])

    // MARK: Help
    case help

    static func == (lhs: Command, rhs: Command) -> Bool {
        switch (lhs, rhs) {
            case let (.listBuckets(lhsBucketId, lhsBucketName, lhsBucketTypes),
                      .listBuckets(rhsBucketId, rhsBucketName, rhsBucketTypes)):
                return lhsBucketId == rhsBucketId && lhsBucketName == rhsBucketName && lhsBucketTypes == rhsBucketTypes
            case let (.createBucket(lhsBucketName, lhsBucketType, lhsInfo, lhsLifeCycleRules),
                      .createBucket(rhsBucketName, rhsBucketType, rhsInfo, rhsLifeCycleRules)):
            return lhsBucketName == rhsBucketName && lhsBucketType == rhsBucketType && lhsInfo == rhsInfo && lhsLifeCycleRules == rhsLifeCycleRules
        case let (.deleteBucket(lhsBucketId), .deleteBucket(rhsBucketId)):
            return lhsBucketId == rhsBucketId
        case let (.updateBucket(lhsBucketName, lhsBucketType, lhsInfo, lhsLifeCycleRules),
                  .updateBucket(rhsBucketName, rhsBucketType, rhsInfo, rhsLifeCycleRules)):
            return lhsBucketName == rhsBucketName && lhsBucketType == rhsBucketType && lhsInfo == rhsInfo && lhsLifeCycleRules == rhsLifeCycleRules
        case let (.fileInfo(lhsFileInfo), .fileInfo(rhsFileInfo)):
            return lhsFileInfo == rhsFileInfo
        case let (.listFiles(lhsBucketId, lhsStartFileName, lhsMaxFileCount, lhsPrefix),
                  .listFiles(rhsBucketId, rhsStartFileName, rhsMaxFileCount, rhsPrefix)):
            return lhsBucketId == rhsBucketId && lhsStartFileName == rhsStartFileName && lhsMaxFileCount == rhsMaxFileCount && lhsPrefix == rhsPrefix
        case let (.deleteFile(lhsFileId, lhsFileName), .deleteFile(rhsFileId, rhsFileName)):
            return lhsFileId == rhsFileId && lhsFileName == rhsFileName
        case let (.uploadFile(lhsFileName, lhsBucketId, lhsContentType, lhsLocation, lhsInfo),
                  .uploadFile(rhsFileName, rhsBucketId, rhsContentType, rhsLocation, rhsInfo)):
            return lhsFileName == rhsFileName && lhsBucketId == rhsBucketId && lhsLocation == rhsLocation && lhsContentType == rhsContentType && lhsInfo == rhsInfo
        case (.help, .help):
            return true
        default:
            return false
        }
    }
}
