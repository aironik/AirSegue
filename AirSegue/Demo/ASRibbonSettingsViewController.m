//
//  ASRibbonSettingsViewController.m
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 10.03.2013.
//  Copyright 2013 aironik. All rights reserved.
//

#if !(__has_feature(objc_arc))
#error ARC required. Add -fobjc-arc compiler flag for this file.
#endif

#import "ASRibbonSettingsViewController.h"
#import "ASRibbonPushEffect.h"


@interface ASRibbonSettingsViewController ()

@property (nonatomic, weak) IBOutlet UISlider *durationSlider;
@property (nonatomic, weak) IBOutlet UILabel *durationLabel;

@property (nonatomic, weak) IBOutlet UISlider *pneumocushionSlider;
@property (nonatomic, weak) IBOutlet UILabel *pneumocushionLabel;

@end


#pragma mark - Implementation

@implementation ASRibbonSettingsViewController

static NSTimeInterval duration = 1.0;

+ (NSTimeInterval)duration {
    return duration;
}

+ (void)setDuration:(NSTimeInterval)value {
    duration = value;
}

static float pneumocushion = 0.02f;

+ (float)pneumocushion {
    return pneumocushion;
}

+ (void)setPneumocushion:(float)value {
    pneumocushion = value;
}

- (IBAction)durationSliderChanged:(UISlider *)slider {
    [[self class] setDuration:slider.value];
    UILabel *label = self.durationLabel;
    label.text = [NSString stringWithFormat:@"%1.1f", slider.value];
}

- (IBAction)pneumocushionSliderChanged:(UISlider *)slider {
    [[self class] setPneumocushion:slider.value];
    UILabel *label = self.pneumocushionLabel;
    label.text = [NSString stringWithFormat:@"%1.2f", slider.value];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UISlider *durationSlider = self.durationSlider;
    durationSlider.value = [[self class] duration];
    [self durationSliderChanged:durationSlider];

    UISlider *pneumocushionSlider = self.pneumocushionSlider;
    pneumocushionSlider.value = [[self class] pneumocushion];
    [self pneumocushionSliderChanged:pneumocushionSlider];
}

@end
