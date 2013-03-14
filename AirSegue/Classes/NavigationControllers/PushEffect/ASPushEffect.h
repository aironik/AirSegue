//
//  ASPushEffect.h
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 26.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//

@interface ASPushEffect : NSObject

@property (nonatomic, strong) UIView *processView;
@property (nonatomic, strong) UIImage *sourceImage;
@property (nonatomic, strong) UIImage *destinationImage;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, copy) void(^completionBlock)();

- (void)startForward;
- (void)startBackward;
@end
