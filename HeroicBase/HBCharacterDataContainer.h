//
//  HBCharacterDataContainer.h
//  HeroicBase
//
//  Created by Rafael Winter on 25/06/17.
//  Copyright © 2017 Rafael Winter. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HBCharacterDataContainer : JSONModel

/**
 The requested offset (number of skipped results) of the call.
 */
@property (assign, nonatomic) NSInteger offset;

/**
 The requested result limit.
 */
@property (assign, nonatomic) NSInteger limit;

/**
 The total number of resources available given the current filter set.
 */
@property (assign, nonatomic) NSInteger total;

/**
 The total number of results returned by this call.
 */
@property (assign, nonatomic) NSInteger count;

/**
 The list of characters returned by the call.
 */
@property (strong, nonatomic) NSArray <id> *results;

@end
