//
//  ASChangeEffectRenderer.h
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 07.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#import "ASRenderer.h"


/// @brief Value represene start progress point (initial minimum value).
/// @details OpenGL surface class wrapper.
extern float kASChangeEffectRendererProgressStart;

/// @brief Value represene finish progress point (last and maximum value).
extern float kASChangeEffectRendererProgressEnd;


/// @brief Renderer single surface according progress.
/// @details Render with OpenGL into current context.
@interface ASChangeEffectRenderer : NSObject<ASRenderer>

/// @brief Get current progress value.
/// @details This value must bounds in kASChangeEffectRendererProgressStart..kASChangeEffectRendererProgressEnd.
///     kASChangeEffectRendererProgressStart <= progress <= kASChangeEffectRendererProgressEnd.
@property (nonatomic, assign) float progress;

/// @brief Current surface role.
/// @details ASRendererRoleSource value means source surface which
///     should occupy full view (full view) if progress == 0.0 (at start)
///     and should be hidden for progress == 1.0 (at finish).
///     ASRendererRoleDestination means this surface hidden at start
///     (progress == 0.0) and should be full screen (full view)
///     for progress == 1.0.
@property (nonatomic, assign) ASRendererRole role;

/// @brief Render current surface scene.
- (void)render;

@end
