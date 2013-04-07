//
//  ASImageChangerViewController_Protected.h
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 25.03.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#import "ASImageChangerViewController.h"


@protocol ASRenderer;


@interface ASImageChangerViewController (Protected)

@property (nonatomic, strong) NSObject<ASRenderer> *destinationRenderer;
@property (nonatomic, strong) NSObject<ASRenderer> *sourceRenderer;

@end