//
//  FSRecipeServings.h
//  FatSecretKit
//
//  Created by Poulose Matthen on 13/08/14.
//  Copyright (c) 2014 Mysterious Trousers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSRecipeServings : NSObject

- (id) initWithJSON:(NSDictionary *)json;
+ (id) recipeServingWithJSON:(NSDictionary *)json;

@property (nonatomic, strong, readonly) NSString *servingSize;

//Decimals
@property (nonatomic, strong, readonly) NSNumber *calories;
@property (nonatomic, strong, readonly) NSNumber *carbohydrate;
@property (nonatomic, strong, readonly) NSNumber *protein;
@property (nonatomic, strong, readonly) NSNumber *fat;
@property (nonatomic, strong, readonly) NSNumber *saturatedFat;
@property (nonatomic, strong, readonly) NSNumber *polyunsaturatedFat;
@property (nonatomic, strong, readonly) NSNumber *monounsaturatedFat;
@property (nonatomic, strong, readonly) NSNumber *transFat;
@property (nonatomic, strong, readonly) NSNumber *cholesterol;
@property (nonatomic, strong, readonly) NSNumber *sodium;
@property (nonatomic, strong, readonly) NSNumber *potassium;
@property (nonatomic, strong, readonly) NSNumber *fiber;
@property (nonatomic, strong, readonly) NSNumber *sugar;

// Ints
@property (nonatomic, strong, readonly) NSNumber *vitaminC;
@property (nonatomic, strong, readonly) NSNumber *vitaminA;
@property (nonatomic, strong, readonly) NSNumber *calcium;
@property (nonatomic, strong, readonly) NSNumber *iron;

// Nutrient Info
- (CGFloat) caloriesValue;
- (CGFloat) carbohydrateValue;
- (CGFloat) proteinValue;
- (CGFloat) fatValue;
- (CGFloat) saturatedFatValue;
- (CGFloat) polyunsaturatedFatValue;
- (CGFloat) monounsaturatedFatValue;
- (CGFloat) transFatValue;
- (CGFloat) cholesterolValue;
- (CGFloat) sodiumValue;
- (CGFloat) potassiumValue;
- (CGFloat) fiberValue;
- (CGFloat) sugarValue;
- (NSInteger) vitaminCValue;
- (NSInteger) vitaminAValue;
- (NSInteger) calciumValue;
- (NSInteger) ironValue;

@end
