//
//  AROriginalCollectionViewCell.h
//  Artistic
//
//  Created by Antonio J. on 29/05/15.
//  Copyright (c) 2015 Antonio J. Martinez Sanchez. All rights reserved.
//

@class ARAlbum;

#import <UIKit/UIKit.h>

@interface AROriginalCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurView;

// Setters
- (void)configureForAlbum:(ARAlbum*)album;
- (void)configureForArtist:(ARAlbum*)album;

@end
