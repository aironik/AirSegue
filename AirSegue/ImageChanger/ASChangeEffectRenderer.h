//
//  ASChangeEffectRenderer.h
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 07.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//


typedef enum {
    ASChangeEffectRendererRoleSource,
    ASChangeEffectRendererRoleDestination
} ASChangeEffectRendererRole;

/// @brief Value represene start progress point (initial minimum value).
extern float kASChangeEffectRendererProgressStart;

/// @brief Value represene finish progress point (last and maximum value).
extern float kASChangeEffectRendererProgressEnd;


/// @brief Renderer single surface according progress.
/// @details Render with OpenGL into current context.
@interface ASChangeEffectRenderer : NSObject

/// @brief current progress
/// @details This value must bounds in kASChangeEffectRendererProgressStart..kASChangeEffectRendererProgressEnd.
///     kASChangeEffectRendererProgressStart <= progress <= kASChangeEffectRendererProgressEnd.
@property (nonatomic, assign) float progress;

/// @brief current surface rile.
/// @details ASChangeEffectRendererRoleSource value means source surface which
///     should be full screen (full view) if progress == kASChangeEffectRendererProgressStart
///     and should be hidden for progress == kASChangeEffectRendererProgressEnd.
///     ASChangeEffectRendererRoleDestination means this surface hidden at start
///     (progress == kASChangeEffectRendererProgressStart) and should be full screen (full view)
///     for progress == kASChangeEffectRendererProgressEnd.
@property (nonatomic, assign, readonly) ASChangeEffectRendererRole role;

/// @brief create ribbon change effect renderer for surface role.
/// @see role
+ (instancetype)ribbonRendererWithRole:(ASChangeEffectRendererRole)role;

/// @brief Render current surface scene.
- (void)render;

@end
