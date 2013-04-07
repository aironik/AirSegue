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

#import "ASFadePushEffect.h"
#import "ASEffectKind.h"
#import "ASRibbonPushEffect.h"


static const NSTimeInterval kASPushEffectDuration = 0.3;

@interface ASPushEffect ()

@property (nonatomic, assign, readwrite) ASEffectKind kind;

@end


#pragma mark - Implementation

@implementation ASPushEffect

+ (id)effectWithKind:(ASEffectKind)kind {
    return [[self alloc] initWithKind:kind];
}

- (id)initWithKind:(ASEffectKind)kind {
    ASPushEffect *result = nil;
    switch (kind) {
        default:
            NSAssert1(NO, @"Unknown effect kind %d. Use ASEffectKindRibbon", kind);
            // No break. Use default kind.
        case ASEffectKindUndefined:
        case ASEffectKindRibbon:
            result = [[ASRibbonPushEffect alloc] init];
            break;
        case ASEffectKindFade:
            result = [[ASFadePushEffect alloc] init];
            break;
    }
    result.kind = kind;
    return result;
}

- (id)init {
    NSAssert([self class] != [ASPushEffect class], @"Impropper push effect initializing. Use -initWithKind: instead.");
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
