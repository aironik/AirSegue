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

- (void)start {
    UIImageView *sourceImageView = [[UIImageView alloc] initWithImage:self.sourceImage];
    UIImageView *destinationImageView = [[UIImageView alloc] initWithImage:self.destinationImage];
    sourceImageView.frame = self.processView.bounds;
    destinationImageView.frame = self.processView.bounds;

    sourceImageView.alpha = 1.0f;
    destinationImageView.alpha = 0.0f;

    [self.processView addSubview:sourceImageView];
    [self.processView addSubview:destinationImageView];

    __weak ASPushEffect *me = self;
    [UIView animateWithDuration:self.duration animations:^() {
        sourceImageView.alpha = 0.0f;
        destinationImageView.alpha = 1.0f;
    }                completion:^(BOOL finished) {
        __strong ASPushEffect *strongMe = me;
        if (strongMe.completionBlock) {
            strongMe.completionBlock();
        }
    }];
}

@end
