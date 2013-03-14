//
//  ASChangeEffectRenderer(CppProtected)${FILE_EXTENTION}
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.03.2013.
//  Copyright 2013 aironik. All rights reserved.
//

#import "ASChangeEffectRenderer.h"

namespace Surfaces {
class Surface;
}

@interface ASChangeEffectRenderer (CppProtected)

@property (nonatomic, assign, readonly) Surfaces::Surface *surface;

- (id)initWithSurface:(Surfaces::Surface *)surface role:(ASChangeEffectRendererRole)role;

@end