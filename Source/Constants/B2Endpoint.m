//
//  B2Endpoint.m
//  B2Kit
//
//  Created by Andreas Meingast on 06.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2Endpoint.h"

inline NSURL *B2EndpointAuthorizeAccountURL(void) {
    return (NSURL *)[NSURL URLWithString:@"https://api.backblazeb2.com/b2api/v1/b2_authorize_account"];
}

inline NSURL *B2EndpointCreateBucketURL(NSURL *baseURL) {
    return (NSURL *)[baseURL URLByAppendingPathComponent:@"/b2api/v1/b2_create_bucket"];
}

inline NSURL *B2EndpointListBucketsURL(NSURL *baseURL) {
    return (NSURL *)[baseURL URLByAppendingPathComponent:@"/b2api/v1/b2_list_buckets"];
}

inline NSURL *B2EndpointDeleteBucketURL(NSURL *baseURL) {
    return (NSURL *)[baseURL URLByAppendingPathComponent:@"/b2api/v1/b2_delete_bucket"];
}

inline NSURL *B2EndpointUpdateBucketURL(NSURL *baseURL) {
    return (NSURL *)[baseURL URLByAppendingPathComponent:@"/b2api/v1/b2_update_bucket"];
}

inline NSURL *B2EndpointGetUploadUrl(NSURL *baseURL) {
    return (NSURL *)[baseURL URLByAppendingPathComponent:@"/b2api/v1/b2_get_upload_url"];
}

inline NSURL *B2EndpointDeleteFileVersion(NSURL *baseURL) {
    return (NSURL *)[baseURL URLByAppendingPathComponent:@"/b2api/v1/b2_delete_file_version"];
}

inline NSURL *B2EndpointListFileNames(NSURL *baseURL) {
    return (NSURL *)[baseURL URLByAppendingPathComponent:@"/b2api/v1/b2_list_file_names"];
}

inline NSURL *B2EndpointListFileVersions(NSURL *baseURL) {
    return (NSURL *)[baseURL URLByAppendingPathComponent:@"/b2api/v1/b2_list_file_versions"];
}

inline NSURL *B2EndpointDownloadFileById(NSURL *baseURL) {
    return (NSURL *)[baseURL URLByAppendingPathComponent:@"/b2api/v1/b2_download_file_by_id"];
}

inline NSURL *B2EndpointDownloadFileByName(NSURL *baseURL, NSString *bucketName, NSString *filename) {
    return (NSURL *)[[[baseURL URLByAppendingPathComponent:@"/file"] URLByAppendingPathComponent:bucketName] URLByAppendingPathComponent:filename];
}

inline NSURL *B2EndpointFileInfo(NSURL *baseURL) {
    return (NSURL *)[baseURL URLByAppendingPathComponent:@"/b2api/v1/b2_get_file_info"];
}

inline NSURL *B2EndpointHideFile(NSURL *baseURL) {
    return (NSURL *)[baseURL URLByAppendingPathComponent:@"/b2api/v1/b2_hide_file"];
}

inline NSURL *B2EndpointGetUploadPartURL(NSURL *baseURL) {
    return (NSURL *)[baseURL URLByAppendingPathComponent:@"/b2api/v1/b2_get_upload_part_url"];
}

inline NSURL *B2EndpointStartLargeFile(NSURL *baseURL) {
    return (NSURL *)[baseURL URLByAppendingPathComponent:@"/b2api/v1/b2_start_large_file"];
}

inline NSURL *B2EndpointCancelLargeFile(NSURL *baseURL) {
    return (NSURL *)[baseURL URLByAppendingPathComponent:@"/b2api/v1/b2_cancel_large_file"];
}

inline NSURL *B2EndpointFinishLargeFile(NSURL *baseURL) {
    return (NSURL *)[baseURL URLByAppendingPathComponent:@"/b2api/v1/b2_finish_large_file"];
}

inline NSURL *B2EndpointListUnfinishedLargeFiles(NSURL *baseURL) {
    return (NSURL *)[baseURL URLByAppendingPathComponent:@"/b2api/v1/b2_list_unfinished_large_files"];
}

inline NSURL *B2EndpointListParts(NSURL *baseURL) {
    return (NSURL *)[baseURL URLByAppendingPathComponent:@"/b2api/v1/b2_list_parts"];
}

