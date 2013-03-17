//
//  ASPushSegue.h
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 17.03.2013.
//  Copyright 2013 aironik. All rights reserved.
//


/// @brief Class define system push segue functionality
@interface ASPushSegue
#if (defined HAVE_SYSTEM_SEGUE_FEATURE)
        : UIStoryboardSegue
#else // !HAVE_SYSTEM_SEGUE_FEATURE
        : NSObject
#endif // HAVE_SYSTEM_SEGUE_FEATURE

#ifndef HAVE_SYSTEM_SEGUE_FEATURE
@property (nonatomic, strong, readonly) id sourceViewController;
@property (nonatomic, strong, readonly) id destinationViewController;
@property (nonatomic, strong, readonly) NSString *identifier;
#endif // HAVE_SYSTEM_SEGUE_FEATURE

/// @brief Flag define forward (push) if YES or backward (unwind or pop) if NO direction.
@property (nonatomic, assign) BOOL unwind;
@property (nonatomic, copy) NSString *effectName;

- (id)initWithIdentifier:(NSString *)identifier
                  source:(UIViewController *)source
             destination:(UIViewController *)destination;

/// @brief Performs the visual transition for the segue.
- (void)perform;

@end
