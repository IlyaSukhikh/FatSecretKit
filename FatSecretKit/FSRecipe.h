//
//  FSRecipe.h
//  FatSecretKit
//
//  Created by Poulose Matthen on 12/08/14.
//  Copyright (c) 2014 Mysterious Trousers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSRecipe : NSObject

@property (nonatomic, strong, readonly) NSString *recipeDescription;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *url;
@property (nonatomic, strong, readonly) NSString *imageUrl;
@property (nonatomic, assign, readonly) NSInteger identifier;

@end
