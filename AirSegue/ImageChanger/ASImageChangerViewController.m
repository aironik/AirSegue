//
//  ASImageChangerViewController.m
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 07.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#if !(__has_feature(objc_arc))
#error ARC required. Add -fobjc-arc compiler flag for this file.
#endif

#import "ASImageChangerViewController.h"

#import "ASChangeEffectRenderer.h"
#import "ASRibbonChangeEffectRenderer.h"


@interface ASImageChangerViewController ()

@property (nonatomic, strong) EAGLContext *eaglContext;

@property (nonatomic, strong) GLKTextureInfo *sourceTextureInfo;
@property (nonatomic, strong) GLKTextureInfo *destinationTextureInfo;

@property (nonatomic, strong) GLKBaseEffect *sourceEffect;
@property (nonatomic, strong) GLKBaseEffect *destinationEffect;

@property (nonatomic, assign, readonly) GLKVector4 lightDiffuseColor;

@property (nonatomic, strong) ASChangeEffectRenderer *destinationRenderer;
@property (nonatomic, strong) ASChangeEffectRenderer *sourceRenderer;

@property (nonatomic, assign) BOOL changing;

@end


#pragma mark - Implementation

@implementation ASImageChangerViewController

- (void)dealloc {
    [self tearDownGL];

    if ([EAGLContext currentContext] == self.eaglContext) {
        [EAGLContext setCurrentContext:nil];
    }
}

- (void)setSourceImage:(UIImage *)sourceImage {
    _sourceImage = sourceImage;
    [self refreshSourceTextureInfo];
}

- (void)refreshSourceTextureInfo {
    if ([self isViewLoaded]) {
        self.sourceTextureInfo = [GLKTextureLoader textureWithCGImage:_sourceImage.CGImage
                                                              options:nil
                                                                error:NULL];
        self.sourceEffect.texture2d0.enabled = (self.sourceTextureInfo != nil);
        self.sourceEffect.texture2d0.name = self.sourceTextureInfo.name;
        self.sourceEffect.texture2d0.target = GLKTextureTarget2D;
        self.sourceEffect.textureOrder = @[self.sourceEffect.texture2d0];
    }
}

- (void)setDestinationImage:(UIImage *)destinationImage {
    _destinationImage = destinationImage;
    [self refreshDestinationTextureInfo];
}

- (void)refreshDestinationTextureInfo {
    if ([self isViewLoaded]) {
        self.destinationTextureInfo = [GLKTextureLoader textureWithCGImage:_destinationImage.CGImage
                                                                   options:nil
                                                                     error:NULL];
        self.destinationEffect.texture2d0.enabled = (self.destinationTextureInfo != nil);
        self.destinationEffect.texture2d0.name = self.destinationTextureInfo.name;
        self.destinationEffect.texture2d0.target = GLKTextureTarget2D;
        self.destinationEffect.textureOrder = @[self.destinationEffect.texture2d0];
    }
}

- (GLKBaseEffect *)sourceEffect {
    if (!_sourceEffect) {
        _sourceEffect = [self createBaseEffect];
        [self refreshSourceTextureInfo];
    }
    return _sourceEffect;
}

- (GLKBaseEffect *)destinationEffect {
    if (!_destinationEffect) {
        _destinationEffect = [self createBaseEffect];
        [self refreshDestinationTextureInfo];
    }
    return _destinationEffect;
}

- (GLKBaseEffect *)createBaseEffect {
    GLKBaseEffect *effect = [[GLKBaseEffect alloc] init];
    effect.useConstantColor = GL_FALSE;
    effect.colorMaterialEnabled = GL_TRUE;
    effect.light0.enabled = GL_TRUE;

    [self updateEffect:effect];

    return effect;
}

- (void)updateEffect:(GLKBaseEffect *)effect {
    [self updateEffectLight:effect];
    [self updateEffectMatrix:effect];
}

