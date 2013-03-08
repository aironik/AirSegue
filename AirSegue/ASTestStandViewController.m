//
//  ASTestStandViewController.m
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 07.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#import "ASTestStandViewController.h"

#import "ASImageChangerViewController.h"


@interface ASTestStandViewController ()

@end


@implementation ASTestStandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChanger];
}

- (void)setupChanger {
    self.imageChanger.sourceImage = [UIImage imageNamed:@"sourceImage.png"];
    self.imageChanger.destinationImage = [UIImage imageNamed:@"destinationImage.png"];
}

- (void)dealloc {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)change:(id)sender {
    [self.imageChanger change];
}

- (IBAction)sliderValueDidChange:(UISlider *)sender {
    [self.imageChanger setProgress:sender.value];
}

- (IBAction)sliderXAngleDidChange:(UISlider *)sender {

}

- (IBAction)sliderYAngleDidChange:(UISlider *)sender {

}

- (IBAction)sliderZAngleDidChange:(UISlider *)sender {

}


@end
