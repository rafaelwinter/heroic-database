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

@end
