//
//  ARCollectionViewController.m
//  Artistic
//
//  Created by Antonio J. on 29/05/15.
//  Copyright (c) 2015 Antonio J. Martinez Sanchez. All rights reserved.
//

#import "ARCollectionViewController.h"
#import "AROriginalCollectionViewCell.h"
#import "ARArtistsViewController.h"
#import "ARAlbumsViewController.h"
#import "ARApiClient.h"

NSUInteger const numberOfSections  = 1;

@interface ARCollectionViewController ()<UICollectionViewDelegateFlowLayout>

@end

@implementation ARCollectionViewController

static NSString * const reuseIdentifier = @"originalCell";

- (void)awakeFromNib {
 
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.backgroundColor = [UIColor backgroundColor];

    _refreshBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(didRefresh)];
    _refreshBarButton.tintColor = [UIColor whiteColor];
    _refreshBarButton.enabled = YES;
    
    UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([AROriginalCollectionViewCell class]) bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:reuseIdentifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return numberOfSections;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.cells.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AROriginalCollectionViewCell *cell = (AROriginalCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];


    if ( [self isKindOfClass:[ARArtistsViewController class]] ){

        ARAlbum *cellInfo = (ARAlbum*)[self.cells objectAtIndex:indexPath.row];
        [cell configureForArtist:cellInfo];
        
        return cell;
        
    } else if ([self isKindOfClass:[ARAlbumsViewController class]]){
        
        [cell configureForAlbum:[self.cells objectAtIndex:indexPath.row]];
        
        return cell;

    } else {
        return nil;
    }
}

#pragma mark - UICollectionViewController methods

- (void)didRefresh {
    
}

- (void)showRefreshBarButton {
    
    self.navigationItem.rightBarButtonItem = _refreshBarButton;
}

- (void)hideRefreshBarButton {

    self.navigationItem.rightBarButtonItem = nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height/3.3);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
