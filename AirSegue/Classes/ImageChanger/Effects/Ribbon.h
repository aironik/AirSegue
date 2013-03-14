//
//  Ribbon.cpp
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 08.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//


#ifndef __Ribbon_H_
#define __Ribbon_H_

#include "Surface.h"


namespace Surfaces {

class Ribbon : public Surface {
public:
    Ribbon();

    void setPneumocushion(float newPneumocushion) { pneumocushion = newPneumocushion; }
    float getPneumocushion() const { return pneumocushion; }

protected:
    virtual void updateVertexes();
    virtual bool haveTexCoord() const { return true; }
    virtual bool haveColor() const { return true; }

private:
    Vertex3D rotateVertex(const Vertex3D &vertex) const;

private:
    float pneumocushion;
};

} // namespace Surfaces

#endif //__Ribbon_H_
