//
//  B2Endpoints.h
//  B2Kit
//
//  Created by Andreas Meingast on 05.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

NSURL *B2EndpointAuthorizeAccountURL(void);
NSURL *B2EndpointCreateBucketURL(NSURL *baseURL);
NSURL *B2EndpointListBucketsURL(NSURL *baseURL);
NSURL *B2EndpointDeleteBucketURL(NSURL *baseURL);
NSURL *B2EndpointUpdateBucketURL(NSURL *baseURL);
NSURL *B2EndpointGetUploadUrl(NSURL *baseURL);
NSURL *B2EndpointDeleteFileVersion(NSURL *baseURL);
NSURL *B2EndpointListFileNames(NSURL *baseURL);
NSURL *B2EndpointListFileVersions(NSURL *baseURL);
NSURL *B2EndpointDownloadFileById(NSURL *baseURL);
NSURL *B2EndpointDownloadFileByName(NSURL *baseURL, NSString *bucketName, NSString *filename);
NSURL *B2EndpointFileInfo(NSURL *baseURL);
NSURL *B2EndpointHideFile(NSURL *baseURL);
NSURL *B2EndpointGetUploadPartURL(NSURL *baseURL);
NSURL *B2EndpointStartLargeFile(NSURL *baseURL);
NSURL *B2EndpointCancelLargeFile(NSURL *baseURL);
NSURL *B2EndpointFinishLargeFile(NSURL *baseURL);
NSURL *B2EndpointListUnfinishedLargeFiles(NSURL *baseURL);
NSURL *B2EndpointListParts(NSURL *baseURL);

NS_ASSUME_NONNULL_END
