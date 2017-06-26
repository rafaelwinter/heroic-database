//
//  HBMarvelService.m
//  HeroicBase
//
//  Created by Rafael Winter on 25/06/17.
//  Copyright © 2017 Rafael Winter. All rights reserved.
//

#import <MD5Digest/NSString+MD5.h>

#import "HBMarvelService.h"
#import "HBCharacterDataWrapper.h"

static NSString *const kApiKeysFile = @"apikeys";
static NSString *const kPublicKeyName = @"HBMarvelServicePublicKey";
static NSString *const kPrivateKeyName = @"HBMarvelServicePrivateKey";
static NSString *const kBaseURL = @"https://gateway.marvel.com/v1/public/";
static NSString *const kCharactersResource = @"characters";

@interface HBMarvelService ()

/**
 The public Marvel Comics API key.
 
 @discussion This key is retrieved from the apikeys.plist file.
 */
@property (strong, nonatomic) NSString *publicAPIKey;

/**
 The private Marvel Comics API key.
 
 @discussion This key is retrieved from the apikeys.plist file.
 */
@property (strong, nonatomic) NSString *privateAPIKey;

@end

@implementation HBMarvelService

+ (instancetype)sharedMarvelService {
    static HBMarvelService *_service = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _service = [[self alloc] init];
    });
    
    return _service;
}

- (instancetype)init {
    self = [super initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    if (!self) {
        return nil;
    }
    
    [self loadKeysFromFile:kApiKeysFile];
    return self;
}

- (NSURLSessionDataTask *)characterListWithTimestamp:(NSTimeInterval)timestamp
                                              APIKey:(NSString *)publicKey
                                                hash:(NSString *)hash
                                             success:(HBCharacterRequestSuccess)successBlock
                                             failure:(HBCharacterRequestFailure)failureBlock
{
    NSString *resourcePath = kCharactersResource;
    NSDictionary *params = [self buildParametersWithTimestamp:timestamp
                                                    publicKey:publicKey
                                                         hash:hash];
    
    return [self fetchCharacterWithPath:resourcePath
                             parameters:params
                                success:successBlock
                                failure:failureBlock];
}

- (NSURLSessionDataTask *)characterListWithSuccess:(HBCharacterRequestSuccess)successBlock
                                           failure:(HBCharacterRequestFailure)failureBlock
{
    NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
    NSString *hash = [self buildHashForTimestamp:timestamp
                                      privateKey:self.privateAPIKey
                                       publicKey:self.publicAPIKey];
    
    return [self characterListWithTimestamp:timestamp
                                     APIKey:self.publicAPIKey
                                       hash:hash
                                    success:successBlock
                                    failure:failureBlock];
}

- (NSURLSessionDataTask *)characterDetailWithId:(NSInteger)characterId
                                      timestamp:(NSTimeInterval)timestamp
                                         APIKey:(NSString *)publicKey
                                           hash:(NSString *)hash
                                        success:(HBCharacterRequestSuccess)successBlock
                                        failure:(HBCharacterRequestFailure)failureBlock
{
    NSString *path = [NSString stringWithFormat:@"%@/%li", kCharactersResource, (long)characterId];
    NSDictionary *params = [self buildParametersWithTimestamp:timestamp
                                                    publicKey:publicKey
                                                         hash:hash];
    
    return [self fetchCharacterWithPath:path
                             parameters:params
                                success:successBlock
                                failure:failureBlock];
}

- (NSURLSessionDataTask *)characterDetailWithId:(NSInteger)characterId
                                        success:(HBCharacterRequestSuccess)successBlock
                                        failure:(HBCharacterRequestFailure)failureBlock
{
    NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
    NSString *hash = [self buildHashForTimestamp:timestamp
                                      privateKey:self.privateAPIKey
                                       publicKey:self.publicAPIKey];
    
    return [self characterDetailWithId:characterId
                             timestamp:timestamp
                                APIKey:self.publicAPIKey
                                  hash:hash
                               success:successBlock
                               failure:failureBlock];
}

#pragma mark - Common character request helper

- (NSURLSessionDataTask *)fetchCharacterWithPath:(NSString *)resourcePath
                                      parameters:(NSDictionary *)parameters
                                         success:(HBCharacterRequestSuccess)successBlock
                                         failure:(HBCharacterRequestFailure)failureBlock
{
    void (^onSuccess)(NSURLSessionDataTask*, id) = ^(NSURLSessionDataTask *task, id responseObject) {
        
        NSError *error;
        
        if (error) {
            if (failureBlock) {
                failureBlock(error);
            }
        } else {
            if (successBlock) {
                successBlock(responseObject);
            }
        }
    };
    
    void (^onFailure)(NSURLSessionDataTask*, NSError*) = ^(NSURLSessionDataTask *task, NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    };
    
    return [self GET:resourcePath
          parameters:parameters
            progress:nil
             success:onSuccess
             failure:onFailure];
}

#pragma mark - Request signing helpers

/**
 Load the API public and private keys from the given plist file.

 @param plistFilename The plist file name
 */
- (void)loadKeysFromFile:(NSString *)plistFilename {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistFilename ofType:@"plist"];
    NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:plistPath];

    self.publicAPIKey = root[kPublicKeyName];
    self.privateAPIKey = root[kPrivateKeyName];
}

/**
 Build the HASH parameter, used to authenticate the requests.

 @param timestamp The request timestamp
 @param privateKey The developer Private Key
 @param publicKey The developer Public Key
 @return A NSString object with a hash built with the given parameters
 */
- (NSString *)buildHashForTimestamp:(NSTimeInterval)timestamp
                         privateKey:(NSString *)privateKey
                          publicKey:(NSString *)publicKey {
    
    NSString *hs = [NSString stringWithFormat:@"%f%@%@", timestamp, privateKey, publicKey];
    NSString *hash = [hs MD5Digest];
    
    return hash;
}

/**
 Build the authentication parameters used in the requests query string.

 @return A NSDictionary object with the parameters.
 */
- (NSDictionary *)buildParametersWithTimestamp:(NSTimeInterval)timestamp
                                     publicKey:(NSString *)publicKey
                                          hash:(NSString *)hash {
    NSDictionary *parameters = @{
        @"apikey": publicKey,
        @"ts": @(timestamp),
        @"hash": hash,
    };
    
    return parameters;
}

@end
