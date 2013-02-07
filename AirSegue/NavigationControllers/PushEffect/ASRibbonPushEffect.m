//
//  ASRibbonPushEffect.m
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 01.03.2013.
//  Copyright 2013 aironik. All rights reserved.
//

#if !(__has_feature(objc_arc))
#error ARC required. Add -fobjc-arc compiler flag for this file.
#endif

#import "ASRibbonPushEffect.h"


@interface ASRibbonPushEffect ()

@end


#pragma mark - Implementation

@implementation ASRibbonPushEffect

+ (instancetype)effect {
    return [[self alloc] init];
}

- (void)start {
    [super start];
}

@end