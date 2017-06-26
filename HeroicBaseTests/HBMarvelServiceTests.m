//
//  HBMarvelServiceTests.m
//  HeroicBase
//
//  Created by Rafael Winter on 25/06/17.
//  Copyright © 2017 Rafael Winter. All rights reserved.
//

#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OHHTTPStubs/OHPathHelpers.h>

#import "HBTestCase.h"
#import "HBMarvelService.h"

static NSTimeInterval const kTimestamp = 330770700;
static NSString *const kPrivateKey = @"52616661656c2057696e746572205465697865697261";
static NSString *const kPublicKey = @"4c6f72656e6e61204c696e6461";
static NSString *const kExpectedHash = @"5d37689dbbdedf38ca3c9b9c059a8836";

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
    [OHHTTPStubs removeAllStubs];
    [OHHTTPStubs onStubActivation:nil];
    
    SUT = nil;
    
    [super tearDown];
}

- (void)testBuildHashForTimestampPrivateKeyPublicKey {
    NSString *generatedHash = [SUT buildHashForTimestamp:kTimestamp
                                          privateKey:kPrivateKey
                                           publicKey:kPublicKey];

    XCTAssertEqualObjects(kExpectedHash, generatedHash);
}

- (void)testCharacterListShouldBuildCorrectURL {
    
    // given
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.path isEqualToString:@"/v1/public/characters"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"GetCharacterResponseData.json",self.class)
                                                statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }].name = @"testCharacterListShouldBuildCorrectURL";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request is built correctly"];

    // when
    [OHHTTPStubs onStubActivation:^(NSURLRequest * _Nonnull request, id<OHHTTPStubsDescriptor>  _Nonnull stub, OHHTTPStubsResponse * _Nonnull responseStub) {
        NSString *expectedURL = @"https://gateway.marvel.com/v1/public/characters?apikey=4c6f72656e6e61204c696e6461&hash=5d37689dbbdedf38ca3c9b9c059a8836&ts=330770700";
        if ([request.URL.absoluteString isEqualToString:expectedURL]) {
            NSLog(@"AAAAAAAAAA");
            [expectation fulfill];
        }
    }];
    
    [SUT characterListWithTimestamp:kTimestamp APIKey:kPublicKey hash:kExpectedHash
                            success:^(HBCharacterDataWrapper *response) { }
                            failure:^(NSError *error) { }];
    
    // then
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Expectation not met with error: %@", error);
        }
    }];
}

- (void)testCharacterListShouldLoadWithSuccess {
    
    // given
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.path isEqualToString:@"/v1/public/characters"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"GetCharacterResponseData.json",self.class)
                                                statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request works"];
    
    // when
    [SUT characterListWithTimestamp:kTimestamp APIKey:kPublicKey hash:kExpectedHash
                            success:^(HBCharacterDataWrapper *response) {
                                [expectation fulfill];
                            }
                            failure:^(NSError *error) { }];

    // then
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Expectation not met with error: %@", error);
        }
    }];
}

- (void)testCharacterListShouldFailWithServerError {
    
    // given
    NSError *HTTPStatus500Error = [NSError errorWithDomain:NSURLErrorDomain code:kCFURLErrorBadServerResponse userInfo:nil];
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.path isEqualToString:@"/v1/public/characters"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithError:HTTPStatus500Error];
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Request fails"];
    
    // when
    [SUT characterListWithTimestamp:kTimestamp APIKey:kPublicKey hash:kExpectedHash
                            success:^(HBCharacterDataWrapper *response) { }
                            failure:^(NSError *error) {
                                [expectation fulfill];
                            }];
    
    // then
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Expectation not met with error: %@", error);
        }
    }];
}

@end
