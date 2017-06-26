//
//  HBMarvelService.h
//  HeroicBase
//
//  Created by Rafael Winter on 25/06/17.
//  Copyright © 2017 Rafael Winter. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@class HBCharacter;
@class HBCharacterDataWrapper;

typedef void (^HBCharacterRequestSuccess)(HBCharacterDataWrapper *response);
typedef void (^HBCharacterRequestFailure)(NSError *error);

/**
 HBMarvelService is a subclass of AFHTTPSessionManager with convenience methods to send requests to the Marvel Comics API backend.
 */
@interface HBMarvelService : AFHTTPSessionManager

/**
 Creates and returns the shared Marvel Comics API webservice connector instance.
 */
+ (instancetype)sharedMarvelService;

/**
 Fetches lists of Marvel comics characters.
 
 @param successBlock A block that is executed when the task finishes successfully.
 @param failureBlock A block that is executed when the task finishes with error.
 @return A NSURLSessionDataTask object with the request
 */
- (NSURLSessionDataTask *)characterListWithTimestamp:(NSTimeInterval)timestamp
                                              APIKey:(NSString *)publicKey
                                                hash:(NSString *)hash
                                             success:(HBCharacterRequestSuccess)successBlock
                                             failure:(HBCharacterRequestFailure)failureBlock;

/**
 Fetches lists of Marvel comics characters.
 
 @param successBlock A block that is executed when the task finishes successfully.
 @param failureBlock A block that is executed when the task finishes with error.
 @return A NSURLSessionDataTask object with the request
 */
- (NSURLSessionDataTask *)characterListWithSuccess:(HBCharacterRequestSuccess)successBlock
                                           failure:(HBCharacterRequestFailure)failureBlock;

@end
