//
//  FSClient.m
//  Tracker
//
//  Created by Parker Wightman on 11/27/12.
//  Copyright (c) 2012 Mysterious Trousers. All rights reserved.
//

#import "FSClient.h"
#import <CommonCrypto/CommonHMAC.h>
#import "OAuthCore.h"
#import <SVHTTPRequest/SVHTTPRequest.h>
#import "FSFood.h"
#import "FSRecipe.h"

#define FAT_SECRET_API_ENDPOINT @"http://platform.fatsecret.com/rest/server.api"


@implementation FSClient

- (void)searchFoods:(NSString *)foodText
         pageNumber:(NSInteger)pageNumber
         maxResults:(NSInteger)maxResults
         completion:(FSFoodSearchBlock)completionBlock {

    NSMutableDictionary *params = [@{
        @"search_expression" : foodText,
        @"page_number"       : @(pageNumber),
        @"max_results"       : @(maxResults)
    } mutableCopy];

    [self makeRequestWithMethod:@"foods.search" parameters:params completion:^(NSDictionary *response) {
        NSMutableArray *foods = [@[] mutableCopy];

        
        //fix weird response with error in nsdata
        if([response isKindOfClass:[NSData class]]){
            NSString *str = [[NSString alloc] initWithData:(NSData *)response encoding:NSUTF8StringEncoding];
            NSLog(@"Error: %@",str);
            return completionBlock(@[], 0, 0, 0);
        }
        
        id responseFoods = [response objectForKey:@"foods"];

        // Hack because the API sends JSON objects, instead of arrays, when there is only
        // one result. (WTF?)
        if ([[responseFoods objectForKey:@"food"] respondsToSelector:@selector(arrayByAddingObject:)]) {
            for (NSDictionary *food in [responseFoods objectForKey:@"food"]) {
                [foods addObject:[FSFood foodWithJSON:food]];
            }
        } else {
            if ([[responseFoods objectForKey:@"food"] count] == 0) {
                foods = [@[] mutableCopy];
            } else {
                foods = [@[ [FSFood foodWithJSON:[responseFoods objectForKey:@"food"]] ] mutableCopy];
            }
        }
        
        NSInteger maxResults   = [[[response objectForKey:@"foods"] objectForKey:@"max_results"]   integerValue];
        NSInteger totalResults = [[[response objectForKey:@"foods"] objectForKey:@"total_results"] integerValue];
        NSInteger pageNumber   = [[[response objectForKey:@"foods"] objectForKey:@"page_number"]   integerValue];
        
        completionBlock(foods, maxResults, totalResults, pageNumber);
    }];
}

- (void)searchFoods:(NSString *)foodText completion:(FSFoodSearchBlock)completionBlock {
    [self searchFoods:foodText
           pageNumber:0
           maxResults:20
           completion:completionBlock];
}

- (void)getFood:(NSInteger)foodId completion:(void (^)(FSFood *food))completionBlock {
    NSDictionary *params = @{@"food_id" : @(foodId)};

    [self makeRequestWithMethod:@"food.get"
                     parameters:params
                     completion:^(NSDictionary *data) {
                         completionBlock([FSFood foodWithJSON:[data objectForKey:@"food"]]);
                     }];
}

