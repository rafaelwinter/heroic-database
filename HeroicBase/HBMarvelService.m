//
//  HBMarvelService.m
//  HeroicBase
//
//  Created by Rafael Winter on 25/06/17.
//  Copyright © 2017 Rafael Winter. All rights reserved.
//

#import <MD5Digest/NSString+MD5.h>

#import "HBMarvelService.h"

static NSString *const kApiKeysFile = @"apikeys";
static NSString *const kPublicKeyName = @"HBMarvelServicePublicKey";
static NSString *const kPrivateKeyName = @"HBMarvelServicePrivateKey";
static NSString *const kBaseURL = @"https://gateway.marvel.com/v1/public/";
static NSString *const kCharactersResource = @"characters/";

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

@end
