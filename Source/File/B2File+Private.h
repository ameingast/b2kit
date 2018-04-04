//
//  B2File+Private.h
//  B2Kit
//
//  Created by Andreas Meingast on 14.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2File.h"

@interface B2File (Private)

+ (nullable NSArray<B2File *> *)filesFromArray:(NSArray<NSDictionary<NSString *, id> *> *)array
                                       account:(B2Account *)account
                                      bucketId:(NSString *)bucketId
                                         error:(out NSError **)error;

- (nullable B2File *)initWithJSONData:(NSData *)data
                                error:(out NSError **)error;

@end
