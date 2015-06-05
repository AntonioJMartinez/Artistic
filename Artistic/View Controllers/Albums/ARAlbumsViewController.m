//
//  ARAlbumsViewController.m
//  Artistic
//
//  Created by Antonio J. on 28/05/15.
//  Copyright (c) 2015 Antonio J. Martinez Sanchez. All rights reserved.
//

#import "ARAlbumsViewController.h"
#import "ARApiClient.h"
#import "ARCoreDataManager.h"
#import "AROriginalCollectionViewCell.h"

@implementation ARAlbumsViewController

#pragma mark - Life View Cycle

- (void)awakeFromNib {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray *albums = [ARCoreDataManager getAlbumsFromArtistId:self.artistIdentifier];
    
    self.cells = albums;
    
    [self.collectionView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)dealloc {
    
}

#pragma mark - ARArtistsViewController methods

#pragma mark - UICollectionViewDelegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    AROriginalCollectionViewCell *cell = nil;
    
    if ([[collectionView cellForItemAtIndexPath:indexPath] isKindOfClass:[AROriginalCollectionViewCell class]]) {
        
        cell = (AROriginalCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    }
}
@end