- (void)updateEffectLight:(GLKBaseEffect *)effect {
    effect.light0.diffuseColor = self.lightDiffuseColor;
    effect.light0.position = self.lightPosition;
}

- (void)updateEffectMatrix:(GLKBaseEffect *)effect {
    const float zOffset = 10.0f;
    const float height2 = 1.0f / 2.0f;
    const float alpha = atanf(height2 / zOffset) * 2.0f;

    const float aspect = self.useOriginalImagesAspect ? (self.view.bounds.size.width / self.view.bounds.size.height) : 1.0f;

    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(alpha, aspect, zOffset / 2.0f, zOffset * 2.0f);
    effect.transform.projectionMatrix = projectionMatrix;

    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -zOffset);
    effect.transform.modelviewMatrix = modelViewMatrix;
}

- (GLKVector4)lightDiffuseColor {
    return GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
}

- (GLKVector4)lightPosition {
    return GLKVector4Make(0.0f, 0.0f, 2.0f, 0.0f);
}


#pragma mark -

- (void)viewDidLoad {
    NSParameterAssert([self.view isKindOfClass:[GLKView class]]);
    [super viewDidLoad];

    [self setupGL];

    [self destinationEffect];
    [self sourceEffect];
    
    glEnable(GL_DEPTH_TEST);

    self.destinationRenderer = [ASRibbonChangeEffectRenderer effectRendererWithRole:ASChangeEffectRendererRoleDestination];
    self.sourceRenderer = [ASRibbonChangeEffectRenderer effectRendererWithRole:ASChangeEffectRendererRoleSource];

    self.paused = NO;
}

- (EAGLContext *)eaglContext {
    if (!_eaglContext) {
        _eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    }
    return _eaglContext;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    if ([self isViewLoaded] && [[self view] window]) {
        self.view = nil;

        [self tearDownGL];

        if ([EAGLContext currentContext] == self.eaglContext) {
            [EAGLContext setCurrentContext:nil];
        }
        self.eaglContext = nil;
    }
}

- (void)setupGL {
    GLKView *view = (GLKView *)self.view;
    view.context = self.eaglContext;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;

    [EAGLContext setCurrentContext:self.eaglContext];

    glEnable(GL_DEPTH_TEST);
}

- (void)tearDownGL {
    [EAGLContext setCurrentContext:self.eaglContext];

    self.sourceEffect = nil;
    self.destinationEffect = nil;
}

- (void)update {
    [self updateTimer];

    [self updateEffect:self.sourceEffect];
    [self updateEffect:self.destinationEffect];

    [self updateRenderersProgress];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    [self.sourceEffect prepareToDraw];
    [self.sourceRenderer render];

    [self.destinationEffect prepareToDraw];
    [self.destinationRenderer render];
}

- (void)start {
    NSAssert(self.duration > 0.0, @"%@ duration can't be 0.", NSStringFromClass([self class]));
    self.changing = YES;

    self.timeIntervalFromStart = 0.0;
}

- (void)stop {
    self.changing = NO;

    if (self.completionBlock) {
        self.completionBlock();
    }
}

- (void)updateTimer {
    if (self.changing) {
        NSTimeInterval timeDelta = self.timeSinceLastUpdate;
        if (timeDelta + self.timeIntervalFromStart > self.duration) {
            self.timeIntervalFromStart = self.duration;
            [self stop];
        } else {
            self.timeIntervalFromStart += timeDelta;
        }
    }
}

- (void)updateRenderersProgress {
    const float rendererProgressLength = kASChangeEffectRendererProgressEnd - kASChangeEffectRendererProgressStart;
    const float timeProgress = self.timeIntervalFromStart / self.duration;
    const float rendererProgress = self.directionBackward
                                 ? kASChangeEffectRendererProgressEnd - rendererProgressLength * timeProgress
                                 : kASChangeEffectRendererProgressStart + rendererProgressLength * timeProgress;

    self.sourceRenderer.progress = rendererProgress;
    self.destinationRenderer.progress = rendererProgress;
}

@end
