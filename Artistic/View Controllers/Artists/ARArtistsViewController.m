//
//  ARArtistsViewController.m
//  Artistic
//
//  Created by Antonio J. on 28/05/15.
//  Copyright (c) 2015 Antonio J. Martinez Sanchez. All rights reserved.
//

#import "ARArtistsViewController.h"
#import "ARAlbumsViewController.h"
#import "ARApiClient.h"
#import "AROriginalCollectionViewCell.h"
#import "ARCoreDataManager.h"
#import "ARAlbum.h"
#import "UIAlertController+AJ.h"

@interface ARArtistsViewController ()

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation ARArtistsViewController

#pragma mark - Life View Cycle

- (void)awakeFromNib {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(didRefresh)
             forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:_refreshControl];
    
    [self fetchAllArtistsInfo];
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

#pragma mark - UIContentContainer Protocol methods

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [self.collectionView.collectionViewLayout invalidateLayout];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self.collectionView performBatchUpdates:nil completion:nil];
    }];  
}

#pragma mark - ARArtistsViewController methods

- (void)fetchAllArtistsInfo {
    
    [[ARApiClient sharedClient] cancelOperations];
    
    [[ARApiClient sharedClient] fetchAllArtistsInfo:@[] success:^(NSArray *albums) {
        
        [self loadCells];
        [self hideRefreshBarButton];
        
    } failure:^(NSError *error) {
        
        [self showRefreshBarButton];
        [self showErrorAlert];
    }];
}

- (void)loadCells {
    
    self.cells = nil;

    NSArray *albumsArray = [ARCoreDataManager getArtistsInfo];
    
    self.cells = albumsArray ;
    [self.collectionView reloadData];
}

- (void)didRefresh {
    
    [self fetchAllArtistsInfo];
    
    [self.refreshControl endRefreshing];
}

- (void)showErrorAlert {
    
    [UIAlertController showBasicAlertWithTitle:@"Uups" message:@"Seems like there was a trouble retrieving the data. Check your internet connection out and try again later!" buttonTitle:@"Ok" buttonAction:nil buttonTarget:self onViewController:self];
}

 #pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     if ([[segue identifier] isEqualToString:segueToAlbums]) {
         
         [[ARApiClient sharedClient] cancelOperations];
         
         ARAlbumsViewController *vc = (ARAlbumsViewController*)segue.destinationViewController;
         ARAlbum *album = (ARAlbum*)sender;
         if ( sender != nil) {
             vc.title = album.artistName;
             vc.artistIdentifier = album.artistIdentifier;
         }
     }
 }


#pragma mark - UICollectionViewDelegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    
    AROriginalCollectionViewCell *cell = nil;
    
    if ([[collectionView cellForItemAtIndexPath:indexPath] isKindOfClass:[AROriginalCollectionViewCell class]]) {
        
         cell = (AROriginalCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    }

    [self performSegueWithIdentifier:segueToAlbums sender:[self.cells objectAtIndex:indexPath.row]];
}

@end
