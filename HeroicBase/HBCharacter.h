//
//  HBCharacter.h
//  HeroicBase
//
//  Created by Rafael Winter on 25/06/17.
//  Copyright © 2017 Rafael Winter. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class HBImage;

@interface HBCharacter : JSONModel

/**
 The unique ID of the character resource.
 */
@property (assign, nonatomic) NSInteger characterId;


/**
 The name of the character.
 */
@property (strong, nonatomic) NSString *name;


/**
 A short bio or description of the character.
 */
@property (strong, nonatomic) NSString *shortBio;


/**
 The representative image for this character.
 */
@property (strong, nonatomic) HBImage <Optional> *thumbnail;

@end
