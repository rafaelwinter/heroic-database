//
//  HBCharacterDataWrapper.h
//  HeroicBase
//
//  Created by Rafael Winter on 25/06/17.
//  Copyright © 2017 Rafael Winter. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HBCharacterDataWrapper : JSONModel

/**
 The HTTP status code of the returned result.
 */
@property (assign, nonatomic) NSInteger code;

/**
 A string description of the call status.
 */
@property (strong, nonatomic) NSString *status;

/**
 The copyright notice for the returned result.
 */
@property (strong, nonatomic) NSString *copyright;

/**
 The attribution notice for this result. 
 
 @discussion Please display either this notice or the contents of the attributionHTML 
 field on all screens which contain data from the Marvel Comics API.
 */
@property (strong, nonatomic) NSString *attributionText;

/**
 A digest value of the content returned by the call.
 */
@property (strong, nonatomic) NSString *etag;

/**
 The results returned by the call.
 */
@property (strong, nonatomic) id <Optional> data;

@end
