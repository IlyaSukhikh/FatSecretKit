//
//  FSRecipeDirections.h
//  FatSecretKit
//
//  Created by Poulose Matthen on 13/08/14.
//  Copyright (c) 2014 Mysterious Trousers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSRecipeDirections : NSObject

- (id) initWithJSON:(NSDictionary *)json;
+ (id) recipeDirectionsWithJSON:(NSDictionary *)json;

@property (nonatomic, strong, readonly) NSNumber *directionNumber;
@property (nonatomic, strong, readonly) NSString *directionDescription;

- (NSInteger) directionNumberValue;

@end
