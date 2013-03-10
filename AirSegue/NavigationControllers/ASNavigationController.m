//
//  ASNavigationController.m
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 26.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//

#if !(__has_feature(objc_arc))
#error ARC required. Add -fobjc-arc compiler flag for this file.
#endif

#import "ASNavigationController.h"

#import <QuartzCore/QuartzCore.h>

#import "ASPushEffect.h"


@interface ASNavigationController ()

@end


#pragma mark - Implementation

@implementation ASNavigationController

- (id)init {
    NSAssert(NO, @"Impropper ASViewController initialisation. Use - (id)initWithRootViewController: instead.");
    @throw @"Impropper ASViewController initialisation. Use - (id)initWithRootViewController: instead.";
    return nil;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (animated) {
        [self pushViewController:viewController withChangeEffect:self.pushEffect];
    } else {
        [super pushViewController:viewController animated:animated];
    }
}

- (void)pushViewController:(UIViewController *)viewController withChangeEffect:(ASPushEffect *)changeEffect {
    if (changeEffect) {
        UIImage *sourceImage = [self screenshot:self.visibleViewController.view];
        [super pushViewController:viewController animated:NO];
        UIImage *destinationImage = [self screenshot:viewController.view];

        [self prepareEffectForSourceImage:sourceImage destinationImage:destinationImage withChangeEffect:changeEffect];
        [changeEffect startForward];
    } else {
        [super pushViewController:viewController animated:YES];
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    UIViewController *result = nil;
    if (animated) {
        result = [self popViewControllerWithChangeEffect:self.pushEffect];
    } else {
        result = [super popViewControllerAnimated:animated];
    }
    return result;
}

- (UIViewController *)popViewControllerWithChangeEffect:(ASPushEffect *)changeEffect {
    UIViewController *result = nil;
    if (changeEffect) {
        UIImage *sourceImage = [self screenshot:self.visibleViewController.view];
        result = [super popViewControllerAnimated:NO];
        UIImage *destinationImage = [self screenshot:self.visibleViewController.view];

        [self prepareEffectForSourceImage:destinationImage destinationImage:sourceImage withChangeEffect:changeEffect];
        [changeEffect startBackward];
    } else {
        result = [super popViewControllerAnimated:NO];
    }
    return result;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    NSArray *result = nil;
    if (animated) {
        result = [self popToRootViewControllerWithChangeEffect:self.pushEffect];
    } else {
        result = [super popToRootViewControllerAnimated:animated];
    }
    return result;
}

- (NSArray *)popToRootViewControllerWithChangeEffect:(ASPushEffect *)changeEffect {
    NSArray *result = nil;
    if (changeEffect) {
        UIImage *sourceImage = [self screenshot:self.visibleViewController.view];
        result = [super popToRootViewControllerAnimated:NO];
        UIImage *destinationImage = [self screenshot:self.visibleViewController.view];

        [self prepareEffectForSourceImage:destinationImage destinationImage:sourceImage withChangeEffect:changeEffect];
        [changeEffect startBackward];
    } else {
        result = [super popToRootViewControllerAnimated:NO];
    }
    return result;
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSArray *result = nil;
    if (animated) {
        result = [self popToViewController:viewController withChangeEffect:self.pushEffect];
    } else {
        result = [super popToViewController:viewController animated:animated];
    }
    return result;
}

- (NSArray *)popToViewController:(UIViewController *)viewController
                withChangeEffect:(ASPushEffect *)changeEffect
{
    NSArray *result = nil;
    if (changeEffect) {
        UIImage *sourceImage = [self screenshot:self.visibleViewController.view];
        result = [super popToViewController:viewController animated:NO];
        UIImage *destinationImage = [self screenshot:self.visibleViewController.view];

        [self prepareEffectForSourceImage:destinationImage destinationImage:sourceImage withChangeEffect:changeEffect];
        [changeEffect startBackward];
    } else {
        result = [super popToViewController:viewController animated:NO];
    }
    return result;
}

- (void)prepareEffectForSourceImage:(UIImage *)sourceImage
                   destinationImage:(UIImage *)destinationImage
                   withChangeEffect:(ASPushEffect *)changeEffect
{
    [self prepareProcessView:changeEffect];

    changeEffect.sourceImage = sourceImage;
    changeEffect.destinationImage = destinationImage;
    __strong ASPushEffect *effect = changeEffect;     //< change effect should live while animating (should be string ref)
    changeEffect.completionBlock = ^() {
        [effect.processView removeFromSuperview];
    };
}

- (void)prepareProcessView:(ASPushEffect *)changeEffect {
    CGRect viewFrame = self.view.frame;
    CGRect processViewFrame = [self.view convertRect:viewFrame fromView:self.view.superview];
    UIView *processView = [[UIView alloc] initWithFrame:processViewFrame];
    [self.view addSubview:processView];

    changeEffect.processView = processView;
}

- (UIImage *)screenshot:(UIView *)view {
    // https://developer.apple.com/library/ios/#qa/qa2010/qa1703.html

    // Create a graphics context with the target size
    CGSize imageSize = view.frame.size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);

    CGContextRef context = UIGraphicsGetCurrentContext();

    // -renderInContext: renders in the coordinate space of the layer,
    // so we must first apply the layer's geometry to the graphics context
    CGContextSaveGState(context);
    // Center the context around the window's anchor point
    CGContextTranslateCTM(context, view.center.x, view.center.y);
    // Apply the window's transform about the anchor point
//    CGContextConcatCTM(context, [window transform]);
    // Offset by the portion of the bounds left of and above the anchor point
    CGContextTranslateCTM(context,
                          -view.bounds.size.width * [view.layer anchorPoint].x,
                          -view.bounds.size.height * [view.layer anchorPoint].y);

    // Render the layer hierarchy to the current context
    [view.layer renderInContext:context];

    // Restore the context
    CGContextRestoreGState(context);

    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return image;
}

@end
