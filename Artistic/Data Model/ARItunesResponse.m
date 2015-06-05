//
//  ARItunesResponse.m
//  Artistic
//
//  Created by Antonio J. on 30/05/15.
//  Copyright (c) 2015 Antonio J. Martinez Sanchez. All rights reserved.
//

#import "ARItunesResponse.h"
#import "NSDictionary+Overcoat.h"

@interface ARItunesResponse ()
//
@property (strong, nonatomic, readwrite) NSHTTPURLResponse *HTTPResponse;
@property (strong, nonatomic, readwrite) id result;

@end

@implementation ARItunesResponse

+ (NSString *)resultKeyPathForJSONDictionary:(NSDictionary *)JSONDictionary {
    return @"results";
}

+ (instancetype)responseWithHTTPResponse:(NSHTTPURLResponse *)HTTPResponse
                              JSONObject:(id)JSONObject
                             resultClass:(Class)resultClass {
 
    ARItunesResponse *response = nil;
    id result = JSONObject;
    
    if ([JSONObject isKindOfClass:[NSDictionary class]]) {
        response = [MTLJSONAdapter modelOfClass:self fromJSONDictionary:JSONObject error:NULL];
        NSString *resultKeyPath = [[response class] resultKeyPathForJSONDictionary:JSONObject];
        if (resultKeyPath) {
            result = [(NSDictionary *)JSONObject ovc_objectForKeyPath:resultKeyPath];
        } else {
            response = [[self alloc] init];
        }
    } else {
        response = [[self alloc] init];
    }
    
    if (response == nil) {
        return nil;
    }
    
    response.HTTPResponse = HTTPResponse;
    
    if (result != nil) {
        if (resultClass != Nil) {
            NSValueTransformer *valueTransformer = nil;
            
            if ([result isKindOfClass:[NSDictionary class]]) {
                valueTransformer = [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:resultClass];
            } else if ([result isKindOfClass:[NSArray class]]) {
                valueTransformer = [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:resultClass];
            }
            
            result = [valueTransformer transformedValue:result];
        }
        
        response.result = result;
    }
    
    return response;

}

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"HTTPResponse": [NSNull null],
             @"result": [NSNull null]
             };
}
@end
