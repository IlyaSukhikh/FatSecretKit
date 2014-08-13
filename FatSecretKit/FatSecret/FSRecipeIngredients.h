//
//  FSRecipeIngredients.h
//  FatSecretKit
//
//  Created by Poulose Matthen on 13/08/14.
//  Copyright (c) 2014 Mysterious Trousers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSRecipeIngredients : NSObject

- (id) initWithJSON:(NSDictionary *)json;
+ (id) recipeIngredientsWithJSON:(NSDictionary *)json;

@property (nonatomic, strong, readonly) NSString *foodName;
@property (nonatomic, strong, readonly) NSString *measurementDescription;
@property (nonatomic, strong, readonly) NSString *ingredientUrl;
@property (nonatomic, strong, readonly) NSString *ingredientDescription;

@property (nonatomic, strong, readonly) NSNumber *foodId;
@property (nonatomic, strong, readonly) NSNumber *servingId;
@property (nonatomic, strong, readonly) NSNumber *numberOfUnits;

- (NSInteger) foodIdValue;
- (NSInteger) servingIdValue;
- (NSInteger) numberOfUnitsValue;

@end
