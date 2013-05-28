//
//  ASSettings.m
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 28.05.2013.
//  Copyright © 2013 aironik. All rights reserved.
//

#if !(__has_feature(objc_arc))
#error ARC required. Add -fobjc-arc compiler flag for this file.
#endif

#import "ASSettings.h"


@interface ASSettings ()
@end


#pragma mark - Implementation

@implementation ASSettings

+ (instancetype)sharedSettings {
    static ASSettings *sharedSettings = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedSettings = [[self alloc] init];
    });
    return sharedSettings;
}

- (id)init {
    if (self = [super init]) {
        _pushWithNavigationBar = NO;
    }
    return self;
}

@end
