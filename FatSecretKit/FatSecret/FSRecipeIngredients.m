//
//  FSRecipeIngredients.m
//  FatSecretKit
//
//  Created by Poulose Matthen on 13/08/14.
//  Copyright (c) 2014 Mysterious Trousers. All rights reserved.
//

#import "FSRecipeIngredients.h"
#import "NSString+Camelize.h"


@implementation FSRecipeIngredients

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

+ (id) recipeIngredientsWithJSON:(NSDictionary *)json {
    return [[self alloc] initWithJSON:json];
}

- (NSInteger) foodIdValue {
    return [_foodId integerValue];
}

- (NSInteger) servingIdValue {
    return [_servingId integerValue];
}

- (NSInteger) numberOfUnitsValue {
    return [_numberOfUnits integerValue];
}

@end
