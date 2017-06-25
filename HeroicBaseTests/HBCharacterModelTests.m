//
//  HBCharacterModelTests.m
//  HeroicBase
//
//  Created by Rafael Winter on 25/06/17.
//  Copyright © 2017 Rafael Winter. All rights reserved.
//

#import "HBTestCase.h"
#import "HBCharacterDataWrapper.h"

@interface HBCharacterModelTests : HBTestCase

@end

@implementation HBCharacterModelTests

- (void)testCharacterDataWrapperShouldLoadFromJSON {
    NSString *contents = [self loadJSONFromResource:@"CharacterDataWrapper"];
    
    NSError *err;
    HBCharacterDataWrapper *SUT = [[HBCharacterDataWrapper alloc] initWithString:contents
                                                                           error:&err];
    
    XCTAssertNil(err, "%@", [err localizedDescription]);
    XCTAssertNotNil(SUT, @"Could not initialize HBCharacterDataWrapper with JSON data.");
}

@end
