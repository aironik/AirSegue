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

#import "ASEffectKind.h"
#import "ASPushEffect.h"
#import "ASPushSegue.h"


@interface ASNavigationController ()

@end


#pragma mark - Implementation

@implementation ASNavigationController

- (id)init {
    NSAssert(NO, @"Impropper ASViewController initialisation. Use - (id)initWithRootViewController: instead.");
    @throw @"Impropper ASViewController initialisation. Use - (id)initWithRootViewController: instead.";
    return nil;
}

#pragma mark - UINavigationController override

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        _effectKind = ASEffectKindRibbon;
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (animated && self.effectKind != ASEffectKindUndefined) {
        [self pushViewController:viewController withEffectKind:self.effectKind];
    } else {
        [super pushViewController:viewController animated:animated];
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    UIViewController *result = nil;
    if (animated && self.effectKind != ASEffectKindUndefined) {
        result = [self popViewControllerWithEffectKind:self.effectKind];
    } else {
        result = [super popViewControllerAnimated:animated];
    }
    return result;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    NSArray *result = nil;
    if (animated && self.effectKind != ASEffectKindUndefined) {
        result = [self popToRootViewControllerWithEffectKind:self.effectKind];
    } else {
        result = [super popToRootViewControllerAnimated:animated];
    }
    return result;
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSArray *result = nil;
    if (animated && self.effectKind != ASEffectKindUndefined) {
        result = [self popToViewController:viewController withEffectKind:self.effectKind];
    } else {
        result = [super popToViewController:viewController animated:animated];
    }
    return result;
}


#pragma mark - Cutomize push/pop animation effect

- (void)pushViewController:(UIViewController *)viewController withEffectKind:(ASEffectKind)effectKind {
    if (effectKind == ASEffectKindUndefined) {
        [super pushViewController:viewController animated:YES];
    } else {
        ASPushSegue *segue = [[ASPushSegue alloc] initWithIdentifier:@"PushId"
                                                              source:self.topViewController
                                                         destination:viewController];
        segue.effectKing = effectKind;
        [segue perform];
    }
}

- (UIViewController *)popViewControllerWithEffectKind:(ASEffectKind)effectKind {
    UIViewController *result = nil;
    if (effectKind == ASEffectKindUndefined) {
        result = [super popViewControllerAnimated:YES];
    } else {
        NSArray *controllers = self.viewControllers;
        UIViewController *source = self.topViewController;
        UIViewController *destination = [controllers objectAtIndex:[controllers count] - 2];
        ASPushSegue *segue = [[ASPushSegue alloc] initWithIdentifier:@"PopId"
                                                              source:source
                                                         destination:destination];
        segue.unwind = YES;
        segue.effectKing = effectKind;

        result = source;

        [segue perform];
    }
    return result;
}

- (NSArray *)popToRootViewControllerWithEffectKind:(ASEffectKind)effectKind {
    NSArray *result = nil;
    if (effectKind == ASEffectKindUndefined) {
        result = [super popToRootViewControllerAnimated:YES];
    } else {
        NSArray *controllers = self.viewControllers;
        UIViewController *source = self.topViewController;
        UIViewController *destination = [controllers objectAtIndex:0];
        ASPushSegue *segue = [[ASPushSegue alloc] initWithIdentifier:@"PopId"
                                                              source:source
                                                         destination:destination];
        segue.unwind = YES;
        segue.effectKing = effectKind;

        result = [controllers subarrayWithRange:NSMakeRange(1, [controllers count] - 1)];

        [segue perform];
    }
    return result;
}

- (NSArray *)popToViewController:(UIViewController *)viewController
                withEffectKind:(ASEffectKind)effectKind
{
    NSArray *result = nil;
    if (effectKind == ASEffectKindUndefined) {
        result = [super popToRootViewControllerAnimated:YES];
    } else {
        NSArray *controllers = self.viewControllers;
        UIViewController *source = self.topViewController;
        NSUInteger destinationIndex = [controllers indexOfObject:viewController];

        ASPushSegue *segue = [[ASPushSegue alloc] initWithIdentifier:@"PopId"
                                                              source:source
                                                         destination:viewController];
        segue.unwind = YES;
        segue.effectKing = effectKind;

        result = [controllers subarrayWithRange:NSMakeRange(destinationIndex, [controllers count] - destinationIndex)];

        [segue perform];
    }
    return result;
}


@end
