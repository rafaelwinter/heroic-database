//
//  HBMarvelServiceTests.m
//  HeroicBase
//
//  Created by Rafael Winter on 25/06/17.
//  Copyright © 2017 Rafael Winter. All rights reserved.
//

#import "HBTestCase.h"
#import "HBMarvelService.h"


/**
 This category exposes internal methods for testing purposes only.
 */
@interface HBMarvelService (Testing)

- (NSString *)buildHashForTimestamp:(NSTimeInterval)timestamp
                         privateKey:(NSString *)privateKey
                          publicKey:(NSString *)publicKey;

@end

@interface HBMarvelServiceTests : HBTestCase

@end

@implementation HBMarvelServiceTests {
    HBMarvelService *SUT;
}


- (void)setUp {
    [super setUp];
    
    SUT = [HBMarvelService sharedMarvelService];
}

- (void)tearDown {
    SUT = nil;
    
    [super tearDown];
}

- (void)testBuildHashForTimestampPrivateKeyPublicKey {
    NSTimeInterval timestamp = 330770700;
    NSString *privateKey = @"52616661656c2057696e746572205465697865697261";
    NSString *publicKey = @"4c6f72656e6e61204c696e6461";
    
    NSString *generated = [SUT buildHashForTimestamp:timestamp
                                          privateKey:privateKey
                                           publicKey:publicKey];
    
    NSString *expected = @"5d37689dbbdedf38ca3c9b9c059a8836";
    
    XCTAssertEqualObjects(expected, generated);
}

@end
