//
//  B2Parts+Private.h
//  B2Kit
//
//  Created by Andreas Meingast on 14.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2Parts.h"

@interface B2Part (Private)

- (nullable B2Part *)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
                                  error:(out NSError **)error;

@end

@interface B2Parts (Private)

- (nullable B2Parts *)initWithJSONData:(NSData *)data
                                 error:(out NSError **)error;
- (nullable B2Parts *)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
                                   error:(out NSError **)error;

@end
