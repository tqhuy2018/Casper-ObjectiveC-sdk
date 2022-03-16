#import <XCTest/XCTest.h>

#import "CasperErrorMessage.h"
#import "ConstValues.h"
#import "CLType.h"
#import "CLTypeList.h"
#import "CLTypeMap.h"
#import "CLParsed.h"
#import "CLParsedPBool.h"
#import "CLParsedList.h"
#import "CLParsedPString.h"
#import "CLParsedMap.h"

@interface GetDeployTest : XCTestCase

@end


@implementation GetDeployTest
- (void) getDeploy:(NSString*) jsonString {
    return;
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"get block"];
    NSString * casperURL =  @"https://node-clarity-testnet.make.services/rpc";
   // casperURL = @"https://node-clarity-mainnet.make.services/rpc";
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.HTTPMethod = @"POST";
    [request setURL:[NSURL URLWithString:casperURL]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonData];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [requestExpectation fulfill];
        NSDictionary *forJSONObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        CasperErrorMessage * cem = [[CasperErrorMessage alloc] init];
        [cem fromJsonToErrorObject:forJSONObject];
        if(cem.message == CASPER_ERROR_MESSAGE_NONE) {
            
        } else {
            NSLog(@"Error get state root hash with error message:%@ and error code:%@",cem.message,cem.code);
        }
       
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
          //  [self closeWithCompletionHandler:nil];
        }];
}
- (void) testGetDeploy {
    return;
    //List(Map(String,String)) alloc
    //Method 1
    CLTypeList * cll = [[CLTypeList alloc] init];
    cll.itsType = @"List";
    cll.innerType1 = [[CLType alloc] init];
    cll.innerType1.innerType1 = [[CLType alloc] init];
    cll.innerType1.innerType2 = [[CLType alloc] init];
    cll.innerType1.itsType = @"Map";
    cll.is_innerType1_exists = true;
    cll.innerType1.innerType1.itsType = @"String";
    cll.innerType1.innerType2.itsType = @"String";
    cll.innerType1.is_innerType1_exists = true;
    cll.innerType1.is_innerType2_exists = true;
    [cll logInfo];
    //Method 2
    CLTypeList * cll2 = [[CLTypeList alloc] init];
    cll2.innerType1.itsType = @"Map";
    cll2.innerType1 = [[CLTypeMap alloc] init];
    cll2.innerType1.innerType1.itsType = @"String";
    cll2.innerType1.innerType2.itsType = @"String";
   // [cll2 logInfo];
    //For CLParsed
    CLParsedPBool * bool1 = [[CLParsedPBool alloc] init];
    bool1.itsPrimitiveValue = @"true";
    CLParsedPBool * bool2 = [[CLParsedPBool alloc] init];
    bool2.itsPrimitiveValue = @"false";
    CLParsedPBool * bool3 = [[CLParsedPBool alloc] init];
    bool3.itsPrimitiveValue = @"true";
    CLParsedList * list = [[CLParsedList alloc] init];
    [list.arrayValue addObject: bool1];
    [list.arrayValue addObject: bool2];
    [list.arrayValue addObject: bool3];
   // [list logInfo];
    //List of String
    CLParsedPString * str1 = [[CLParsedPString alloc] init];
    str1.itsPrimitiveValue = @"Hello world1";
    CLParsedPString * str2 = [[CLParsedPString alloc] init];
    str2.itsPrimitiveValue = @"Hello world2";
    CLParsedPString * str3 = [[CLParsedPString alloc] init];
    str3.itsPrimitiveValue = @"Hello world3";
    CLParsedList * list2 = [[CLParsedList alloc] init];
   
    [list2.arrayValue addObject: str1];
    [list2.arrayValue addObject: str2];
    [list2.arrayValue addObject: str3];
    //[list2 logInfo];
    //List(Map(String,String))
    CLParsedList * list3 = [[CLParsedList alloc] init];
    CLParsedMap * map = [[CLParsedMap alloc] init];
    map.innerParsed1 = [[CLParsedList alloc] init];
    map.innerParsed2 = [[CLParsedList alloc] init];
    CLParsedPString * key1 = [[CLParsedPString alloc] init];
    key1.itsPrimitiveValue = @"name";
    CLParsedPString * key2 = [[CLParsedPString alloc] init];
    key2.itsPrimitiveValue = @"description";
    CLParsedPString * key3 = [[CLParsedPString alloc] init];
    key3.itsPrimitiveValue = @"ipfs_url";

    CLParsedPString * value1 = [[CLParsedPString alloc] init];
    value1.itsPrimitiveValue = @"Test Prod Admin";
    CLParsedPString * value2 = [[CLParsedPString alloc] init];
    value2.itsPrimitiveValue = @"Testing";
    CLParsedPString * value3 = [[CLParsedPString alloc] init];
    value3.itsPrimitiveValue = @"https://gateway.pinata.cloud/ipfs/QmauPU5rc8ghhyZFQxB9R5jCbaafGw2MneQJRMDWLVzjaU";
    //for key
    [map.innerParsed1.arrayValue addObject: key1];
    [map.innerParsed1.arrayValue addObject: key2];
    [map.innerParsed1.arrayValue addObject: key3];
    
    [map.innerParsed2.arrayValue addObject: value1];
    [map.innerParsed2.arrayValue addObject: value2];
    [map.innerParsed2.arrayValue addObject: value3];
    //for value
    [list3.arrayValue addObject:map];
    [list3 logInfo];
}

@end
