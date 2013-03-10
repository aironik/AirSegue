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


@interface ASRibbonSettingsViewController ()

@property (nonatomic, weak) IBOutlet UISlider *durationSlider;
@property (nonatomic, weak) IBOutlet UILabel *durationLabel;

- (IBAction)durationSliderChanger:(UISlider *)slider;

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

- (IBAction)durationSliderChanger:(UISlider *)slider {
    [[self class] setDuration:slider.value];
    UILabel *label = self.durationLabel;
    label.text = [NSString stringWithFormat:@"%1.1f", slider.value];
}

- (void)viewDidLoad {
    UILabel *label = self.durationLabel;
    label.text = [NSString stringWithFormat:@"%1.1f", [[self class] duration]];
    UISlider *slider = self.durationSlider;
    slider.value = [[self class] duration];
}

@end
