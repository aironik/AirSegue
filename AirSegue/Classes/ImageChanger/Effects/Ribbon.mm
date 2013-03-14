//
//  Ribbon.cpp
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 08.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#include "Ribbon.h"

namespace {

static const float ribbonWidth2 = 1.0f;
static const float ribbonLength = 2.0f;

static const GLuint vertexTrialglesDelta = 2;
static const GLuint trianglesPerRobon = 40;
static const float startTorsionPosition = ribbonLength;
static const float torsionSpeed = 1.0f;
static const float torsionLength = ribbonLength;

} // namespace ::

namespace Surfaces {

Ribbon::Ribbon()
        : pneumocushion(0.02f)
{
    cutRectangle(10, 10);
}

void Ribbon::updateVertexes() {
    VertexList vertexes;
    NSCAssert(getOriginalVertexes().size(), @"Original vertexes not yet generated. Call cutRectangle() before.");
    vertexes.resize(getOriginalVertexes().size());

    VertexList::const_iterator it = getOriginalVertexes().begin();
    for (; it != getOriginalVertexes().end(); ++it) {
        vertexes.push_back(rotateVertex(*it));
    }

    setVertexes(vertexes);
}

Vertex3D Ribbon::rotateVertex(const Vertex3D &vertex) const {
    Vertex3D result(vertex);
    const float offset = vertex.position.x - (2.0f * getProgress() - 1.0f) / (END_PROGRESS - BEGIN_PROGRESS);
    
    NSCParameterAssert(getRole() == ROLE_SOURCE || getRole() == ROLE_TARGET);
    float adjustmentForRole = (getRole() == ROLE_SOURCE ? 0.0f : 1.0f);
    
    float alpha = M_PI * (std::max(0.0f, std::min(offset + 0.5f, 1.0f)) + adjustmentForRole);

    GLKMatrix3 rotateMatrix = GLKMatrix3RotateX(GLKMatrix3Identity, alpha);
    Vector3 pneumocushionOffset(0.0f, 0.0f, -getPneumocushion() / 2.0f);
    Vector3 pos = (vertex.position + pneumocushionOffset);
    result.position = GLKMatrix3MultiplyVector3(rotateMatrix, pos.glkVector);
    result.normal = GLKMatrix3MultiplyVector3(rotateMatrix, result.normal.glkVector);
    result.color = Vector4(1.0f, 1.0f, 1.0f, 1.0f);
    return result;
}

} // namespace Surfaces
