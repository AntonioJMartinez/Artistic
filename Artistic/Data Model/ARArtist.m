//
//  ARArtist.m
//  Artistic
//
//  Created by Antonio J. on 30/05/15.
//  Copyright (c) 2015 Antonio J. Martinez Sanchez. All rights reserved.
//

#import "ARArtist.h"

@implementation ARArtist

#pragma mark - MTLJSONSerializing

+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{
             @"name": @"artistName",
             @"identifier": @"artistId"
            };
}

+ (NSValueTransformer *)nameJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)artistIdJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

#pragma mark - MTLManagedObjectSerializing

+ (NSString *)managedObjectEntityName {
    return @"Artist";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"identifier"];
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return @{

             };
}
@end
