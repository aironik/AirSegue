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

#import "ASImageChangerViewController.h"


@interface ASRibbonPushEffect ()

@property (nonatomic, strong) ASImageChangerViewController *changer;

@end


#pragma mark - Implementation

@implementation ASRibbonPushEffect

+ (instancetype)effect {
    return [[self alloc] init];
}

- (void)start {
    self.changer.duration = self.duration;
    self.changer.sourceImage = self.sourceImage;
    self.changer.destinationImage = self.destinationImage;
    self.changer.view.frame = self.processView.bounds;
    [self.processView addSubview:self.changer.view];
    
    __weak ASRibbonPushEffect *me = self;
    self.changer.completionBlock = ^() {
        __strong ASRibbonPushEffect *strongMe = me;
        [strongMe.changer.view removeFromSuperview];
        strongMe.changer = nil;
        if (strongMe.completionBlock) {
            strongMe.completionBlock();
        }
    };

    [self.changer start];
}

- (ASImageChangerViewController *)changer {
    if (!_changer) {
        _changer = [[ASImageChangerViewController alloc] init];
    }
    return _changer;
}

@end
