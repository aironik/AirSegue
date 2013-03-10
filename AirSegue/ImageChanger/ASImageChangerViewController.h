//
//  ASImageChangerViewController.h
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 07.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#import <GLKit/GLKit.h>


@class ASChangeEffectRenderer;

@interface ASImageChangerViewController : GLKViewController

@property (nonatomic, assign) BOOL useOriginalImagesAspect;
@property (nonatomic, strong) UIImage *sourceImage;
@property (nonatomic, strong) UIImage *destinationImage;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) BOOL directionBackward;
@property (nonatomic, assign) NSTimeInterval timeIntervalFromStart;
@property (nonatomic, copy) void(^completionBlock)();
@property (nonatomic, strong) ASChangeEffectRenderer *destinationRenderer;
@property (nonatomic, strong) ASChangeEffectRenderer *sourceRenderer;
@property (nonatomic, strong) Class effectClass;

- (void)start;
- (void)stop;

@end
