//
//  Surface.mm
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 07.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#include "Surface.h"

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>


namespace Surfaces {

const float Surface::BEGIN_PROGRESS = 0.0f;
const float Surface::END_PROGRESS = 1.0f;

Surface::Surface()
        : role(ROLE_SOURCE)
        , name(0)
        , buffer(0)
        , vertexesUpdated(true)
        , drawMode(GL_TRIANGLE_STRIP)
        , progress(BEGIN_PROGRESS)
{
    glGenVertexArraysOES(1, &name);
    glGenBuffers(1, &buffer);
}

Surface::~Surface() {

    glDeleteBuffers(1, &buffer);
    buffer = 0;
    
    glDeleteVertexArraysOES(1, &name);
    name = 0;
}

void Surface::setProgress(float aProgress) {
    NSCAssert(aProgress >= BEGIN_PROGRESS && aProgress <= END_PROGRESS, @"Progress out of bounds");

    progress = std::max(BEGIN_PROGRESS, std::min(aProgress, END_PROGRESS));

    updateVertexes();
}

void Surface::draw() {
    if (!vertexes.size()) {
        updateVertexes();
    }
    if (vertexesUpdated) {
        rebindData();
    }
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    if (haveNormals()) {
        glEnableVertexAttribArray(GLKVertexAttribNormal);
    } else {
        glDisableVertexAttribArray(GLKVertexAttribNormal);
    }

    if (haveTexCoord()) {
        glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    } else {
        glDisableVertexAttribArray(GLKVertexAttribTexCoord0);
    }
    if (haveColor()) {
        glEnableVertexAttribArray(GLKVertexAttribColor);
    } else {
        glDisableVertexAttribArray(GLKVertexAttribColor);
    }
    glBindVertexArrayOES(name);
    glDrawArrays(drawMode, 0, vertexes.size());
}

void Surface::setRole(Role aRole) {
    if (this->role != aRole) {
        this->role = aRole;
        updateVertexes();
    }
}

void Surface::cutRectangle(int horizontalSegmentsCount, int verticalSegmentsCount) {
    originalVertexes.clear();
    for (int y = 0; y < verticalSegmentsCount; ++y) {
        pushCutVectorAtXY(0, y, horizontalSegmentsCount, verticalSegmentsCount);
        for (int x = 0; x <= horizontalSegmentsCount; ++x) {
            pushCutVectorAtXY(x, y, horizontalSegmentsCount, verticalSegmentsCount);
            pushCutVectorAtXY(x, (y + 1), horizontalSegmentsCount, verticalSegmentsCount);
        }
        pushCutVectorAtXY(horizontalSegmentsCount, (y + 1), horizontalSegmentsCount, verticalSegmentsCount);
    }
}

void Surface::pushCutVectorAtXY(int x, int y, int horizontalSegmentsCount, int verticalSegmentsCount) {
    Vertex3D vertex;
    vertex.position = Vector3(1.0f * x / horizontalSegmentsCount - 0.5f, 1.0f * y / verticalSegmentsCount - 0.5f, 0.0f);
    vertex.normal = Vector3(0.0f, 0.0f, -1.0f);
    vertex.texCoord = Vector2(1.0f * x / horizontalSegmentsCount, 1.0f * y / verticalSegmentsCount);
    originalVertexes.push_back(vertex);
}

void Surface::rebindData() const {
    glBindVertexArrayOES(name);
    glBindBuffer(GL_ARRAY_BUFFER, buffer);

    const GLsizeiptr bufferSize = vertexes.size() * sizeof(Vertex3D);

    glBufferData(GL_ARRAY_BUFFER, bufferSize, &vertexes.front(), GL_STATIC_DRAW);

    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, haveNormals(), sizeof(Vertex3D), Vertex3D::positionPtr());

    if (haveNormals()) {
        glEnableVertexAttribArray(GLKVertexAttribNormal);
        glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, haveNormals(), sizeof(Vertex3D), Vertex3D::normalPtr());
    }

    if (haveTexCoord()) {
        glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
        glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, haveNormals(), sizeof(Vertex3D), Vertex3D::texCoordPtr());
    }

    if (haveColor()) {
        glEnableVertexAttribArray(GLKVertexAttribColor);
        glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex3D), Vertex3D::colorPtr());
    }
}

void Surface::setVertexes(const VertexList &aVertexes) {
    this->vertexes = aVertexes;
    vertexesUpdated = true;
}


} // namespace Surfaces
