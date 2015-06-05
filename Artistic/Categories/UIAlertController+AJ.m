//
//  UIAlertController+AJ.m
//  Photrise
//
//  Created by Antonio J. on 19/05/15.
//  Copyright (c) 2015 Antonio Jose Martinez Sanchez. All rights reserved.
//

#import "UIAlertController+AJ.h"

@implementation UIAlertController (AJ)

+ (void)showBasicAlertWithTitle:(NSString*)title
                        message:(NSString*)message
                    buttonTitle:(NSString*)buttonTitle
                   buttonAction:(SEL)buttonAction
                   buttonTarget:(id)buttonTarget
               onViewController:(UIViewController*)viewController {
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: title == nil ? @"": title
                                                                   message: message
                                                            preferredStyle: UIAlertControllerStyleAlert];
    
    if (buttonTitle != nil) {
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle: buttonTitle
                                                                style: UIAlertActionStyleCancel
                                                              handler: ^(UIAlertAction *action) {
                                                                  if ( buttonAction != nil && buttonTarget != nil) {
                                                                      [buttonTarget performSelector:buttonAction];
                                                                  }
                                                              }];
        [alert addAction: defaultAction];
    }
    
    [viewController presentViewController:alert animated: YES completion: nil];

}

+ (void)showFullAlertWithTitle:(NSString*)title
                             message:(NSString*)message
                   cancelButtonTitle:(NSString*)cancelButtonTitle
                  cancelButtonAction:(SEL)cancelButtonAction
                  cancelButtonTarget:(id)cancelButtonTarget
                       okButtonTitle:(NSString*)okButtonTitle
                      okButtonAction:(SEL)okButtonAction
                      okButtonTarget:(id)okButtonTarget
                    onViewController:(UIViewController*)viewController {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: title == nil ? @"": title
                                                                   message: message
                                                            preferredStyle: UIAlertControllerStyleAlert];
    
    if (cancelButtonTitle != nil) {
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle: cancelButtonTitle
                                                                style: UIAlertActionStyleCancel
                                                              handler: ^(UIAlertAction *action) {
                                                                  [cancelButtonTarget performSelector:cancelButtonAction];
                                                              }];
        [alert addAction: defaultAction];
    }
    
    if (okButtonTitle != nil){
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [okButtonTarget performSelector:okButtonAction];
        }];
        
        [alert addAction:okAction];
    }
    
    [viewController presentViewController:alert animated: YES completion: nil];
}

@end
