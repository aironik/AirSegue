//
//  ASImageChangerViewControler.h
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 07.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#import <GLKit/GLKit.h>


@interface ASImageChangerViewControler : GLKViewController

@property (nonatomic, assign) BOOL useOriginalImagesAspect;
@property (nonatomic, strong) UIImage *sourceImage;
@property (nonatomic, strong) UIImage *destinationImage;
@property (nonatomic, copy) void(^completionBlock)();

- (void)change;
- (void)setProgress:(NSTimeInterval)progress;

@end
