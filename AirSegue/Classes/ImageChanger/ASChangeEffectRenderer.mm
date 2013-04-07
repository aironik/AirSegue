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

float kASChangeEffectRendererProgressStart = Surfaces::Surface::BEGIN_PROGRESS;
float kASChangeEffectRendererProgressEnd = Surfaces::Surface::END_PROGRESS;

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

- (id)initWithSurface:(Surfaces::Surface *)surface role:(ASRendererRole)role {
    if (self = [super init]) {
        _surface = surface;
        [self setRole:role];
    } else {
        delete surface;
    }
    return self;
}

- (void)dealloc {
    delete _surface;
}

- (ASRendererRole)role {
    ASRendererRole result = ASRendererRoleSource;
    switch (_surface->getRole()) {
        default:
            NSAssert(NO, @"Unknown role type.");
            // No break.
        case Surfaces::Surface::ROLE_SOURCE:
            result = ASRendererRoleSource;
            break;
        case Surfaces::Surface::ROLE_TARGET:
            result = ASRendererRoleDestination;
            break;
    }
    return result;
}

- (void)setRole:(ASRendererRole)role {
    switch (role) {
        default:
            NSAssert(NO, @"Unknown role type.");
            // No break.
        case ASRendererRoleSource:
            _surface->setRole(Surfaces::Surface::ROLE_SOURCE);
            break;
        case ASRendererRoleDestination:
            _surface->setRole(Surfaces::Surface::ROLE_TARGET);
            break;
    }
}

- (void)setProgress:(float)progress {
    NSAssert3(kASChangeEffectRendererProgressStart <= progress && progress <= kASChangeEffectRendererProgressEnd,
              @"Unhandled progress value (%f). should bounds [%f..%f]",
              progress, kASChangeEffectRendererProgressStart, kASChangeEffectRendererProgressEnd);

    _progress = std::max(kASChangeEffectRendererProgressStart, std::max(progress, kASChangeEffectRendererProgressEnd));
    self.surface->setProgress(progress);
}

- (void)render {
    self.surface->draw();
}

@end