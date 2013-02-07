//
//  ASAppDelegate.h
//  AirSegue
//
//  Created by Oleg Lobachev on 02/07/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASViewController;

@interface ASAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ASViewController *viewController;

@end