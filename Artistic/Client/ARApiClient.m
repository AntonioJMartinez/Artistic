//
//  ARApiClient.m
//  Artistic
//
//  Created by Antonio J. on 30/05/15.
//  Copyright (c) 2015 Antonio J. Martinez Sanchez. All rights reserved.
//

#import "ARApiClient.h"
#import "ARArtist.h"
#import "ARAlbum.h"
#import "ARItunesResponse.h"
#import "ARCoreDataManager.h"

static NSString * const kBaseURL = @"https://itunes.apple.com/";
static NSString * const kEntityLookupAPICallParameter = @"album";
static NSString * const kMediaLookupAPICallParameter = @"music";

@interface ARApiClient ()

@property (strong, nonatomic, readwrite) NSArray *artistsToLookupArray;

@end


@implementation ARApiClient

#pragma mark - Lifecycle

+ (instancetype)sharedClient {
    static ARApiClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ARApiClient alloc] init];
    });
    
    return _sharedClient;
}


- (instancetype)init {
    ARCoreDataManager *manager = [[ARCoreDataManager alloc] init];
    self.moc = manager.managedObjectContext;
    self = [super initWithBaseURL:[NSURL URLWithString:kBaseURL]
             managedObjectContext: self.moc
             sessionConfiguration:nil];
    
    if (self) {

        _artistsToLookupArray = @[ @{ @"artistId": @"148662", @"limit": @"10"}, @{ @"artistId": @"6906197", @"limit": @"20"}, @{ @"artistId": @"16252655", @"limit": @"7"} ];
    }
    return self;
}

#pragma mark - Requests

- (void)fetchArtistInfoWithParameters:(NSDictionary*)parameters
                      success:(void(^)(NSArray *albums))successBlock
                      failure:(void(^)(NSError *error))failureBlock {

    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [mutableParameters setObject:kEntityLookupAPICallParameter forKey:@"entity"];
    [mutableParameters setObject:kMediaLookupAPICallParameter forKey:@"media"];
    
    [self GET:@"lookup" parameters:mutableParameters.copy completion:^(ARItunesResponse *response, NSError *error) {
        if (!error) {
            NSArray *albums = response.result;
            successBlock(albums);
        } else {
            failureBlock(error);
        }
    }];
}

- (void)fetchAllArtistsInfo:(NSArray*)artistsInfo
                    success:(void(^)(NSArray *albums))successBlock
                    failure:(void(^)(NSError *error))failureBlock {
    
    NSMutableArray *albumsArray = [NSMutableArray array];
    __block NSError *error = nil;
    
    dispatch_group_t group = dispatch_group_create();
    
    for (NSUInteger i = 0; i < self.artistsToLookupArray.count; i++) {

        dispatch_group_enter(group);

        NSString *identifier = [(NSDictionary*)self.artistsToLookupArray[i] objectForKey:@"artistId"];
        NSString *limit = [(NSDictionary*)self.artistsToLookupArray[i] objectForKey:@"limit"];
        
        NSDictionary *APICallParameters = @{ @"id": identifier , @"limit": limit};

        [[ARApiClient sharedClient] fetchArtistInfoWithParameters:APICallParameters success:^(NSArray *albums) {

            for (NSUInteger j = 0; j < albums.count; j++) {
                [albumsArray addObject:albums[j]];
            }
            
            dispatch_group_leave(group);
            
        } failure:^(NSError *errorResponse) {
            
            error = errorResponse;
            dispatch_group_leave(group);
        }];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        if (!error) {
            successBlock(albumsArray.copy);
        } else {
            failureBlock(error);
        }
    });
}

- (void)cancelOperations {
    
    [[self operationQueue] cancelAllOperations];
}

#pragma mark - OVCHTTPSessionManager

+ (NSDictionary *)modelClassesByResourcePath {
    return @{

             @"lookup": [ARAlbum class]
             };
}

+ (Class)responseClass {
    return [ARItunesResponse class];
}

@end
