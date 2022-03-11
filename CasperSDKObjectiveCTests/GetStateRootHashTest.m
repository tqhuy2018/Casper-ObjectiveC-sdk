

#import <XCTest/XCTest.h>
#import "BlockIdentifier.h"
@interface GetStateRootHashTest : XCTestCase

@end

@implementation GetStateRootHashTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    BlockIdentifier * bi = [[BlockIdentifier alloc] init];
    bi.blockType = USE_BLOCK_HASH;
    [bi assignBlockHashWithParam:@"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"];
    NSString * jsonString = [bi toJsonStringWithMethodName:@"chain_get_state_root_hash"];
    NSLog(@"jsonString for get stateRootHash:%@",jsonString);
}

- (void)testPerformanceExample {
   
}

@end
