//
//  ASRibbonPushSegue.m
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 15.03.2013.
//  Copyright 2013 aironik. All rights reserved.
//

#if !(__has_feature(objc_arc))
#error ARC required. Add -fobjc-arc compiler flag for this file.
#endif

#import "ASRibbonPushSegue.h"


@interface ASRibbonPushSegue ()

@end


#pragma mark - Implementation

@implementation ASRibbonPushSegue

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    NSAssert1([sourceViewController respondsToSelector:@selector(navigationController)]
              && [[sourceViewController navigationController] isKindOfClass:[UINavigationController class]],
              @"Can't perform segue. %@ needs UINavigationController from -navigationController",
              NSStringFromClass([self class]));
    UINavigationController *navigationController = [sourceViewController navigationController];
    [navigationController pushViewController:self.destinationViewController animated:YES];
}

@end
