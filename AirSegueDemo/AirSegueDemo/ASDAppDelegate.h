//
//  ASDAppDelegate.h
//  AirSegueDemo
//
//  Created by Oleg Lobachev on 14.03.2013.
//  Copyright (c) 2013 aironik. All rights reserved.
//


@class ASEffectListViewController;
@class ASNavigationController;

@interface ASDAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) ASEffectListViewController *viewController;
@property (nonatomic, strong) ASNavigationController *navigationController;

@end

