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

#import "ASImageChangerViewControler.h"


@interface ASRibbonPushEffect ()

@property (nonatomic, strong) ASImageChangerViewControler *changer;

@end


#pragma mark - Implementation

@implementation ASRibbonPushEffect

+ (instancetype)effect {
    return [[self alloc] init];
}

- (void)start {
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

    [self.changer change];
}

- (ASImageChangerViewControler *)changer {
    if (!_changer) {
        _changer = [[ASImageChangerViewControler alloc] init];
    }
    return _changer;
}

@end
