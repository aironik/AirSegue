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
    UIImageView *targetImageView = [[UIImageView alloc] initWithImage:self.targetImage];
    sourceImageView.frame = self.processView.bounds;
    targetImageView.frame = self.processView.bounds;

    sourceImageView.alpha = 1.0f;
    targetImageView.alpha = 0.0f;

    [self.processView addSubview:sourceImageView];
    [self.processView addSubview:targetImageView];

    [UIView animateWithDuration:self.duration animations:^() {
        sourceImageView.alpha = 0.0f;
        targetImageView.alpha = 1.0f;
    }                completion:^(BOOL finished) {
        if (self.completionBlock) {
            self.completionBlock();
        }
    }];
}

@end