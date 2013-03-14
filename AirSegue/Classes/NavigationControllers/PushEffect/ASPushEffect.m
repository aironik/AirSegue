//
//  ASPushEffect.m
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 26.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//

#if !(__has_feature(objc_arc))
#error ARC required. Add -fobjc-arc compiler flag for this file.
#endif

#import "ASPushEffect.h"


static const NSTimeInterval kASPushEffectDuration = 0.3;

@interface ASPushEffect ()

@end


#pragma mark - Implementation

@implementation ASPushEffect

- (id)init {
    if (self = [super init]) {
        _duration = kASPushEffectDuration;
    }
    return self;
}

- (void)startForward {
    NSAssert1(NO, @"%s method doesn't implement. You should override this method.", __func__);
    if (self.completionBlock) {
        self.completionBlock();
    }
}

- (void)startBackward {
    NSAssert1(NO, @"%s method doesn't implement. You should override this method.", __func__);
    if (self.completionBlock) {
        self.completionBlock();
    }
}

@end
