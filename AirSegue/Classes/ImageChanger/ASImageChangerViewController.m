//
//  ASImageChangerViewController.m
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 07.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#import "ASChangeEffectRenderer.h"


#if !(__has_feature(objc_arc))
#error ARC required. Add -fobjc-arc compiler flag for this file.
#endif

#import "ASImageChangerViewController.h"
#import "ASRenderer.h"

#import "ASChangeEffectRenderer.h"
#import "ASRibbonChangeEffectRenderer.h"


@interface ASImageChangerViewController ()

@property (nonatomic, strong) EAGLContext *eaglContext;

@property (nonatomic, strong) GLKTextureInfo *sourceTextureInfo;
@property (nonatomic, strong) GLKTextureInfo *destinationTextureInfo;

@property (nonatomic, strong) GLKBaseEffect *sourceEffect;
@property (nonatomic, strong) GLKBaseEffect *destinationEffect;

@property (nonatomic, assign, readonly) GLKVector4 lightDiffuseColor;

@property (nonatomic, assign) BOOL changing;

@property (nonatomic, strong) NSObject<ASRenderer> *destinationRenderer;
@property (nonatomic, strong) NSObject<ASRenderer> *sourceRenderer;

@end


#pragma mark - Implementation

@implementation ASImageChangerViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle {
    if (self = [super initWithNibName:nibName bundle:nibBundle]) {
        _effectKind = ASEffectKindRibbon;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]) {
        _effectKind = ASEffectKindRibbon;
    }
    return self;
}

- (id)initWithEffectKind:(ASEffectKind)effectKind {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _effectKind = effectKind;
    }
    return self;
}

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

    BOOL useOriginalImagesAspect = YES;
    const float aspect = useOriginalImagesAspect ? 1.0 : self.view.bounds.size.width / self.view.bounds.size.height;

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

    [self createRenderers];

    self.paused = NO;
}

- (void)createRenderers {
    NSAssert([self isViewLoaded], @"Impropper usage. Renderers should create while OpenGL has initialized");
    self.sourceRenderer = [[self class] createRendererWithKind:self.effectKind role:ASRendererRoleSource];
    self.destinationRenderer = [[self class] createRendererWithKind:self.effectKind role:ASRendererRoleDestination];
    [self updateRenderersProgress];
}

+ (NSObject<ASRenderer> *)createRendererWithKind:(ASEffectKind)kind role:(ASRendererRole)role {
    NSObject<ASRenderer> *result = nil;
    switch (kind) {
        default:
        case ASEffectKindUndefined:
            NSAssert1(NO, @"Unknown effect kind %d", kind);
            // no break. create default
        case ASEffectKindRibbon:
            result = [ASRibbonChangeEffectRenderer effectRendererWithRole:role];
            break;
        case ASEffectKindFade:
            // TODO" wrirte fade effect.
            result = [ASRibbonChangeEffectRenderer effectRendererWithRole:role];
            break;
    }
    return result;
}

- (EAGLContext *)eaglContext {
    if (!_eaglContext) {
        _eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    }
    return _eaglContext;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    if ([self isViewLoaded] && ![[self view] window]) {
        [self tearDownGL];

        if ([EAGLContext currentContext] == self.eaglContext) {
            [EAGLContext setCurrentContext:nil];
        }
        self.eaglContext = nil;
        self.view = nil;
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
    [self updateProgress];

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
    self.progress = self.directionBackward ? 1.0 : 0.0;
    [self update];
}

- (void)stop {
    if (self.changing) {
        self.changing = NO;
        if (self.completionBlock) {
            self.completionBlock();
        }
    }
}

- (void)updateProgress {

    if (self.changing) {
        BOOL finished = NO;
        if (self.duration > 0.0) {
            NSTimeInterval progressDelta = self.timeSinceLastUpdate * (1.0 / self.duration);
            self.progress = self.progress + (progressDelta * (self.directionBackward ? -1.0 : 1.0));
            finished = self.directionBackward ? (self.progress <= 0.0) : (self.progress >= 1.0);
        } else {
            finished = YES;
        }

        if (finished) {
            // move progress into valid bounds.
            self.progress = self.directionBackward ? 0.0 : 1.0;
            [self stop];
        }
    }
}

- (void)updateRenderersProgress {
    const float rendererProgressLength = kASChangeEffectRendererProgressEnd - kASChangeEffectRendererProgressStart;
    const float rendererProgress = kASChangeEffectRendererProgressStart + rendererProgressLength * self.progress;

    self.sourceRenderer.progress = rendererProgress;
    self.destinationRenderer.progress = rendererProgress;
}

@end
