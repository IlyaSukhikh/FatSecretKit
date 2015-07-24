//
//  FSClient.h
//  Tracker
//
//  Created by Parker Wightman on 11/27/12.
//  Copyright (c) 2012 Mysterious Trousers. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FSFoodSearchBlock)(NSArray *foods, NSInteger maxResults, NSInteger totalResults, NSInteger pageNumber);
typedef void(^FSRecipeSearchBlock)(NSArray *recipes, NSString *recipeType, NSInteger maxResults, NSInteger totalResults, NSInteger pageNumber);
typedef void(^FSBarcodeSearchBlock)(NSInteger identifier);

@class FSFood;
@class FSRecipe;

@interface FSClient : NSObject

@property (nonatomic, strong) NSString *oauthConsumerKey;
@property (nonatomic, strong) NSString *oauthConsumerSecret;


- (void)searchFoods:(NSString *)foodText
         pageNumber:(NSInteger)pageNumber
         maxResults:(NSInteger)maxResults
         completion:(FSFoodSearchBlock)completionBlock;

- (void)searchFoods:(NSString *)foodText
         completion:(FSFoodSearchBlock)completionBlock;

- (void)getFood:(NSInteger)foodId
     completion:(void (^)(FSFood *food))completionBlock;

-(void)searchRecipes:(NSString *)recipeText
          recipeType:(NSString *)recipeType
          pageNumber:(NSInteger)pageNumber
          maxResults:(NSInteger)maxResults
          completion:(FSRecipeSearchBlock)completionBlock;

-(void)getRecipe:(NSInteger)recipeId
      completion:(void (^)(FSRecipe *recipe))completionBlock;


//your fat_secret account must have access to this method,
//otherwise you get method not found error
//returns food_id = 0 if product for barcode not found
//or barcode incorrect format
- (void)searchBarcode:(NSString *)barcode
           completion:(FSBarcodeSearchBlock)completionBlock;

+ (FSClient *)sharedClient;

@end
