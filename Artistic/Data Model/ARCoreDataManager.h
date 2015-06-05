//
//  ARCoreDataManager.h
//  Artistic
//
//  Created by Antonio J. on 31/05/15.
//  Copyright (c) 2015 Antonio J. Martinez Sanchez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARCoreDataManager : NSObject

@property (strong, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

+ (NSFetchRequest *)fetchRequestWithKey:(NSString*)key value:(NSNumber*)value;

+ (NSArray*)getAllData;

+ (NSArray*)getArtistsInfo;

+ (NSArray*)getAlbumsFromArtistId:(NSNumber*)artistId;

@end
