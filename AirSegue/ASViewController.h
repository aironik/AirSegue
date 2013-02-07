//
//  ASViewController.h
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 07.02.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASImageChangerViewControler;


@interface ASViewController : UIViewController

@property (nonatomic, strong) IBOutlet ASImageChangerViewControler *imageChanger;

- (IBAction)change:(id)sender;

@end
