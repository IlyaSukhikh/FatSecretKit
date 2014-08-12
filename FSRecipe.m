//
//  FSRecipe.m
//  FatSecretKit
//
//  Created by Poulose Matthen on 12/08/14.
//  Copyright (c) 2014 Mysterious Trousers. All rights reserved.
//

#import "FSRecipe.h"

@implementation FSRecipe

- (id) initWithJSON:(NSDictionary *)json {
    self = [super init];
    if (self) {
        _name            = [json objectForKey:@"recipe_name"];
        _recipeDescription = [json objectForKey:@"recipe_description"];
        _url             = [json objectForKey:@"recipe_url"];
        _identifier      = [[json objectForKey:@"recipe_id"] integerValue];
        _imageUrl       = [json objectForKey:@"recipe_image"];
    }
    
    return self;
}

+ (id) recipeWithJSON:(NSDictionary *)json {
    return [[self alloc] initWithJSON:json];
}


@end

