//
//  HBTestCase.m
//  HeroicBase
//
//  Created by Rafael Winter on 25/06/17.
//  Copyright © 2017 Rafael Winter. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface HBTestCase : XCTestCase

@end

@implementation HBTestCase

- (NSString *)loadJSONFromResource:(NSString *)resource {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:resource ofType:@"json"];
    
    NSError *err;
    NSString *contents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&err];
    
    XCTAssertNil(err, "%@", [err localizedDescription]);
    XCTAssertNotNil(contents, @"Can't fetch test data file contents.");
    
    return contents;
}

@end
