//
//  KeyboardManagerBridge.m
//  DongerBoard
//
//  Created by Everett Berry on 5/25/16.
//  Copyright © 2016 Kirby Kohlmorgen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(KeyboardManager, NSObject)

RCT_EXTERN_METHOD(recordColor:(NSString *)color red:(float *)red green:(float *)green blue:(float *)blue)

@end