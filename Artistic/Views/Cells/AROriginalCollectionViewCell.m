//
//  AROriginalCollectionViewCell.m
//  Artistic
//
//  Created by Antonio J. on 29/05/15.
//  Copyright (c) 2015 Antonio J. Martinez Sanchez. All rights reserved.
//

#import "AROriginalCollectionViewCell.h"
#import "ARAlbum.h"
#import <UIImageView+AFNetworking.h>


@implementation AROriginalCollectionViewCell


- (void)awakeFromNib {

    self.titleName.textColor = [UIColor whiteColor];
    self.titleName.font = [UIFont quicksandRegularOfSize:22.0];
    self.titleName.adjustsFontSizeToFitWidth = YES;
    
    self.photoImageView.layer.cornerRadius = 20.0f;
    self.photoImageView.layer.masksToBounds = YES;
}

- (void)prepareForReuse {
    [super prepareForReuse];

}

#pragma mark - setters

- (void)configureForAlbum:(ARAlbum*)album{
    
    if (album.title == nil || [album.title isEqualToString:@""]) {
        if (album.artistName != nil && ![album.artistName isEqualToString:@""]) {
            
            _titleName.text = [NSString stringWithFormat:@"%@ Album",album.artistName];
        } else {
            
            _titleName.text = @"Album";
        }
        
    } else {
        
        _titleName.text = album.title;
    }

    if ( album.coverURL != nil) {
        
        [_photoImageView setImageWithURL:[NSURL URLWithString:album.coverURL]];
        _backgroundImageView.image = self.photoImageView.image;
    }
}

- (void)configureForArtist:(ARAlbum*)album{
    
    _titleName.text = album.artistName;

    if ( album.coverURL != nil && ![album.coverURL isEqualToString:@""]) {
        
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:album.coverURL]];
        [_backgroundImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            
            _backgroundImageView.image = image;
            _photoImageView.image = image;
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            
        }];
    }
}


@end
