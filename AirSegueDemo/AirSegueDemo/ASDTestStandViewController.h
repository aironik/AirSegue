//
//  ASDTestStandViewController.h
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 07.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASImageChangerViewController;


@interface ASDTestStandViewController : UIViewController

@property (nonatomic, strong) IBOutlet ASImageChangerViewController *imageChanger;
@property (nonatomic, weak) IBOutlet UISlider *valueSlider;
@property (nonatomic, weak) IBOutlet UISlider *pneumocushionSlider;

- (IBAction)change:(id)sender;
- (IBAction)sliderValueDidChange:(UISlider *)sender;
- (IBAction)sliderPneumocushionDidChange:(UISlider *)sender;

@end
