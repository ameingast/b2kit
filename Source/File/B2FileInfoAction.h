//
//  B2FileInfoAction.h
//  B2Kit
//
//  Created by Andreas Meingast on 08.04.18.
//  Copyright © 2018 Andreas Meingast. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, B2FileInfoAction) {
    B2FileInfoActionNone = 0,
    B2FileInfoActionUploaded = 1 << 0,
    B2FileInfoActionHidden = 1 << 1
};

B2FileInfoAction B2FileInfoActionFromString(NSString *action);
NSString *NSStringFromB2FileInfoAction(B2FileInfoAction action);

NS_ASSUME_NONNULL_END
