//
//  Shader.fsh
//  AirSegue
//
//  Created by Oleg Lobachev on 02/07/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
