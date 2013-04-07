//
//  ASTestStandViewController.m
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 07.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#import "ASDTestStandViewController.h"

#import <AirSegue/AirSegue.h>


@interface ASDTestStandViewController ()

@end


@implementation ASDTestStandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChanger];
}

- (void)setupChanger {
    self.imageChanger.effectKind = ASEffectKindRibbon;
    self.imageChanger.sourceImage = [UIImage imageNamed:@"sourceImage.png"];
    self.imageChanger.destinationImage = [UIImage imageNamed:@"destinationImage.png"];
    UISlider *valueSlider = self.valueSlider;
    self.imageChanger.duration = valueSlider.maximumValue;
}

- (void)dealloc {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)change:(id)sender {
    [self.imageChanger start];
}

- (IBAction)sliderValueDidChange:(UISlider *)sender {
    self.imageChanger.progress = sender.value;
}

- (IBAction)sliderPneumocushionDidChange:(UISlider *)sender {
//    ((ASRibbonChangeEffectRenderer *)self.imageChanger.sourceRenderer).pneumocushion = sender.value;
//    ((ASRibbonChangeEffectRenderer *)self.imageChanger.destinationRenderer).pneumocushion = sender.value;
}


@end
