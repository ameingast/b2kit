//
//  CommandTests.swift
//  B2Kit
//
//  Created by Andreas Meingast on 30.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

import B2Kit
import XCTest

internal final class CommandTests: XCTestCase {
    func testParseListBuckets() {
        XCTAssertEqual(Command.listBuckets(bucketId: "bucketId", bucketName: "bucketName", bucketTypes: .allPrivate),
                       Command.parse(from: ["", "listBuckets", "bucketId", "bucketName", "allPrivate"]))
    }
    
    func testParseCreateBucket() {
        XCTAssertEqual(Command.createBucket(bucketName: "bucketName", bucketType: .allPrivate, info: [:], lifeCycleRules: []),
                       Command.parse(from: ["", "createBucket", "bucketName", "allPrivate"]))
    }
    
    func testParseDeleteBucket() {
        XCTAssertEqual(Command.deleteBucket(bucketId: "bucketId"),
                       Command.parse(from: ["", "deleteBucket", "bucketId"]))
    }
    
    func testParseUpdateBucket() {
        XCTAssertEqual(Command.updateBucket(bucketId: "bucketId", bucketType: .allPrivate, info: [:], lifeCycleRules: []),
                       Command.parse(from: ["", "updateBucket", "bucketId", "allPrivate"]))
    }
    
    func testParseFileInfo() {
        XCTAssertEqual(Command.fileInfo(fileId: "fileId"),
                       Command.parse(from: ["", "fileInfo", "fileId"]))
    }
    
    func testParseListFiles() {
        XCTAssertEqual(Command.listFiles(bucketId: "bucketId", startFileName: "startFileName", maxFileCount: NSNumber(integerLiteral: 1), prefix: "prefix"),
                       Command.parse(from: ["", "listFiles", "bucketId", "startFileName", "1", "prefix"]))
    }
    
    func testParseDeleteFile() {
        XCTAssertEqual(Command.deleteFile(fileId: "fileId", fileName: "fileName"),
                       Command.parse(from: ["", "deleteFile", "fileId", "fileName"]))
    }
    
    func testParseUploadFile() {
        XCTAssertEqual(Command.uploadFile(fileName: "fileName", bucketId: "bucketId", contentType: "contentType", location: "location", info: [:]),
                       Command.parse(from: ["", "uploadFile", "fileName", "bucketId", "contentType", "location"]))
    }
    
    func testParseNoMatch() {
        XCTAssertEqual(Command.help, Command.parse(from: [""]))
    }
}
