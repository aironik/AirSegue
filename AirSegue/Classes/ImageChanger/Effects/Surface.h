//
//  Surface.h
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 07.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#ifndef __Surface_H_
#define __Surface_H_

#import "Vertex3D.h"

#import <vector>

#import <AirSegue/ASEffectKind.h>


namespace Surfaces {

/// @brief Base surface class.
/// @details This interface uses as lowe-level draw effects.
///     Each screen represents as image and after draw with deformations.
class Surface {
protected:
    typedef std::vector<Vertex3D> VertexList;

public:
    typedef enum {
        ROLE_SOURCE,            ///< This surface use as source image.
        ROLE_TARGET             ///< This surface use as target image.
    } Role;

    /// @brief Value define start segue process of process.
    static const float BEGIN_PROGRESS;

    /// @brief Value define finish segue process of process.
    static const float END_PROGRESS;

public:
    Surface();
    virtual ~Surface();

    /// @brief Set process progress.
    /// @details This value ranges from BEGIN_PROGRESS to END_PROGRESS.
    virtual void setProgress(float aProgress);

    /// @brief Draw vertexes.
    /// @details Draw vertexes previously set by setVertexes(const VertexList &).
    ///     If haveNormals() return true draw according normal vectors.
    ///     If haveTexCoord() return true bind txture coordinates.
    ///     If haveColor() return true additional use color for draw vertex. 
    void draw();

    /// @brief Set surface role.
    /// @details This value define surface role.
    ///     Source role means this surface visible on start process.
    ///     Destination means this surface visible on finish process.
    void setRole(Role role);

    /// @brief Get surface role.
    Role getRole() const { return role; }

protected:
    /// @brief Generate vertexes for current progress.
    /// @details This method call while progress has updated.
    ///     Genetate and set vertexes for current progress.
    /// @see setVertexes
    /// @see getProgress
    virtual void updateVertexes() = 0;

    /// @brief Cut original rectangle for segments.
    void cutRectangle(int horizontalSegmentsCount, int verticalSegmentsCount);

    /// @brief Get original segments generated by cutRectangle().
    const VertexList &getOriginalVertexes() const { return originalVertexes; }

    /// @brief bind data which setup by setVertexes()
    void rebindData() const;

    /// @brief Set vertexes described surface for draw.
    void setVertexes(const VertexList &vertexes);

    /// @brief Set OpenGL kind of primitives to render. Default value is GL_TRIANGLE_STRIP
    /// @see glDrawArrays
    void setDrawMode(GLenum drawMode) { this->drawMode = drawMode; }

    /// @brief Get progress of currnt process.
    /// @details This value ranges from BEGIN_PROGRESS to END_PROGRESS.
    float getProgress() const { return progress; }

    /// @brief If true vertexes data contains normals data.
    virtual bool haveNormals() const { return true; }

    /// @brief If true vertexes data contains texture coordinates.
    virtual bool haveTexCoord() const { return false; }

    /// @brief If true vertexes data contails color.
    virtual bool haveColor() const { return false; }

private:
    /// @brief push vertex from original rectangle while execut cutRectangle.
    void pushCutVectorAtXY(int x, int y, int horizontalSegmentsCount, int verticalSegmentsCount);

private:
    Role role;                      ///< Surface role: source or target image.
    GLuint name;                    ///< OpenGL name. Use for bind.
    GLuint buffer;                  ///< OpenGL buffer name.

    bool vertexesUpdated;           ///< Flag define vertexes has updated after last bind.
    VertexList vertexes;            ///< Vertexes data describe current state of surface.
    VertexList originalVertexes;    ///< Vertexes describe plain rectangle without transform. Generates by cutRectangle(). This vertexes use for generate this->vertexes by transform for current progress.
    GLenum drawMode;                ///< OpenGL kind of primitives to render. @see glDrawArrays

    float progress;                 ///< Progress state. Ranges from BEGIN_PROGRESS to END_PROGRESS.
};

} // namespace Surfaces

#endif //__Surface_H_
