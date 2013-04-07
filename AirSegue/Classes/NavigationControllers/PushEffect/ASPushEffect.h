//
//  ASPushEffect.h
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 26.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//

#import <AirSegue/ASEffectKind.h>


@interface ASPushEffect : NSObject

/// @brief View for locate animation process.
@property (nonatomic, strong) UIView *processView;

/// @brief First image. This image shows on start and make hidden during animation.
@property (nonatomic, strong) UIImage *sourceImage;

/// @brief Second image. This image hidden on start and make visible during animation.
@property (nonatomic, strong) UIImage *destinationImage;

/// @brief Time interval for change images animation.
@property (nonatomic, assign) NSTimeInterval duration;

/// Code block which execute after finish animation.
@property (nonatomic, copy) void(^completionBlock)();

@property (nonatomic, assign, readonly) ASEffectKind kind;

/// @brief Create new animation effect object which implement specified animation.
+ (id)effectWithKind:(ASEffectKind)kind;

/// @brief Create new animation effect object which implement specified animation.
- (id)initWithKind:(ASEffectKind)kind;

/// @brief Start change image animation effect with forward direction.
/// @details E.g. for ribbon effect forward direction is twist from left to right.
///     There is no difference for fade effect.
- (void)startForward;

/// @brief Start change image animation effect with backward direction.
/// @details E.g. for ribbon effect backward direction is twist from right to left.
///     There is no difference for fade effect.
- (void)startBackward;

@end
