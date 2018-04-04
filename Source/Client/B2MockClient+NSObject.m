//
//  B2MockClient+NSObject.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2MockClient.h"

@implementation B2MockClient (NSObject)

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2MockClient %p> {dataResponses=%@, fileDownloadResponse=%d}",
            (__bridge void *)self,
            [self dataResponses],
            [self fileDownloadResponse]];
}

@end
