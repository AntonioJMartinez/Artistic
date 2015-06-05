//
//  ARNavigationController.m
//  Artistic
//
//  Created by Antonio J. on 28/05/15.
//  Copyright (c) 2015 Antonio J. Martinez Sanchez. All rights reserved.
//

#import "ARNavigationController.h"

@implementation ARNavigationController

- (void)awakeFromNib {
 
    [self.navigationBar setBarTintColor:[UIColor navigationBarColor]];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName: [UIFont quicksandRegularOfSize:22.0f]}];
    self.navigationBar.translucent = YES;
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
    @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont quicksandRegularOfSize:17.0]
      } forState:UIControlStateNormal];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
