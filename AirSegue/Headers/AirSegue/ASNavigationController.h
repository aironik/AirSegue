//
//  ASNavigationController.h
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 26.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//

#import <AirSegue/ASEffectKind.h>


@class ASPushEffect;


/// @brief The navigation controller extends UIViewController functionality and let select push and pop animation.
@interface ASNavigationController : UINavigationController

/// @brief Views change animation effect.
@property (nonatomic, assign) ASEffectKind effectKind;

/// @brief Pushes a view controller onto the receiver's stack using effectKind property for animation effect.
/// @see effectKind
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

/// @brief Pushes a view controller onto the receiver's stack using effectKind animation effect.
- (void)pushViewController:(UIViewController *)viewController withEffectKind:(ASEffectKind)effectKind;

/// @brief Pops top view controller from navigation stack using effectKind property for animation effect.
/// @see effectKind
- (UIViewController *)popViewControllerAnimated:(BOOL)animated;

/// @brief Pops top view controller from navigation stack using effectKind for animation effect.
- (UIViewController *)popViewControllerWithEffectKind:(ASEffectKind)effectKind;

/// @brief Pops all view controller on the stack except root view controller using effectKind property for animation effect.
/// @see effectKind
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated;

/// @brief Pops all view controller on the stack except root view controller using effectKind for animation effect.
- (NSArray *)popToRootViewControllerWithEffectKind:(ASEffectKind)effectKind;

/// @brief Pops view controller until specified view controller began top using effectKind property for animation effect.
/// @see effectKind
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated;

/// @brief Pops view controller until specified view controller began top using effectKind for animation effect.
- (NSArray *)popToViewController:(UIViewController *)viewController withEffectKind:(ASEffectKind)effectKind;

@end
