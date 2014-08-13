//
//  FSRecipeServings.m
//  FatSecretKit
//
//  Created by Poulose Matthen on 13/08/14.
//  Copyright (c) 2014 Mysterious Trousers. All rights reserved.
//

#import "FSRecipeServings.h"
#import "NSString+Camelize.h"


@implementation FSRecipeServings

- (id) initWithJSON:(NSDictionary *)json {
    self = [super init];
    
    if (self) {
        for (NSString *key in json) {
            id value = [json objectForKey:key];
            [self setValue:value forKey:[key camelize]];
        }
    }
    
    return self;
}

+ (id) recipeServingWithJSON:(NSDictionary *)json {
    return [[self alloc] initWithJSON:json];
}

// Nutrient Info - Floats
- (CGFloat) caloriesValue {
    return [_calories floatValue];
}
- (CGFloat) carbohydrateValue {
    return [_carbohydrate floatValue];
}
- (CGFloat) proteinValue {
    return [_protein floatValue];
}
- (CGFloat) fatValue {
    return [_fat floatValue];
}
- (CGFloat) saturatedFatValue {
    return [_saturatedFat floatValue];
}
- (CGFloat) polyunsaturatedFatValue {
    return [_polyunsaturatedFat floatValue];
}
- (CGFloat) monounsaturatedFatValue {
    return [_monounsaturatedFat floatValue];
}
- (CGFloat) transFatValue {
    return [_transFat floatValue];
}
- (CGFloat) cholesterolValue {
    return [_cholesterol floatValue];
}
- (CGFloat) sodiumValue {
    return [_sodium floatValue];
}
- (CGFloat) potassiumValue {
    return [_potassium floatValue];
}
- (CGFloat) fiberValue {
    return [_fiber floatValue];
}
- (CGFloat) sugarValue {
    return [_sugar floatValue];
}

// Nutrient Info - Ints
- (NSInteger) vitaminCValue {
    return [_vitaminC integerValue];
}
- (NSInteger) vitaminAValue {
    return [_vitaminA integerValue];
}
- (NSInteger) calciumValue {
    return [_calcium integerValue];
}
- (NSInteger) ironValue {
    return [_iron integerValue];
}


@end
