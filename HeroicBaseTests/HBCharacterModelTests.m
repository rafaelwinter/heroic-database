//
//  HBCharacterModelTests.m
//  HeroicBase
//
//  Created by Rafael Winter on 25/06/17.
//  Copyright © 2017 Rafael Winter. All rights reserved.
//

#import "HBTestCase.h"

@interface HBCharacterModelTests : HBTestCase

@end

@implementation HBCharacterModelTests

- (void)testCharacterDataWrapperShouldLoadFromJSON {
    NSString *contents = [self loadJSONFromResource:@""];
    
    NSError *err;
    
    XCTFail(@"Not implemented");
}

@end
