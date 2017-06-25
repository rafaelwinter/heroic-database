//
//  HBCharacterModelTests.m
//  HeroicBase
//
//  Created by Rafael Winter on 25/06/17.
//  Copyright © 2017 Rafael Winter. All rights reserved.
//

#import "HBTestCase.h"
#import "HBCharacterDataWrapper.h"
#import "HBCharacterDataContainer.h"
#import "HBCharacter.h"

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

- (void)testCharacterDataWrapperShouldLoadFieldsFromJSON {
    NSString *contents = [self loadJSONFromResource:@"CharacterDataWrapper"];
    
    NSError *err;
    HBCharacterDataWrapper *SUT = [[HBCharacterDataWrapper alloc] initWithString:contents
                                                                           error:&err];
    
    XCTAssertEqual(200, SUT.code);
    XCTAssertEqualObjects(@"Ok", SUT.status);
    XCTAssertEqualObjects(@"© 2017 MARVEL", SUT.copyright);
    XCTAssertEqualObjects(@"Data provided by Marvel. © 2017 MARVEL", SUT.attributionText);
    XCTAssertEqualObjects(@"69516d4990612523510c60ea5b1cc94b9a004df8", SUT.etag);
}

- (void)testCharacterDataContainerShouldLoadFromJSON {
    NSString *contents = [self loadJSONFromResource:@"CharacterDataContainer"];
    
    NSError *err;
    HBCharacterDataContainer *SUT = [[HBCharacterDataContainer alloc] initWithString:contents
                                                                               error:&err];
    
    XCTAssertNil(err, "%@", [err localizedDescription]);
    XCTAssertNotNil(SUT, @"Could not initialize HBCharacterDataContainer with JSON data.");
}

- (void)testCharacterDataContainerShouldLoadFieldsFromJSON {
    NSString *contents = [self loadJSONFromResource:@"CharacterDataContainer"];
    
    NSError *err;
    HBCharacterDataContainer *SUT = [[HBCharacterDataContainer alloc] initWithString:contents
                                                                               error:&err];

    XCTAssertEqual(0, SUT.offset);
    XCTAssertEqual(20, SUT.limit);
    XCTAssertEqual(1485, SUT.total);
    XCTAssertEqual(20, SUT.count);
}

- (void)testCharacterShouldLoadFromJSON {
    NSString *contents = [self loadJSONFromResource:@"Character"];
    
    NSError *err;
    HBCharacter *SUT = [[HBCharacter alloc] initWithString:contents
                                                     error:&err];
    
    XCTAssertNil(err, "%@", [err localizedDescription]);
    XCTAssertNotNil(SUT, @"Could not initialize HBCharacter with JSON data.");
}

- (void)testCharacterShouldLoadFieldsFromJSON {
    NSString *contents = [self loadJSONFromResource:@"Character"];
    
    NSError *err;
    HBCharacter *SUT = [[HBCharacter alloc] initWithString:contents
                                                     error:&err];
    
    XCTAssertEqual(1011334, SUT.characterId);
    XCTAssertEqualObjects(@"3-D Man", SUT.name);
    XCTAssertEqualObjects(@"A man within three dimensions", SUT.shortBio);
}

@end
