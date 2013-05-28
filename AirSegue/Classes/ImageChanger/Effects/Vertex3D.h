//
//  Vertex3D.h
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 07.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#ifndef __Vertex_H_
#define __Vertex_H_

#import <GLKit/GLKit.h>

#import "Vector.h"


namespace Surfaces {

/// @brief Vertex representation
struct Vertex3D {
public:
    Vector3 position;        ///< Vertex position in 3D space
    Vector3 normal;          ///< Normal in 3D space
    Vector2 texCoord;        ///< Textures coordinates of Vertex
    Vector4 color;           ///< Vertex color

public:
    Vertex3D() {}
    Vertex3D(const Vector3 &aPosition) : position(aPosition) {}
    Vertex3D(const Vector3 &aPosition, const Vector3 &aNormal) : position(aPosition), normal(aNormal) {}
    Vertex3D(const Vector3 &aPosition, const Vector3 &aNormal, const Vector2 &aTexCoord) : position(aPosition), normal(aNormal), texCoord(aTexCoord) {}
    Vertex3D(GLfloat px, GLfloat py, GLfloat pz) : position(px, py, pz) {}
    Vertex3D(GLfloat px, GLfloat py, GLfloat pz, GLfloat nx, GLfloat ny, GLfloat nz) : position(px, py, pz), normal(nx, ny, nz) {}

    static const GLsizei positionSize() { return sizeof(position); }
    static const GLvoid *positionPtr() { return (char *)0; }
    static const GLsizei normalSize() { return sizeof(normal); }
    static const GLvoid *normalPtr() { return (char *)0 + positionSize(); }
    static const GLsizei texCoordSize() { return sizeof(texCoord); }
    static const GLvoid *texCoordPtr() { return (char *)0 + positionSize() + normalSize(); }
    static const GLsizei colorSize() { return sizeof(color); }
    static const GLvoid *colorPtr() { return (char *)0 + positionSize() + normalSize() + texCoordSize(); }
};

} // namespace Surfaces

#endif //__Vertex_H_
