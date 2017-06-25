//
//  HBCharacter.m
//  HeroicBase
//
//  Created by Rafael Winter on 25/06/17.
//  Copyright © 2017 Rafael Winter. All rights reserved.
//

#import "HBCharacter.h"

@implementation HBCharacter

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
        @"characterId": @"id",
        @"name": @"name",
        @"shortBio": @"description",
    }];
}

@end
