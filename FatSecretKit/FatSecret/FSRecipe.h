//
//  FSRecipe.h
//  FatSecretKit
//
//  Created by Poulose Matthen on 12/08/14.
//  Copyright (c) 2014 Mysterious Trousers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSRecipe : NSObject

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *recipeDescription;
@property (nonatomic, strong, readonly) NSString *url;
@property (nonatomic, strong, readonly) NSString *imageUrl;
@property (nonatomic, strong, readonly) NSString *recipeCategoryName;
@property (nonatomic, strong, readonly) NSString *recipeType;
@property (nonatomic, strong, readonly) NSString *recipeImage;
@property (nonatomic, assign, readonly) NSInteger identifier;
@property (nonatomic, assign, readonly) NSInteger numberOfServings;
@property (nonatomic, assign, readonly) NSInteger preparationTimeMin;
@property (nonatomic, assign, readonly) NSInteger cookingTimeMin;
@property (nonatomic, assign, readonly) NSInteger rating;

@property (nonatomic, strong, readonly) NSArray *servings;
@property (nonatomic, strong, readonly) NSArray *ingredients;
@property (nonatomic, strong, readonly) NSArray *directions;

+ (id) recipeWithJSON:(NSDictionary *)json;

@end
