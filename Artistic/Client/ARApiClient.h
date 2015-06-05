//
//  ARApiClient.h
//  Artistic
//
//  Created by Antonio J. on 30/05/15.
//  Copyright (c) 2015 Antonio J. Martinez Sanchez. All rights reserved.
//

#import "OVCHTTPSessionManager.h"

@class ACAccount;

@interface ARApiClient : OVCHTTPSessionManager


@property (nonatomic, strong) NSManagedObjectContext *moc;

@property (strong, nonatomic, readonly) NSArray *artistsToLookupArray;

@property (assign, nonatomic) NSUInteger saveDataCount;

// Init
+ (instancetype)sharedClient;

// Requests
- (void)fetchArtistInfoWithParameters:(NSDictionary*)parameters
                      success:(void(^)(NSArray *albums))successBlock
                      failure:(void(^)(NSError *error))failureBlock;
- (void)fetchAllArtistsInfo:(NSArray*)artistsInfo
                    success:(void(^)(NSArray *albums))successBlock
                    failure:(void(^)(NSError *error))failureBlock;

- (void)cancelOperations;

@end
