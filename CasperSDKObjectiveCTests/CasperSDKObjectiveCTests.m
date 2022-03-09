//
//  CasperSDKObjectiveCTests.m
//  CasperSDKObjectiveCTests
//
//  Created by Hien on 09/03/2022.
//

#import <XCTest/XCTest.h>
#import "HttpHandler.h"
@interface CasperSDKObjectiveCTests : XCTestCase

@end

@implementation CasperSDKObjectiveCTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    HttpHandler * httpHandler = [[HttpHandler alloc]init];
    [httpHandler handleRequestWithParam:@"This is a test"];
}

@end
