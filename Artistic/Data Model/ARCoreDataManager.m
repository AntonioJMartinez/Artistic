//
//  ARCoreDataManager.m
//  Artistic
//
//  Created by Antonio J. on 31/05/15.
//  Copyright (c) 2015 Antonio J. Martinez Sanchez. All rights reserved.
//

#import "ARCoreDataManager.h"
#import "ARApiClient.h"

static NSString * const kIdentifierKey = @"identifier";
static NSString * const kArtistIdentifier = @"artistIdentifier";
static NSString * const kReleaseDate = @"releaseDate";
static NSString * const kCollectionIdentifier = @"collectionIdentifier";

@interface ARCoreDataManager ()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) OVCManagedStore *store;
@end

@implementation ARCoreDataManager

#pragma mark - Configuration

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _managedObjectContext.persistentStoreCoordinator = self.store.persistentStoreCoordinator;
    }
    
    return _managedObjectContext;
}

- (OVCManagedStore *)store {
    if (!_store) {
        
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"database" withExtension:@"momd"];
        NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        _store = [OVCManagedStore managedStoreWithModel:managedObjectModel];
    }
    
    return _store;
}

#pragma mark - Core Data Requests

+ (NSFetchRequest *)fetchRequestWithKey:(NSString*)key value:(NSNumber*)value {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Album"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@" %K = %@",key,value];
    [fetchRequest setPredicate:predicate];
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:kReleaseDate
                                                                 ascending:YES];
    [fetchRequest setSortDescriptors:@[descriptor]];
    
    return fetchRequest;
}

+ (NSArray*)getAllData {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Album"];

    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:kReleaseDate
                                                                 ascending:YES];
    [fetchRequest setSortDescriptors:@[descriptor]];
    
    NSError *error = nil;
    
    NSArray *data = [[ARApiClient sharedClient].moc executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        return nil;
    }
    
    return data;
}

+ (NSArray*)getArtistsInfo {
    
    NSError *error = nil;

    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Album"];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Album" inManagedObjectContext:[ARApiClient sharedClient].moc];

    fetchRequest.propertiesToFetch = [NSArray arrayWithObject:kArtistIdentifier];
    fetchRequest.returnsDistinctResults = YES;
    fetchRequest.resultType = NSDictionaryResultType;
    
    NSArray *allArtistsIdentifierArray = [[ARApiClient sharedClient].moc executeFetchRequest:fetchRequest error:&error];
    
    NSSet *identifierSet = [NSSet setWithArray:allArtistsIdentifierArray];
    
    NSArray *artistsIdentifierArray = [identifierSet allObjects];
    
    NSMutableArray *albums = [NSMutableArray array];
    
    for (id artistsIdentifier in artistsIdentifierArray) {
        NSNumber *identifier = [artistsIdentifier objectForKey:kArtistIdentifier];
        [albums addObject:[[self getMostRecentAlbumFromArtistId:identifier] firstObject] ];
    }
    
    if (error) {
        return nil;
    }
    
    return albums;
}

+ (id)getMostRecentAlbumFromArtistId:(NSNumber*)artistsId {
    
    NSError *error = nil;

    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Album"];
    fetchRequest.fetchLimit = 1;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@" %K = %@",kArtistIdentifier,artistsId];
    [fetchRequest setPredicate:predicate];
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:kReleaseDate
                                                                 ascending:NO];
    [fetchRequest setSortDescriptors:@[descriptor]];
    
    NSArray *mostRecentAlbum = [[ARApiClient sharedClient].moc executeFetchRequest:fetchRequest error:&error];

    return mostRecentAlbum;
    
}

+ (NSArray*)getAlbumsFromArtistId:(NSNumber*)artistId {
    
    NSError *error = nil;
    
    NSArray *albums = [[ARApiClient sharedClient].moc executeFetchRequest:[ARCoreDataManager fetchRequestWithKey:kArtistIdentifier value:artistId] error:&error];
    
    if (error) {
        return nil;
    }
    
    return albums;
}

@end
