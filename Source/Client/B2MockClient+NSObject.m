//
//  B2MockClient+NSObject.m
//  B2Kit
//
//  Created by Andreas Meingast on 15.07.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2MockClient.h"
#import "NSArray+B2Kit.h"

@implementation B2MockClient (NSObject)

- (NSString *)description
{
    return [NSString stringWithFormat:@"<B2MockClient %p> {requests=%@, dataResponses=%@, fileDownloadResponse=%d, fileURL=%@, account=%@, error=%@}",
            (__bridge void *)self,
            [[self requests] singleLineDescription],
            [[self dataResponses] singleLineDescription],
            [self fileDownloadResponse],
            [self fileURL],
            [self account],
            [self error]];
}

@end
