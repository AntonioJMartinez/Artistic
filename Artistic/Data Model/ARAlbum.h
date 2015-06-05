//
//  ARAlbum.h
//  Artistic
//
//  Created by Antonio J. on 30/05/15.
//  Copyright (c) 2015 Antonio J. Martinez Sanchez. All rights reserved.
//

#import "MTLModel.h"
#import "ARArtist.h"

@interface ARAlbum : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, copy, readonly) NSNumber *identifier;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *coverURL;
@property (nonatomic, copy, readonly) NSString *releaseDate;

@property (nonatomic, copy, readonly) NSNumber *artistIdentifier;
@property (nonatomic, copy, readonly) NSString *artistName;

//@property (nonatomic, strong) ARArtist *artist;

@end
