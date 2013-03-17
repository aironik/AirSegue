//
//  ASFadePushEffect.m
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.03.13.
//  Copyright 2013 aironik. All rights reserved.
//

#if !(__has_feature(objc_arc))
#error ARC required. Add -fobjc-arc compiler flag for this file.
#endif

#import "ASFadePushEffect.h"


@interface ASFadePushEffect ()

@end


#pragma mark - Implementation

@implementation ASFadePushEffect

- (void)startWithSourceImage:(UIImage *)sourceImage destinationImage:(UIImage *)destinationImage {
    UIImageView *sourceImageView = [[UIImageView alloc] initWithImage:sourceImage];
    UIImageView *destinationImageView = [[UIImageView alloc] initWithImage:destinationImage];
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
        [sourceImageView removeFromSuperview];
        [destinationImageView removeFromSuperview];

        __strong ASPushEffect *strongMe = me;
        if (strongMe.completionBlock) {
            strongMe.completionBlock();
        }
    }];
}

- (void)startForward {
    [self startWithSourceImage:self.sourceImage destinationImage:self.destinationImage];
}

- (void)startBackward {
    [self startWithSourceImage:self.destinationImage destinationImage:self.sourceImage];
}

@end
