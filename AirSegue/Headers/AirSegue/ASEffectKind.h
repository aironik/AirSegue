//
//  ASEffectKind.h
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 25.03.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#ifndef __ASEffectKind_H_
#define __ASEffectKind_H_

/// @brief Effect kind
/// @details You can setup visual effect type while image change from one to another.
///     This values used when you construct image change effects or controllers.
typedef enum {
    ASEffectKindUndefined = 0,          ///< Effect not defined
    ASEffectKindRibbon,                 ///< Images change as double-side ribbon.
    ASEffectKindFade,                   ///< Images change with fade animation effect. First image increase transparency, second conversly.
} ASEffectKind;

#endif // __ASEffectKind_H_
