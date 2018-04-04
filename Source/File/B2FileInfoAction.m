//
//  B2FileInfoAction.m
//  B2Kit
//
//  Created by Andreas Meingast on 08.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

#import "B2FileInfoAction.h"

inline B2FileInfoAction B2FileInfoActionFromString(NSString *action) {
    if ([action isEqualToString:@"upload"]) {
        return B2FileInfoActionUploaded;
    } else if ([action isEqualToString:@"hidden"]) {
        return B2FileInfoActionHidden;
    } else {
        return B2FileInfoActionNone;
    }
}

inline NSString *NSStringFromB2FileInfoAction(B2FileInfoAction action)
{
    switch (action) {
        case B2FileInfoActionNone:
            return @"";
        case B2FileInfoActionHidden:
            return @"hidden";
        case B2FileInfoActionUploaded:
            return @"upload";
    }
}
