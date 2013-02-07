//
//  ASChangeEffectRenderer.m
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 07.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#if !(__has_feature(objc_arc))
#error ARC required. Add -fobjc-arc compiler flag for this file.
#endif

#import "ASChangeEffectRenderer.h"

#import "Ribbon.h"


@interface ASChangeEffectRenderer ()

@property (nonatomic, assign, readwrite) BOOL started;
@property (nonatomic, assign, readonly) Surfaces::Surface *surface;

@end


#pragma mark - Implementation

@implementation ASChangeEffectRenderer

- (id)init {
    NSAssert(NO, @"Use -initWithRole: instead");
    return nil;
}

- (id)initWithRole:(ASChangeEffectRendererRole)role {
    if (self = [super init]) {
        _surface = new Surfaces::Ribbon();
        _role = role;
        switch (role) {
            case ASChangeEffectRendererRoleSource:
                _surface->setRole(Surfaces::Surface::ROLE_SOURCE);
                break;
            case ASChangeEffectRendererRoleTarget:
                _surface->setRole(Surfaces::Surface::ROLE_TARGET);
                break;
            default:
                NSAssert(NO, @"Unknown role type.");
                break;
        }
    }
    return self;
}

- (void)dealloc {
    delete _surface;
}

- (void)update:(NSTimeInterval)timeSinceLastUpdate {
    if (self.started) {
        self.time += timeSinceLastUpdate;
        self.surface->setProgress(self.time);
    }
}

- (void)setTime:(NSTimeInterval)time {
    _time = time;
    self.surface->setProgress(time);
}

- (void)render {
    self.surface->draw();
}

- (void)start {
    self.time = 0.0;
    self.started = YES;
}

- (void)stop {
    self.started = NO;
}

@end