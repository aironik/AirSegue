//
//  ASRenderer.h
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 07.04.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

typedef enum {
    ASRendererRoleSource,
    ASRendererRoleDestination
} ASRendererRole;

/// @brief This protocol defines image/surface/effect renderer behaviour.
/// @details Used for render change effect animation moment.
@protocol ASRenderer<NSObject>
@required

/// @brief Draw current moment state
- (void)render;

/// @brief Get current renderer role: source surface or destination surface.
- (ASRendererRole)role;

/// @brief Set current renderer role: source surface or destination surface.
- (void)setRole:(ASRendererRole)role;

/// @brief Get current progress value.
/// @details This value must bounds in kASChangeEffectRendererProgressStart..kASChangeEffectRendererProgressEnd.
///     kASChangeEffectRendererProgressStart <= progress <= kASChangeEffectRendererProgressEnd.
- (float)progress;

/// @brief Set current progress value.
/// @details This value must bounds in kASChangeEffectRendererProgressStart..kASChangeEffectRendererProgressEnd.
///     kASChangeEffectRendererProgressStart <= progress <= kASChangeEffectRendererProgressEnd.
- (void)setProgress:(float)progress;

@end
