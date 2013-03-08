//
//  ASAppDelegate.h
//  AirSegue
//
//  Created by Oleg Lobachev on 02/07/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASEffectListViewController;
@class ASNavigationController;

@interface ASAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) ASEffectListViewController *viewController;
@property (nonatomic, strong) ASNavigationController *navigationController;

@end
