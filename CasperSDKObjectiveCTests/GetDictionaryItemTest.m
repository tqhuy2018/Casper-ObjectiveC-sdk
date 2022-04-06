#import <XCTest/XCTest.h>
#import "CasperErrorMessage.h"
#import "ConstValues.h"
#import "GetItemParams.h"
#import "GetDictionaryItemParams.h"
#import "GetDictionaryItemResult.h"
#import "DictionaryIdentifier_AccountNamedKey.h"
#import "DictionaryIdentifier_ContractNamedKey.h"
#import "DictionaryIdentifier_URef.h"
#import "DictionaryIdentifier_Dictionary.h"
#import "CLValue.h"
#import "StoredValue.h"
@interface GetDictionaryItemTest : XCTestCase

@end

@implementation GetDictionaryItemTest

- (void) getDictionaryItem:(NSString*) jsonString  withCallIndex:(NSString*) callIndex{
    return;
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"get dictionary item"];
    NSString * casperURL = URL_TEST_NET;
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
            GetDictionaryItemResult * item = [[GetDictionaryItemResult alloc] init];
            item = [GetDictionaryItemResult fromJsonDictToGetItemResult:(NSDictionary *)forJSONObject[@"result"]];
            [item logInfo];
            if( [callIndex isEqualToString:@"call1"]) {
                XCTAssert([item.dictionary_key isEqualToString:@"dictionary-5d3e90f064798d54e5e53643c4fce0cbb1024aadcad1586cc4b7c1358a530373"]);
                XCTAssert(item.merkle_proof.length == 30330);
                StoredValue * sv = item.stored_value;
                XCTAssert([sv.itsType isEqualToString:@"CLValue"]);
                CLValue * clValue = (CLValue*) [sv.innerValue objectAtIndex:0];
                XCTAssert([clValue.bytes isEqualToString:@"090000006162635f76616c7565"]);
                XCTAssert([clValue.parsed.itsValueStr isEqualToString:@"abc_value"]);
                XCTAssert([clValue.cl_type.itsType isEqualToString:@"String"]);
            } else  if( [callIndex isEqualToString:@"call2"]) {
                XCTAssert([item.dictionary_key isEqualToString:@"dictionary-ac34673fa957fa8083306892815496b8fdee0aa1509f0080823979d869176060"]);
                XCTAssert(item.merkle_proof.length == 30178);
                StoredValue * sv = item.stored_value;
                XCTAssert([sv.itsType isEqualToString:@"CLValue"]);
                CLValue * clValue = (CLValue*) [sv.innerValue objectAtIndex:0];
                XCTAssert([clValue.bytes isEqualToString:@"0800000061626376616c7565"]);
                XCTAssert([clValue.parsed.itsValueStr isEqualToString:@"abcvalue"]);
                XCTAssert([clValue.cl_type.itsType isEqualToString:@"String"]);
            } else  if( [callIndex isEqualToString:@"call3"]) {
                XCTAssert([item.dictionary_key isEqualToString:@"dictionary-5d3e90f064798d54e5e53643c4fce0cbb1024aadcad1586cc4b7c1358a530373"]);
                XCTAssert(item.merkle_proof.length == 30330);
                StoredValue * sv = item.stored_value;
                XCTAssert([sv.itsType isEqualToString:@"CLValue"]);
                CLValue * clValue = (CLValue*) [sv.innerValue objectAtIndex:0];
                XCTAssert([clValue.bytes isEqualToString:@"090000006162635f76616c7565"]);
                XCTAssert([clValue.parsed.itsValueStr isEqualToString:@"abc_value"]);
                XCTAssert([clValue.cl_type.itsType isEqualToString:@"String"]);
            } else  if( [callIndex isEqualToString:@"call4"]) {
                XCTAssert([item.dictionary_key isEqualToString:@"dictionary-5d3e90f064798d54e5e53643c4fce0cbb1024aadcad1586cc4b7c1358a530373"]);
                XCTAssert(item.merkle_proof.length == 30330);
                StoredValue * sv = item.stored_value;
                XCTAssert([sv.itsType isEqualToString:@"CLValue"]);
                CLValue * clValue = (CLValue*) [sv.innerValue objectAtIndex:0];
                XCTAssert([clValue.bytes isEqualToString:@"090000006162635f76616c7565"]);
                XCTAssert([clValue.parsed.itsValueStr isEqualToString:@"abc_value"]);
                XCTAssert([clValue.cl_type.itsType isEqualToString:@"String"]);
            }
        } else {
            NSLog(@"Error get dictionary item with error message:%@ and error code:%@",cem.message,cem.code);
            if( [callIndex isEqualToString:@"call5"]) {
                XCTAssert([cem.message isEqualToString:@"Invalid params"]);
            } else if( [callIndex isEqualToString:@"call6"]) {
                XCTAssert([cem.message isEqualToString:@"Failed to parse Dictionary key"]);
            }
        }
       
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
          //  [self closeWithCompletionHandler:nil];
        }];
}
- (void) testGetDictionaryItem {
    GetDictionaryItemParams * itemParam = [[GetDictionaryItemParams alloc] init];
    itemParam.state_root_hash = @"146b860f82359ced6e801cbad31015b5a9f9eb147ab2a449fd5cdb950e961ca8";
    
    //Test 1: Parameter DictionaryIdentifier of type AccountNamedKey
    DictionaryIdentifier_AccountNamedKey * item = [[DictionaryIdentifier_AccountNamedKey alloc] init];
    item.key = @"account-hash-ad7e091267d82c3b9ed1987cb780a005a550e6b3d1ca333b743e2dba70680877";
    item.dictionary_name = @"dict_name";
    item.dictionary_item_key = @"abc_name";
    itemParam.dictionaryIdentifierType = @"AccountNamedKey";
    itemParam.innerDict = [[NSMutableArray alloc] init];
    [itemParam.innerDict addObject:item];
    NSString * jsonStr = [itemParam toJsonString];
    [self getDictionaryItem:jsonStr withCallIndex:@"call1"];

    //Test 2: Parameter DictionaryIdentifier of type ContractNamedKey
    DictionaryIdentifier_ContractNamedKey * itemCN = [[DictionaryIdentifier_ContractNamedKey alloc] init];
    itemCN.key = @"hash-d5308670dc1583f49a516306a3eb719abe0ba51651cb08e606fcfc1f9b9134cf";
    itemCN.dictionary_name = @"dictname";
    itemCN.dictionary_item_key = @"abcname";
    itemParam.dictionaryIdentifierType = @"ContractNamedKey";
    [itemParam.innerDict removeAllObjects];
    [itemParam.innerDict addObject:itemCN];
    NSString * jsonStrCN = [itemParam toJsonString];
    [self getDictionaryItem:jsonStrCN withCallIndex:@"call2"];
    
    //Test 3: Parameter DictionaryIdentifier of type URef
    DictionaryIdentifier_URef * itemU = [[DictionaryIdentifier_URef alloc] init];
    itemU.seed_uref = @"uref-30074a46a79b2d80cff437594d2422383f6c754de453b732448cc711b9f7e129-007";
    itemU.dictionary_item_key = @"abc_name";
    itemParam.dictionaryIdentifierType = @"URef";
    [itemParam.innerDict removeAllObjects];
    [itemParam.innerDict addObject:itemU];
    NSString * jsonStrU = [itemParam toJsonString];
    [self getDictionaryItem:jsonStrU withCallIndex:@"call3"];
    
    //Test 4: Parameter DictionaryIdentifier of type Dictionary
    DictionaryIdentifier_Dictionary * itemD = [[DictionaryIdentifier_Dictionary alloc] init];
    itemD.itsValue = @"dictionary-5d3e90f064798d54e5e53643c4fce0cbb1024aadcad1586cc4b7c1358a530373";
    itemParam.dictionaryIdentifierType = @"Dictionary";
    [itemParam.innerDict removeAllObjects];
    [itemParam.innerDict addObject:itemD];
    NSString * jsonStrD = [itemParam toJsonString];
    [self getDictionaryItem:jsonStrD withCallIndex:@"call4"];
    
    //Negative path
    //Test1: Test with incorrect state_root_hash
    //Expect error object with the following information:
    //Invalid params and error code:-32602
    itemParam.state_root_hash = @"AAAAA_146b860f82359ced6e801cbad31015b5a9f9eb147ab2a449fd5cdb950e961ca8";
    DictionaryIdentifier_Dictionary * itemD2 = [[DictionaryIdentifier_Dictionary alloc] init];
    itemD2.itsValue = @"dictionary-5d3e90f064798d54e5e53643c4fce0cbb1024aadcad1586cc4b7c1358a530373";
    itemParam.dictionaryIdentifierType = @"Dictionary";
    [itemParam.innerDict removeAllObjects];
    [itemParam.innerDict addObject:itemD2];
    NSString * jsonStrD2 = [itemParam toJsonString];
    [self getDictionaryItem:jsonStrD2 withCallIndex:@"call5"];
    
    //Test 2: Test with incorrect parameter
    //Expected error object with the following information:
    //Failed to parse Dictionary key and error code:-32010
    itemParam.state_root_hash = @"146b860f82359ced6e801cbad31015b5a9f9eb147ab2a449fd5cdb950e961ca8";
    DictionaryIdentifier_Dictionary * itemD1 = [[DictionaryIdentifier_Dictionary alloc] init];
    itemD1.itsValue = @"dictionary-eeee5d3e90f064798d54e5e53643c4fce0cbb1024aadcad1586cc4b7c1358a530373";
    itemParam.dictionaryIdentifierType = @"Dictionary";
    [itemParam.innerDict removeAllObjects];
    [itemParam.innerDict addObject:itemD1];
    NSString * jsonStrD1 = [itemParam toJsonString];
    [self getDictionaryItem:jsonStrD1 withCallIndex:@"call6"];
    
}

@end
