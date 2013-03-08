//
//  ASTestStandViewController.h
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 07.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASImageChangerViewController;


@interface ASTestStandViewController : UIViewController

@property (nonatomic, strong) IBOutlet ASImageChangerViewController *imageChanger;
@property (nonatomic, weak) IBOutlet UISlider *valueSlider;
@property (nonatomic, weak) IBOutlet UISlider *xAngleSlider;
@property (nonatomic, weak) IBOutlet UISlider *yAngleSlider;
@property (nonatomic, weak) IBOutlet UISlider *zAngleSlider;

- (IBAction)change:(id)sender;
- (IBAction)sliderValueDidChange:(UISlider *)sender;
- (IBAction)sliderXAngleDidChange:(UISlider *)sender;
- (IBAction)sliderYAngleDidChange:(UISlider *)sender;
- (IBAction)sliderZAngleDidChange:(UISlider *)sender;

@end
