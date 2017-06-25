//
//  HBTestCase.h
//  HeroicBase
//
//  Created by Rafael Winter on 25/06/17.
//  Copyright © 2017 Rafael Winter. All rights reserved.
//

#import <XCTest/XCTest.h>

/**
 The base class for test cases on HeroicBase project
 */
@interface HBTestCase : XCTestCase


/**
 Load a string of JSON test data from a resource file.

 @param resource The resource file name
 @return A NSString instance filled with the resource file contents.
 */
- (NSString *)loadJSONFromResource:(NSString *)resource;

@end
