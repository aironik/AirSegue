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
    
protected:
    virtual void updateVertexes();
    virtual bool haveTexCoord() const { return true; }
    virtual bool haveColor() const { return true; }

private:
    float getPneumocushion() const { return 0.02f; }
    Vertex3D rotateVertex(const Vertex3D &vertex) const;
};

} // namespace Surfaces

#endif //__Ribbon_H_
