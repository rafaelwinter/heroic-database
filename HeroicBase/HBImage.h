//
//  HBImage.h
//  HeroicBase
//
//  Created by Rafael Winter on 26/06/17.
//  Copyright © 2017 Rafael Winter. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HBImage : JSONModel

/**
 The directory path of to the image.
 */
@property (strong, nonatomic) NSString *path;

/**
 The file extension for the image.
 */
@property (strong, nonatomic) NSString *extension;

/**
 The full path to a medium square image variant.
 */
@property (readonly, nonatomic) NSString <Ignore> *standardMediumPath;

/**
 The full path to a large landscape image variant.
 */
@property (readonly, nonatomic) NSString <Ignore> *landscapeIncrediblePath;

@end
