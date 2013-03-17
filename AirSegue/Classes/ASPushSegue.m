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

#import <QuartzCore/QuartzCore.h>

#import "ASPushEffect.h"


@interface ASPushSegue ()

@property (nonatomic, strong) ASPushEffect *effect;

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
#else // !HAVE_SYSTEM_SEGUE_FEATURE
    if (self = [super init]) {
        _identifier = [identifier copy];
        _sourceViewController = source;
        _destinationViewController = destination;
#endif // HAVE_SYSTEM_SEGUE_FEATURE

        _effectName = @"ASRibbonPushEffect";
    }
    return self;
}

- (void)perform {
    UINavigationController *navigationController = [self.sourceViewController navigationController];
    UIViewController *destinationViewController = self.destinationViewController;
    NSAssert(navigationController, @"ASPushSegue sourceViewController should have navigationController");
    NSAssert(destinationViewController, @"ASPushSegue nothing to perform.");
    if (self.unwind) {
        [self startWithChangeBlock:^() {
            [navigationController popToViewController:destinationViewController animated:YES];
        }];
    } else {
        [self startWithChangeBlock: ^() {
            [navigationController pushViewController:destinationViewController animated:YES];
        }];
    }
}

- (ASPushEffect *)effect {
    if (!_effect) {
        _effect = [[NSClassFromString(self.effectName) alloc] init];
    }
    return _effect;
}

- (void)setEffectName:(NSString *)effectName {
    if (![_effectName isEqualToString:effectName]) {
        _effectName = [effectName copy];
        self.effect = nil;
    }
}

// @params changeBlock: NOT animated push or pop ([navigationController pushViewController:vc animated:NO]
//      or [navigationController popViewControllerAnimated:NO])
- (void)startWithChangeBlock:(void(^)())changeBlock {
    [self prepareProcessView];

    UINavigationController *navigationController = [self.sourceViewController navigationController];
    UIImage *sourceImage = [self screenshot:navigationController.visibleViewController.view];
    changeBlock();
    [navigationController.view layoutIfNeeded];
    [navigationController.visibleViewController.view setNeedsLayout];
    [navigationController.visibleViewController.view layoutIfNeeded];
    UIImage *destinationImage = [self screenshot:navigationController.visibleViewController.view];

    [self prepareEffectForSourceImage:sourceImage destinationImage:destinationImage];
    if (self.unwind) {
        [self.effect startBackward];
    } else {
        [self.effect startForward];
    }
}

- (void)prepareEffectForSourceImage:(UIImage *)sourceImage
                   destinationImage:(UIImage *)destinationImage
{
    self.effect.sourceImage = sourceImage;
    self.effect.destinationImage = destinationImage;
    __strong ASPushEffect *effect = self.effect;     //< change effect should live while animating (should be string ref)
    self.effect.completionBlock = ^() {
        [effect.processView removeFromSuperview];
        effect.completionBlock = nil;
    };
}

- (void)prepareProcessView {
    UINavigationController *navigationController = [self.sourceViewController navigationController];
    UIView *view = navigationController.visibleViewController.view;
    CGRect processViewFrame = [view.superview convertRect:view.frame toView:navigationController.view];
    UIView *processView = [[UIView alloc] initWithFrame:processViewFrame];
    [navigationController.view addSubview:processView];

    self.effect.processView = processView;
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
