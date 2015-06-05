//
//  ARArtist.h
//  Artistic
//
//  Created by Antonio J. on 30/05/15.
//  Copyright (c) 2015 Antonio J. Martinez Sanchez. All rights reserved.
//

#import "MTLModel.h"

@interface ARArtist : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *identifier;

@end
