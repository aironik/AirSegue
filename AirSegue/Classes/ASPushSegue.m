//
//  ASPushSegue.m
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 17.03.2013.
//  Copyright 2013 aironik. All rights reserved.
//

#if !(__has_feature(objc_arc))
#error ARC required. Add -fobjc-arc compiler flag for this file.
#endif

#import "ASPushSegue.h"


@interface ASPushSegue ()

@end


#pragma mark - Implementation

@implementation ASPushSegue

#ifdef HAVE_SYSTEM_SEGUE_FEATURE
@dynamic sourceViewController;
@dynamic destinationViewController;
@dynamic identifier;
#else // !HAVE_SYSTEM_SEGUE_FEATURE
@synthesize sourceViewController = _sourceViewController;
@synthesize destinationViewController = _destinationViewController;
@synthesize identifier = _identifier;
#endif // HAVE_SYSTEM_SEGUE_FEATURE


- (id)initWithIdentifier:(NSString *)identifier
                  source:(UIViewController *)source
             destination:(UIViewController *)destination
{
#ifdef HAVE_SYSTEM_SEGUE_FEATURE
    if (self = [super initWithIdentifier:identifier source:source destination:destination]) {
    }
#else // !HAVE_SYSTEM_SEGUE_FEATURE
    if (self = [super init]) {
        _identifier = [identifier copy];
        _sourceViewController = source;
        _destinationViewController = destination;
    }
#endif // HAVE_SYSTEM_SEGUE_FEATURE
    return self;
}

- (void)perform {
#ifdef HAVE_SYSTEM_SEGUE_FEATURE
    [super perform];
#else // !HAVE_SYSTEM_SEGUE_FEATURE
    UINavigationController *navigationController = self.sourceViewController.navigationController;
    UIViewController *destinationViewController = self.destinationViewController;
    NSAssert(navigationController, @"ASPushSegue sourceViewController should have navigationController");
    NSAssert(destinationViewController, @"ASPushSegue nothing to perform.");
    if (self.unwind) {
        [navigationController pushViewController:destinationViewController animated:YES];
    } else {
        [navigationController popToViewController:destinationViewController animated:YES];
    }
#endif // HAVE_SYSTEM_SEGUE_FEATURE
}


@end
