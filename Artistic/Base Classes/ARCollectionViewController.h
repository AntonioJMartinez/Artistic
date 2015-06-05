//
//  ARCollectionViewController.h
//  Artistic
//
//  Created by Antonio J. on 29/05/15.
//  Copyright (c) 2015 Antonio J. Martinez Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARCollectionViewController : UICollectionViewController 

@property (nonatomic, strong) NSArray *cells;

@property (nonatomic, strong) UIBarButtonItem *refreshBarButton;


- (void)showRefreshBarButton;
- (void)hideRefreshBarButton;

@end
