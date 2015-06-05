//
//  UIAlertController+AJ.h
//  Photrise
//
//  Created by Antonio J. on 19/05/15.
//  Copyright (c) 2015 Antonio Jose Martinez Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (AJ)

+ (void)showBasicAlertWithTitle:(NSString*)title
                        message:(NSString*)message
                    buttonTitle:(NSString*)buttonTitle
                   buttonAction:(SEL)buttonAction
                   buttonTarget:(id)buttonTarget
               onViewController:(UIViewController*)viewController;

+ (void)showFullAlertWithTitle:(NSString*)title
                       message:(NSString*)message
             cancelButtonTitle:(NSString*)cancelButtonTitle
            cancelButtonAction:(SEL)cancelButtonAction
            cancelButtonTarget:(id)cancelButtonTarget
                 okButtonTitle:(NSString*)okButtonTitle
                okButtonAction:(SEL)okButtonAction
                okButtonTarget:(id)okButtonTarget
              onViewController:(UIViewController*)viewController;
@end