- (void)searchRecipes:(NSString *)recipeText
           recipeType:(NSString *)recipeType
           pageNumber:(NSInteger)pageNumber
           maxResults:(NSInteger)maxResults
           completion:(FSRecipeSearchBlock)completionBlock {
    
    NSMutableDictionary *params = [@{
                                     @"search_expression" : recipeText,
                                     @"recipe_type"       : recipeType,
                                     @"page_number"       : @(pageNumber),
                                     @"max_results"       : @(maxResults)
                                     } mutableCopy];
    
    [self makeRequestWithMethod:@"recipes.search" parameters:params completion:^(NSDictionary *response) {
        NSMutableArray *recipes = [@[] mutableCopy];
        
        
        
        //fix weird response with error in nsdata
        if([response isKindOfClass:[NSData class]]){
            NSString *str = [[NSString alloc] initWithData:(NSData *)response encoding:NSUTF8StringEncoding];
            NSLog(@"Error: %@",str);
            return completionBlock(@[],@"", 0, 0, 0);
        }
        
        id responseRecipes = [response objectForKey:@"recipes"];
        
        // Hack because the API sends JSON objects, instead of arrays, when there is only
        // one result. (WTF?)
        if ([[responseRecipes objectForKey:@"recipe"] respondsToSelector:@selector(arrayByAddingObject:)]) {
            for (NSDictionary *recipe in [responseRecipes objectForKey:@"recipe"]) {
                [recipes addObject:[FSRecipe recipeWithJSON:recipe]];
            }
        } else {
            if ([[responseRecipes objectForKey:@"recipe"] count] == 0) {
                recipes = [@[] mutableCopy];
            } else {
                recipes = [@[ [FSRecipe recipeWithJSON:[responseRecipes objectForKey:@"recipe"]] ] mutableCopy];
            }
        }
        
        NSString *recipeType   = [[response objectForKey:@"recipes"] objectForKey:@"recipe_type"];
        NSInteger maxResults   = [[[response objectForKey:@"recipes"] objectForKey:@"max_results"]   integerValue];
        NSInteger totalResults = [[[response objectForKey:@"recipes"] objectForKey:@"total_results"] integerValue];
        NSInteger pageNumber   = [[[response objectForKey:@"recipes"] objectForKey:@"page_number"]   integerValue];
        
        completionBlock(recipes, recipeType, maxResults, totalResults, pageNumber);
    }];
}

-(void)getRecipe:(NSInteger)recipeId completion:(void (^)(FSRecipe *recipe))completionBlock {
    NSDictionary *params = @{@"recipe_id" : @(recipeId)};
    
    [self makeRequestWithMethod:@"recipe.get"
                     parameters:params
                     completion:^(NSDictionary *data) {
                         completionBlock([FSRecipe recipeWithJSON:[data objectForKey:@"recipe"]]);
                     }];
}


- (void) makeRequestWithMethod:(NSString *)method
                    parameters:(NSDictionary *)params
                    completion:(void (^)(NSDictionary *data))completionBlock {

    NSMutableDictionary *parameters = [params mutableCopy];
    [parameters addEntriesFromDictionary:[self defaultParameters]];
    [parameters addEntriesFromDictionary:@{ @"method" : method }];

    NSString *queryString = [self queryStringFromDictionary:parameters];
    NSData *data          = [NSData dataWithBytes:[queryString UTF8String] length:queryString.length];
    NSString *authHeader  = OAuthorizationHeader([NSURL URLWithString:FAT_SECRET_API_ENDPOINT], 
                                                 @"GET", 
                                                 data, 
                                                 _oauthConsumerKey, 
                                                 _oauthConsumerSecret, 
                                                 nil, 
                                                 @"");

    [SVHTTPRequest GET:[FAT_SECRET_API_ENDPOINT stringByAppendingFormat:@"?%@", authHeader]
            parameters:nil
            completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
                completionBlock(response);
    }];

}

- (NSDictionary *) defaultParameters {
    return @{ @"format": @"json" };
}

- (NSString *) queryStringFromDictionary:(NSDictionary *)dict {
    NSMutableArray *entries = [@[] mutableCopy];

    for (NSString *key in dict) {
        NSString *value = [dict objectForKey:key];
        [entries addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
    }

    return [entries componentsJoinedByString:@"&"];
}

static FSClient *_sharedClient = nil;

+ (FSClient *)sharedClient {
    if (!_sharedClient) {
        _sharedClient = [[FSClient alloc] init];
    }

    return _sharedClient;
}

@end
