//
//  HBMarvelService.h
//  HeroicBase
//
//  Created by Rafael Winter on 25/06/17.
//  Copyright © 2017 Rafael Winter. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@class HBCharacter;

/**
 HBMarvelService is a subclass of AFHTTPSessionManager with convenience methods to send requests to the Marvel Comics API backend.
 */
@interface HBMarvelService : AFHTTPSessionManager

/**
 Creates and returns the shared Marvel Comics API webservice connector instance.
 */
+ (instancetype)sharedMarvelService;

@end
