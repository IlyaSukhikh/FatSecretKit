//
//  FSRecipe.m
//  FatSecretKit
//
//  Created by Poulose Matthen on 12/08/14.
//  Copyright (c) 2014 Mysterious Trousers. All rights reserved.
//

#import "FSRecipe.h"
#import "FSRecipeServings.h"
#import "FSRecipeIngredients.h"
#import "FSRecipeDirections.h"
#import "FSRecipeImages.h"


@implementation FSRecipe

- (id) initWithJSON:(NSDictionary *)json {
    self = [super init];
    if (self) {
        _name               = [json objectForKey:@"recipe_name"];
        _recipeDescription  = [json objectForKey:@"recipe_description"];
        _url                = [json objectForKey:@"recipe_url"];
        _imageUrl           = [json objectForKey:@"recipe_image"];
        _recipeCategoryName = [json objectForKey:@"recipe_category_name"];
        _recipeType         = [json objectForKey:@"recipe_type"];
        _recipeImage        = [(NSDictionary *)[json objectForKey:@"recipe_images"] objectForKey:@"recipe_image"];
        _identifier         = [[json objectForKey:@"recipe_id"] integerValue];
        _numberOfServings   = [[json objectForKey:@"number_of_servings"] integerValue];
        _preparationTimeMin = [[json objectForKey:@"preparation_time_min"] integerValue];
        _cookingTimeMin     = [[json objectForKey:@"cooking_time_min"] integerValue];
        _rating             = [[json objectForKey:@"rating"] integerValue];

        
        id servings = [json objectForKey:@"serving_sizes"];
        
        _servings = @[];
        
        if (servings) {
            servings = [servings objectForKey:@"serving"];
            
            // This is a hack to figure out if servings is an array or a dictionary
            // since the API returns a dictionary if there's only one serving (WTF?)
            if ([servings respondsToSelector:@selector(arrayByAddingObject:)]) {
                NSMutableArray *array = [@[] mutableCopy];
                for (NSDictionary *serving in servings) {
                    [array addObject:[FSRecipeServings recipeServingWithJSON:serving]];
                }
                _servings = array;
            } else {
                if ([servings count] == 0) {
                    _servings = @[];
                } else {
                    _servings = @[ [FSRecipeServings recipeServingWithJSON:servings] ];
                }
            }
        }
        
        id ingredients = [json objectForKey:@"ingredients"];
        
        _ingredients = @[];
        
        if (ingredients) {
            ingredients = [ingredients objectForKey:@"ingredient"];
            
            if ([ingredients respondsToSelector:@selector(arrayByAddingObject:)]) {
                NSMutableArray * array = [@[] mutableCopy];
                for (NSDictionary *ingredient in ingredients) {
                    [array addObject:[FSRecipeIngredients recipeIngredientsWithJSON:ingredient]];
                }
                _ingredients = array;
            } else {
                if ([ingredients count] == 0) {
                    _ingredients = @[];
                } else {
                    _ingredients = @[ [FSRecipeIngredients recipeIngredientsWithJSON:ingredients] ];
                }
            }
        }
        
        id directions = [json objectForKey:@"directions"];
        
        _directions = @[];
        
        if (directions) {
            directions = [directions objectForKey:@"direction"];
            
            if ([directions respondsToSelector:@selector(arrayByAddingObject:)]) {
                NSMutableArray * array = [@[] mutableCopy];
                for (NSDictionary *direction in directions) {
                    [array addObject:[FSRecipeDirections recipeDirectionsWithJSON:direction]];
                }
                _directions = array;
            } else {
                if ([directions count] == 0) {
                    _directions = @[];
                } else {
                    _directions = @[ [FSRecipeDirections recipeDirectionsWithJSON:directions] ];
                }
            }
        }
    }
    
    return self;
}

+ (id) recipeWithJSON:(NSDictionary *)json {
    return [[self alloc] initWithJSON:json];
}


@end
