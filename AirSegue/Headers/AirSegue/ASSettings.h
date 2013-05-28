//
//  ASSettings.h
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 28.05.2013.
//  Copyright © 2013 aironik. All rights reserved.
//



@interface ASSettings : NSObject

/// @brief Push effect cransform view with navigation bar.
/// @details If YES push animation use navivation bar, so push animation use full screen space.
///     Change animation occuar inside view with static navigation bar otherwise.
@property (nonatomic, assign) BOOL pushWithNavigationBar;


+ (instancetype)sharedSettings;

@end
