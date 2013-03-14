//
//  ASRibbonChangeEffectRenderer.h
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.03.2013.
//  Copyright 2013 aironik. All rights reserved.
//

#import "ASChangeEffectRenderer.h"


@interface ASRibbonChangeEffectRenderer : ASChangeEffectRenderer

@property (nonatomic, assign) float pneumocushion;

+ (instancetype)effectRendererWithRole:(ASChangeEffectRendererRole)role;

@end
