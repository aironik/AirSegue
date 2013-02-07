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
        UIImage *targetImage = [self screenshot:viewController.view];

        CGRect viewFrame = self.view.frame;
        CGRect processViewFrame = [self.view convertRect:viewFrame fromView:self.view.superview];
        UIView *processView = [[UIView alloc] initWithFrame:processViewFrame];
        [self.view addSubview:processView];

        changeEffect.sourceImage = sourceImage;
        changeEffect.targetImage = targetImage;
        changeEffect.completionBlock = ^() {
            [processView removeFromSuperview];
        };
        changeEffect.processView = processView;
        [changeEffect start];
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
        // TODO: write me
        result = [super popViewControllerAnimated:NO];
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
        // TODO: write me
        result = [super popToRootViewControllerAnimated:NO];
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
        // TODO: write me
        result = [super popToViewController:viewController animated:NO];
    } else {
        result = [super popToViewController:viewController animated:NO];
    }
    return result;
}

- (UIImage *)screenshot:(UIView *)view {
    CGSize size = view.bounds.size;

    CGFloat scale = MAX(1.0f, view.window.screen.scale);

    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width * scale,
                                                       size.height * scale,
                                                       8,
                                                       4 * size.width * scale,
                                                       colorSpaceRef,
                                                       (kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast));
    CGColorSpaceRelease(colorSpaceRef);

    CGContextTranslateCTM(context, 0, size.height * scale);
    CGContextScaleCTM(context, scale, -scale);

    [view.layer renderInContext:context];

    CGImageRef cgImage = CGBitmapContextCreateImage(context);
    UIImage *image = [UIImage imageWithCGImage:cgImage scale:scale orientation:UIImageOrientationUp];

    CGImageRelease(cgImage);
    CGContextRelease(context);

    return image;
}

@end