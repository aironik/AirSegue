//
//  ASChangeEffectRenderer.h
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 07.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//


typedef enum {
    ASChangeEffectRendererRoleSource,
    ASChangeEffectRendererRoleTarget
} ASChangeEffectRendererRole;

@interface ASChangeEffectRenderer : NSObject

@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, assign, readonly) ASChangeEffectRendererRole role;
@property (nonatomic, assign, readonly) BOOL started;

- (id)initWithRole:(ASChangeEffectRendererRole)role;

- (void)update:(NSTimeInterval)timeSinceLastUpdate;
- (void)render;
- (void)start;
- (void)stop;

@end
