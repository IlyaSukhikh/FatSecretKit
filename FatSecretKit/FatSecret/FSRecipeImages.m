//
//  FSRecipeImages.m
//  FatSecretKit
//
//  Created by Poulose Matthen on 13/08/14.
//  Copyright (c) 2014 Mysterious Trousers. All rights reserved.
//

#import "FSRecipeImages.h"
#import "NSString+Camelize.h"


@implementation FSRecipeImages

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

+ (id) recipeImagesWithJSON:(NSDictionary *)json {
    return [[self alloc] initWithJSON:json];
}

@end
