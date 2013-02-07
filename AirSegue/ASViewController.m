//
//  ASViewController.m
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 07.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#import "ASViewController.h"

#import "ASImageChangerViewControler.h"


@interface ASViewController ()

@end


@implementation ASViewController

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
    [self.imageChanger start];
}

@end
