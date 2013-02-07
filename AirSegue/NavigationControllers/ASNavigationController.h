//
//  ASNavigationController.h
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 26.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//

@class ASPushEffect;


/// @brief The ASNavigationController class implements change views effects.
@interface ASNavigationController : UINavigationController

/// @brief Views change effect. If nil use default UINavigationController push/pop effect.
@property (nonatomic, strong) ASPushEffect *pushEffect;

- (id)initWithRootViewController:(UIViewController *)rootViewController;

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)pushViewController:(UIViewController *)viewController withChangeEffect:(ASPushEffect *)changeEffect;
- (UIViewController *)popViewControllerAnimated:(BOOL)animated;
- (UIViewController *)popViewControllerWithChangeEffect:(ASPushEffect *)changeEffect;
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated;
- (NSArray *)popToRootViewControllerWithChangeEffect:(ASPushEffect *)changeEffect;
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (NSArray *)popToViewController:(UIViewController *)viewController withChangeEffect:(ASPushEffect *)changeEffect;

@end