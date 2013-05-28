//
//  ASImageChangerViewController.h
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 07.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#import <GLKit/GLKit.h>

#import <AirSegue/ASEffectKind.h>


/// @brief View controller which manage change image from one to another.
/// @details This view controller let replace image to another with specified animation effect.
@interface ASImageChangerViewController : GLKViewController

/// @brief This image occupy full view on start.
@property (nonatomic, strong) UIImage *sourceImage;

/// @brief This image occupy full view on finish.
@property (nonatomic, strong) UIImage *destinationImage;

/// @brief This image use as background while images changes.
@property (nonatomic, strong) UIImage *backgroundImage;

/// @brief Images change duration in seconds.
@property (nonatomic, assign) NSTimeInterval duration;

/// @brief Progress direction. If NO proceed changes from begin to end. If YES process changes from end to begin
@property (nonatomic, assign) BOOL directionBackward;

/// @brief This value defines current progress value. It changes from 0.0 to 1.0.
@property (nonatomic, assign) NSTimeInterval progress;

/// @brief The code block to be executed when the animation ends.
@property (nonatomic, copy) void(^completionBlock)();

/// @brief Animation effect kind.
/// @details This value setup in init object and can't be changed.
/// @see ASEffectKind.
@property (nonatomic, assign, readonly) ASEffectKind effectKind;

/// @brief Initialize new image changer view controller instance for specified animation effect.
- (id)initWithEffectKind:(ASEffectKind)effectKind;

/// @brief Start change effect animation sequence.
/// @details Starts change image replace animation. After -start progress property smoothly changes
///     from 0.0 to 1.0 according duration property
/// @see duration
/// @see process
- (void)start;

/// @brief Stop process.
/// @details Stop initiated process. If change images animation have started change progress stopping
///     and call completionBlock. If animation process didn't started this method do nothing.
- (void)stop;

@end
