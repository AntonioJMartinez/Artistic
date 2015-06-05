//
//  ARAlbum.m
//  Artistic
//
//  Created by Antonio J. on 30/05/15.
//  Copyright (c) 2015 Antonio J. Martinez Sanchez. All rights reserved.
//

#import "ARAlbum.h"

@implementation ARAlbum

#pragma mark - MTLJSONSerializing

+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{
             @"identifier": @"collectionId",
             @"title": @"collectionName",
             @"coverURL": @"artworkUrl100",
             @"releaseDate": @"releaseDate",
             @"artistIdentifier": @"artistId",
             @"artistName": @"artistName"
            };
}

+ (NSDateFormatter*)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    return dateFormatter;
}
+ (NSValueTransformer *)releaseDateJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        NSDate *date = [self.dateFormatter dateFromString:str];
        return date;
    } reverseBlock:^(NSDate *date) {
        NSString *dateString = [self.dateFormatter stringFromDate:date];
        return dateString;
    }];
}

#pragma mark - MTLManagedObjectSerializing

+ (NSString *)managedObjectEntityName {
    return @"Album";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"identifier"];
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return @{
//             @"artist": [ARArtist class]
            };
}

@end
