//
//  ASRibbonChangeEffectRenderer.m
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.03.2013.
//  Copyright 2013 aironik. All rights reserved.
//

#if !(__has_feature(objc_arc))
#error ARC required. Add -fobjc-arc compiler flag for this file.
#endif

#import "ASRibbonChangeEffectRenderer.h"

#import "ASChangeEffectRenderer+CppProtected.h"
#import "Ribbon.h"


@interface ASRibbonChangeEffectRenderer ()

@end


#pragma mark - Implementation

@implementation ASRibbonChangeEffectRenderer

@dynamic pneumocushion;


+ (instancetype)effectRendererWithRole:(ASRendererRole)role {
    Surfaces::Ribbon *ribbon = new Surfaces::Ribbon();
    return [[self alloc] initWithSurface:ribbon role:role];
}

- (void)setPneumocushion:(float)pneumocushion {
    Surfaces::Ribbon *ribbon = (Surfaces::Ribbon *)self.surface;
    ribbon->setPneumocushion(pneumocushion);
}

- (float)pneumocushion {
    Surfaces::Ribbon *ribbon = (Surfaces::Ribbon *)self.surface;
    return ribbon->getPneumocushion();
}

@end
