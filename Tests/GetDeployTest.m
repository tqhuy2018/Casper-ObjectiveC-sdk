#import <XCTest/XCTest.h>

#import <CasperSDKObjectiveC/CasperErrorMessage.h>
#import <CasperSDKObjectiveC/ConstValues.h>
#import <CasperSDKObjectiveC/CLType.h>
#import <CasperSDKObjectiveC/CLParsed.h>
#import <CasperSDKObjectiveC/GetDeployResult.h>
#import <CasperSDKObjectiveC/GetDeployParams.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem_ModuleBytes.h>
#import <CasperSDKObjectiveC/NamedArg.h>
@interface GetDeployTest : XCTestCase

@end

@implementation GetDeployTest
- (void) getDeploy:(NSString*) jsonString withCallIndex:(NSString*) callIndex{
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"get deploy"];
    NSString * casperURL =  URL_TEST_NET;
   // casperURL = URL_MAIN_NET;
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
            GetDeployResult * ret = [[GetDeployResult alloc] init];
            ret = [GetDeployResult fromJsonDictToGetDeployResult:forJSONObject[@"result"]];
            if([callIndex isEqualToString:@"call1"])  {
                //Assertion for deploy at this address:
                //https://testnet.cspr.live/deploy/777253965d76166caba6a4b861a2b4f0bfdfa8bfd46abbcf48f6a1b2cdff02f4
                XCTAssert([ret.deploy.itsHash isEqualToString:@"777253965d76166caba6a4b861a2b4f0bfdfa8bfd46abbcf48f6a1b2cdff02f4"]);
                XCTAssert([ret.deploy.header.account isEqualToString:@"01fc01324cf44fcca53109f3c890ed391364372c5c82fca33268ee8f6ec5c6841b"]);
                XCTAssert([ret.deploy.header.chain_name isEqualToString:@"casper-test"]);
                XCTAssert([ret.deploy.header.dependencies count] == 0);
                XCTAssert(ret.deploy.header.gas_price == 1);
                XCTAssert([ret.deploy.header.timestamp isEqualToString:@"2022-03-14T03:45:26.953Z"]);
                XCTAssert([ret.deploy.header.ttl isEqualToString:@"1h 30m"]);
                //assert for deploy payment
                XCTAssert([ret.deploy.payment.itsType isEqualToString:EDI_MODULEBYTES]);
                ExecutableDeployItem_ModuleBytes * payment = (ExecutableDeployItem_ModuleBytes*) [ret.deploy.payment.itsValue objectAtIndex:0];
                XCTAssert([payment.module_bytes isEqualToString:@""]);
                XCTAssert([payment.args.listArgs count] == 1);
                NamedArg * na = [payment.args.listArgs objectAtIndex:0];
                XCTAssert([na.itsName isEqualToString:@"amount"]);
                CLValue * paymentCLValue = na.itsCLValue;
                XCTAssert([paymentCLValue.bytes isEqualToString:@"04005ed0b2"]);
                XCTAssert([paymentCLValue.cl_type.itsType isEqualToString:CLTYPE_U512]);
                XCTAssert([paymentCLValue.parsed.itsValueStr isEqualToString:@"3000000000"]);
                
                //assert for deploy session
                XCTAssert([ret.deploy.session.itsType isEqualToString:EDI_STORED_CONTRACT_BY_HASH]);
                ExecutableDeployItem_StoredContractByHash * session = (ExecutableDeployItem_StoredContractByHash*) [ret.deploy.session.itsValue objectAtIndex:0];
                XCTAssert([session.itsHash isEqualToString:@"4f4da49a080efdf3a66ddc279f050c0700618db675507734a46a8a1bb784575f"]);
                XCTAssert([session.entry_point isEqualToString:@"swap_exact_tokens_for_tokens"]);
                XCTAssert([session.args.listArgs count] == 6);
                
                NamedArg * sessionNA1 = [session.args.listArgs objectAtIndex:0];
                XCTAssert([sessionNA1.itsName isEqualToString:@"amount_in"]);
                CLValue * sessionCLValue1 = sessionNA1.itsCLValue;
                XCTAssert([sessionCLValue1.bytes isEqualToString:@"04005ed0b2"]);
                XCTAssert([sessionCLValue1.cl_type.itsType isEqualToString:CLTYPE_U256]);
                XCTAssert([sessionCLValue1.parsed.itsValueStr isEqualToString:@"3000000000"]);
                
                NamedArg * sessionNA2 = [session.args.listArgs objectAtIndex:2];
                XCTAssert([sessionNA2.itsName isEqualToString:@"path"]);
                CLValue * sessionCLValue2 = sessionNA2.itsCLValue;
                XCTAssert([sessionCLValue2.bytes isEqualToString:@"010000000100000009000000746f6b656e5f7572695000000068747470733a2f2f676174657761792e70696e6174612e636c6f75642f697066732f516d5a4e7a337a564e7956333833666e315a6762726f78434c5378566e78376a727134796a4779464a6f5a35566b"]);
                XCTAssert([sessionCLValue2.cl_type.itsType isEqualToString:CLTYPE_LIST]);
                XCTAssert([sessionCLValue2.cl_type.innerType1.itsType isEqualToString:CLTYPE_MAP]);
                XCTAssert([sessionCLValue2.cl_type.innerType1.innerType1.itsType isEqualToString:CLTYPE_STRING]);
                XCTAssert([sessionCLValue2.cl_type.innerType1.innerType2.itsType isEqualToString:CLTYPE_STRING]);
                CLParsed * parse2 = (CLParsed*) [sessionCLValue2.parsed.arrayValue objectAtIndex:0];
                XCTAssert([parse2.innerParsed1.arrayValue count] == 1);//Map of 1 item
                XCTAssert([parse2.innerParsed2.arrayValue count] == 1);
                CLParsed * parseKey = (CLParsed *) [parse2.innerParsed1.arrayValue objectAtIndex:0];
                CLParsed * parseValue = (CLParsed *) [parse2.innerParsed2.arrayValue objectAtIndex:0];
                XCTAssert([parseKey.itsValueStr isEqualToString:@"token_uri"]);
                XCTAssert([parseValue.itsValueStr isEqualToString: @"https://gateway.pinata.cloud/ipfs/QmZNz3zVNyV383fn1ZgbroxCLSxVnx7jrq4yjGyFJoZ5Vk"]);
                NamedArg * sessionNA3 = [session.args.listArgs objectAtIndex:3];
                XCTAssert([sessionNA3.itsName isEqualToString:@"deadline"]);
                CLValue * sessionCLValue3 = sessionNA3.itsCLValue;
                XCTAssert([sessionCLValue3.bytes isEqualToString:@"b75107567e010000"]);
                XCTAssert([sessionCLValue3.cl_type.itsType isEqualToString:CLTYPE_U64]);
                long u64Value = sessionCLValue3.parsed.itsValueStr.longLongValue;
                XCTAssert(u64Value == 1642120827319);
                
                //Approvals assertion
                XCTAssert([ret.deploy.approvals count] == 1);
                Approval * approval = (Approval*) [ret.deploy.approvals objectAtIndex:0];
                XCTAssert([approval.signer isEqualToString:@"01fc01324cf44fcca53109f3c890ed391364372c5c82fca33268ee8f6ec5c6841b"]);
                XCTAssert([approval.signature isEqualToString:@"01c6444ec0c603cf1d642332d473254e6d3e570ce354a9db89ed98325489f3d0f5c810628510189dfcb1d9076dc5ff7d056dedb4873d7b23d0995981e13825bb03"]);
                
                //execution_results assertion
                int totalER = (int) ret.execution_results.count;
                XCTAssert(totalER == 1);
                for(int i = 0; i < totalER;i++) {
                    JsonExecutionResult * item = (JsonExecutionResult*) [ret.execution_results objectAtIndex:i];
                    XCTAssert([item.block_hash isEqualToString:@"e1a1a5aa74b035b244acc6ffb193c0894406cff3b603d529d7b2e1c79ca5a84f"]);
                    XCTAssert(item.is_ExecutionResult_success == false);
                    XCTAssert([item.error_message isEqualToString:@"ApiError::InvalidArgument [3]"]);
                    XCTAssert([item.cost.itsValue isEqualToString:@"6032800"]);
                    int totalTransfer = (int) item.transfers.count;
                    XCTAssert(totalTransfer == 0);
                    //int totalTransform = (int) item
                    ExecutionEffect * effect = item.effect;
                    XCTAssert(effect.operations.count == 0);
                    XCTAssert(effect.transforms.count == 16);
                    TransformEntry * oneTransform = [[TransformEntry alloc] init];
                    oneTransform = [effect.transforms objectAtIndex:0];
                    XCTAssert([oneTransform.key isEqualToString: @"hash-8cf5e4acf51f54eb59291599187838dc3bc234089c46fc6ca8ad17e762ae4401"]);
                    XCTAssert([oneTransform.transformType isEqualToString:TRANSFORM_IDENTITY]);
                    oneTransform = [effect.transforms objectAtIndex:6];
                    XCTAssert([oneTransform.key isEqualToString: @"balance-d1000a9aa63056cbd695f28f587c7c59bd33caccde545f6c47e1a8de8967c434"]);
                    XCTAssert([oneTransform.transformType isEqualToString:TRANSFORM_WRITE_CLVALUE]);
                    Transform_WriteCLValue * transformValue = (Transform_WriteCLValue*) [oneTransform.transform objectAtIndex:0];
                    CLValue * clValue = transformValue.itsValue;
                    XCTAssert([clValue.bytes isEqualToString:@"0500b2d421e8"]);
                    XCTAssert([clValue.cl_type.itsType isEqualToString:CLTYPE_U512]);
                    XCTAssert([clValue.parsed.itsValueStr isEqualToString:@"997000000000"]);
                    oneTransform = [effect.transforms objectAtIndex:7];
                    XCTAssert([oneTransform.key isEqualToString: @"balance-98d945f5324f865243b7c02c0417ab6eac361c5c56602fd42ced834a1ba201b6"]);
                    XCTAssert([oneTransform.transformType isEqualToString:TRANSFORM_ADD_UINT512]);
                    NSString * u512Value = (NSString *) [oneTransform.transform objectAtIndex:0];
                    XCTAssert([u512Value isEqualToString:@"3000000000"]);
                }
            } else if([callIndex isEqualToString:@"call2"]) {
                //Assertion for deploy at this address:
                //https://testnet.cspr.live/deploy/afab485f7534d593bf9e30ae34e003d6faf81819a983048b972dbbb4ff441ecc
                XCTAssert([ret.deploy.itsHash isEqualToString:@"afab485f7534d593bf9e30ae34e003d6faf81819a983048b972dbbb4ff441ecc"]);
                XCTAssert([ret.deploy.header.account isEqualToString:@"01a018bf278f32fdb7b06226071ce399713ace78a28d43a346055060a660ba7aa9"]);
                XCTAssert([ret.deploy.header.chain_name isEqualToString:@"casper-test"]);
                XCTAssert([ret.deploy.header.dependencies count] == 0);
                XCTAssert(ret.deploy.header.gas_price == 1);
                XCTAssert([ret.deploy.header.timestamp isEqualToString:@"2022-01-20T12:07:21.499Z"]);
                XCTAssert([ret.deploy.header.ttl isEqualToString:@"30m"]);
                //assert for deploy payment
                XCTAssert([ret.deploy.payment.itsType isEqualToString:EDI_MODULEBYTES]);
                ExecutableDeployItem_ModuleBytes * payment = (ExecutableDeployItem_ModuleBytes*) [ret.deploy.payment.itsValue objectAtIndex:0];
                XCTAssert([payment.module_bytes isEqualToString:@""]);
                XCTAssert([payment.args.listArgs count] == 1);
                NamedArg * na = [payment.args.listArgs objectAtIndex:0];
                XCTAssert([na.itsName isEqualToString:@"amount"]);
                CLValue * paymentCLValue = na.itsCLValue;
                XCTAssert([paymentCLValue.bytes isEqualToString:@"0500e8764817"]);
                XCTAssert([paymentCLValue.cl_type.itsType isEqualToString:CLTYPE_U512]);
                XCTAssert([paymentCLValue.parsed.itsValueStr isEqualToString:@"100000000000"]);
                
                //assert for deploy session
                XCTAssert([ret.deploy.session.itsType isEqualToString:EDI_MODULEBYTES]);
                ExecutableDeployItem_ModuleBytes * session = (ExecutableDeployItem_ModuleBytes*) [ret.deploy.session.itsValue objectAtIndex:0];
                XCTAssert([session.args.listArgs count] == 1);
                XCTAssert(session.module_bytes.length > 10000);
                NamedArg * sessionNA1 = [session.args.listArgs objectAtIndex:0];
                XCTAssert([sessionNA1.itsName isEqualToString:@"initial_supportted_tokens"]);
                CLValue * sessionCLValue1 = sessionNA1.itsCLValue;
                XCTAssert([sessionCLValue1.bytes isEqualToString:@"020000000117202d448a32af52252a21c8296c9562c10a1f3da69efc5a5d01678aac753b7e010a01f27e4d26f43d64a9e0688f0d90f4c129e50f930b0d46416af1f1c9a18f957dbb0114"]);
                XCTAssert([sessionCLValue1.cl_type.itsType isEqualToString:CLTYPE_LIST]);
                XCTAssert([sessionCLValue1.cl_type.innerType1.itsType isEqualToString: CLTYPE_TUPLE2]);
                XCTAssert([sessionCLValue1.cl_type.innerType1.innerType1.itsType isEqualToString: CLTYPE_KEY]);
                XCTAssert([sessionCLValue1.cl_type.innerType1.innerType2.itsType isEqualToString: CLTYPE_U256]);
                XCTAssert([sessionCLValue1.parsed.arrayValue count] == 2);
                NSLog(@"Total parse:%lu",[sessionCLValue1.parsed.arrayValue count]);
                CLParsed * parse0 = (CLParsed*)[sessionCLValue1.parsed.arrayValue objectAtIndex:0];
                XCTAssert([parse0.innerParsed1.itsValueStr isEqualToString:@"hash-17202d448a32af52252a21c8296c9562c10a1f3da69efc5a5d01678aac753b7e"]);
                XCTAssert([parse0.innerParsed2.itsValueStr isEqualToString:@"10"]);
               
                CLParsed * parse1 = (CLParsed*)[sessionCLValue1.parsed.arrayValue objectAtIndex:1];
                XCTAssert([parse1.innerParsed1.itsValueStr isEqualToString:@"hash-f27e4d26f43d64a9e0688f0d90f4c129e50f930b0d46416af1f1c9a18f957dbb"]);
                XCTAssert([parse1.innerParsed2.itsValueStr isEqualToString:@"20"]);
                
                //Approvals assertion
                XCTAssert([ret.deploy.approvals count] == 1);
                Approval * approval = (Approval*) [ret.deploy.approvals objectAtIndex:0];
                XCTAssert([approval.signer isEqualToString:@"01a018bf278f32fdb7b06226071ce399713ace78a28d43a346055060a660ba7aa9"]);
                XCTAssert([approval.signature isEqualToString:@"01a11b87d4dd0a65db628be673f5eaa7360efc19a9e1c02e3f8983974a8c82cabcade6708db59def3144073a4a271582b2c6baf758be7abbc2390708644989f60a"]);
                
                //execution_results assertion
                int totalER = (int) ret.execution_results.count;
                XCTAssert(totalER == 1);
                for(int i = 0; i < totalER;i++) {
                    JsonExecutionResult * item = (JsonExecutionResult*) [ret.execution_results objectAtIndex:i];
                    XCTAssert([item.block_hash isEqualToString:@"c6f8eed69750fcb3c21af5cb30778e4dad0df26bfb2f6bdcb15361ff28b61810"]);
                    XCTAssert(item.is_ExecutionResult_success == true);
                    XCTAssert([item.cost.itsValue isEqualToString:@"75758328710"]);
                    int totalTransfer = (int) item.transfers.count;
                    XCTAssert(totalTransfer == 0);
                    //int totalTransform = (int) item
                    ExecutionEffect * effect = item.effect;
                    XCTAssert(effect.operations.count == 0);
                    XCTAssert(effect.transforms.count == 31);
                    TransformEntry * oneTransform = [[TransformEntry alloc] init];
                    oneTransform = [effect.transforms objectAtIndex:0];
                    XCTAssert([oneTransform.key isEqualToString: @"hash-8cf5e4acf51f54eb59291599187838dc3bc234089c46fc6ca8ad17e762ae4401"]);
                    XCTAssert([oneTransform.transformType isEqualToString:TRANSFORM_IDENTITY]);
                    
                    oneTransform = [effect.transforms objectAtIndex:6];
                    XCTAssert([oneTransform.key isEqualToString: @"balance-702aadf2ef2c6a4b5761e659c6742d1135591043a26609ea878d9044ab0a86a9"]);
                    XCTAssert([oneTransform.transformType isEqualToString:TRANSFORM_WRITE_CLVALUE]);
                    Transform_WriteCLValue * transformValue = (Transform_WriteCLValue*) [oneTransform.transform objectAtIndex:0];
                    CLValue * clValue = transformValue.itsValue;
                    XCTAssert([clValue.bytes isEqualToString:@"0600cc9510c702"]);
                    XCTAssert([clValue.cl_type.itsType isEqualToString:CLTYPE_U512]);
                    XCTAssert([clValue.parsed.itsValueStr isEqualToString:@"3054000000000"]);
                    
                    oneTransform = [effect.transforms objectAtIndex:8];
                    XCTAssert([oneTransform.key isEqualToString: @"uref-7d5d1f97b7fd023d9ff2af30fbc00355c06dcf7fd4464de049da9871059f4e9d-000"]);
                    XCTAssert([oneTransform.transformType isEqualToString:TRANSFORM_WRITE_CLVALUE]);
                    Transform_WriteCLValue * transformValue2 = (Transform_WriteCLValue*) [oneTransform.transform objectAtIndex:0];
                    CLValue * clValue2 = transformValue2.itsValue;
                    XCTAssert([clValue2.bytes isEqualToString:@""]);
                    XCTAssert([clValue2.cl_type.itsType isEqualToString:CLTYPE_UNIT]);
                    XCTAssert([clValue2.parsed.itsValueStr isEqualToString:CLPARSED_NULL_VALUE]);
                    
                    oneTransform = [effect.transforms objectAtIndex:9];
                    XCTAssert([oneTransform.key isEqualToString: @"account-hash-a66aa5ab61b26cd4178cba3fa5657652013f57689eb25e111f3aa974443591b1"]);
                    XCTAssert([oneTransform.transformType isEqualToString:TRANSFORM_ADD_KEYS]);
                    Transform_AddKeys * addKey = (Transform_AddKeys*) [oneTransform.transform objectAtIndex:0];
                    XCTAssert([addKey.listKey count] == 1);
                    NamedKey * oneNK = (NamedKey*) [addKey.listKey objectAtIndex:0];
                    XCTAssert([oneNK.key isEqualToString: @"uref-7d5d1f97b7fd023d9ff2af30fbc00355c06dcf7fd4464de049da9871059f4e9d-007"]);
                    XCTAssert([oneNK.name isEqualToString:@"loan_fee"]);
                    
                    oneTransform = [effect.transforms objectAtIndex:10];
                    XCTAssert([oneTransform.key isEqualToString: @"dictionary-167f8c8c017fbd1094d35cd8c85a3cec26594eb8c498b396b31f9bdc2e96ed53"]);
                    XCTAssert([oneTransform.transformType isEqualToString:TRANSFORM_WRITE_CLVALUE]);
                    Transform_WriteCLValue * transformValue3 = (Transform_WriteCLValue*) [oneTransform.transform objectAtIndex:0];
                    CLValue * clValue3 = transformValue3.itsValue;
                    XCTAssert([clValue3.bytes isEqualToString:@"02000000010a07200000007d5d1f97b7fd023d9ff2af30fbc00355c06dcf7fd4464de049da9871059f4e9d2c000000415263674c55534b4d7139534a536f6879436c736c574c424368383970703738576c30425a3471736454742b"]);
                    XCTAssert([clValue3.cl_type.itsType isEqualToString:CLTYPE_ANY]);
                    XCTAssert([clValue3.parsed.itsValueStr isEqualToString:CLPARSED_NULL_VALUE]);
                    
                    oneTransform = [effect.transforms objectAtIndex:12];
                    XCTAssert([oneTransform.key isEqualToString: @"uref-c3198954d056013f1c5c89e7ec0b7827584b0c3a579324f2a53ffd5b825afce5-000"]);
                    XCTAssert([oneTransform.transformType isEqualToString:TRANSFORM_WRITE_CLVALUE]);
                    Transform_WriteCLValue * transformValue4 = (Transform_WriteCLValue*) [oneTransform.transform objectAtIndex:0];
                    CLValue * clValue4 = transformValue4.itsValue;
                    XCTAssert([clValue4.bytes isEqualToString:@"020000000117202d448a32af52252a21c8296c9562c10a1f3da69efc5a5d01678aac753b7e01f27e4d26f43d64a9e0688f0d90f4c129e50f930b0d46416af1f1c9a18f957dbb"]);
                    XCTAssert([clValue4.cl_type.itsType isEqualToString:CLTYPE_LIST]);
                    XCTAssert([clValue4.cl_type.innerType1.itsType isEqualToString:CLTYPE_KEY]);
                    XCTAssert([clValue4.parsed.arrayValue count] == 2);
                    CLParsed * parse41 = (CLParsed*) [clValue4.parsed.arrayValue objectAtIndex:0];
                    XCTAssert([parse41.itsValueStr isEqualToString:@"hash-17202d448a32af52252a21c8296c9562c10a1f3da69efc5a5d01678aac753b7e"]);
                    CLParsed * parse42 = (CLParsed*) [clValue4.parsed.arrayValue objectAtIndex:1];
                    XCTAssert([parse42.itsValueStr isEqualToString:@"hash-f27e4d26f43d64a9e0688f0d90f4c129e50f930b0d46416af1f1c9a18f957dbb"]);
                    
                    oneTransform = [effect.transforms objectAtIndex:22];
                    XCTAssert([oneTransform.key isEqualToString: @"deploy-afab485f7534d593bf9e30ae34e003d6faf81819a983048b972dbbb4ff441ecc"]);
                    XCTAssert([oneTransform.transformType isEqualToString:TRANSFORM_WRITE_DEPLOY_INFO]);
                    Transform_WriteDeployInfo * transformValue5 = (Transform_WriteDeployInfo*) [oneTransform.transform objectAtIndex:0];
                    XCTAssert([transformValue5.itsDeployInfo.gas.itsValue isEqualToString:@"75758328710"]);
                    XCTAssert([transformValue5.itsDeployInfo.source isEqualToString:@"uref-702aadf2ef2c6a4b5761e659c6742d1135591043a26609ea878d9044ab0a86a9-007"]);
                    XCTAssert([transformValue5.itsDeployInfo.from isEqualToString:@"account-hash-a66aa5ab61b26cd4178cba3fa5657652013f57689eb25e111f3aa974443591b1"]);
                    XCTAssert([transformValue5.itsDeployInfo.deploy_hash isEqualToString:@"afab485f7534d593bf9e30ae34e003d6faf81819a983048b972dbbb4ff441ecc"]);
                    XCTAssert([transformValue5.itsDeployInfo.transfers count] == 0);
                }
            }
            else if([callIndex isEqualToString:@"call10"]) {
                //Assertion for deploy at this address:
                //https://testnet.cspr.live/deploy/a91d468e2ddc8936f7866bc594794b322f747508c2192fd4eca90ef8a121d45e
                XCTAssert([ret.deploy.itsHash isEqualToString:@"a91d468e2ddc8936f7866bc594794b322f747508c2192fd4eca90ef8a121d45e"]);
                //assert for deploy header
                XCTAssert([ret.deploy.header.account isEqualToString:@"014caf1ce908f9ef3d427dceac17e5c47950becf15d1def0810c235e0d58a9efad"]);
                XCTAssert([ret.deploy.header.chain_name isEqualToString:@"casper-test"]);
                XCTAssert([ret.deploy.header.dependencies count] == 0);
                XCTAssert(ret.deploy.header.gas_price == 1);
                XCTAssert([ret.deploy.header.timestamp isEqualToString:@"2022-01-17T11:11:08.508Z"]);
                XCTAssert([ret.deploy.header.ttl isEqualToString:@"30m"]);
                //assert for deploy payment
                XCTAssert([ret.deploy.payment.itsType isEqualToString:EDI_MODULEBYTES]);
                ExecutableDeployItem_ModuleBytes * payment = (ExecutableDeployItem_ModuleBytes*) [ret.deploy.payment.itsValue objectAtIndex:0];
                XCTAssert([payment.module_bytes isEqualToString:@""]);
                NamedArg * na = [payment.args.listArgs objectAtIndex:0];
                XCTAssert([na.itsName isEqualToString:@"amount"]);
                
                //Approvals assertion
                XCTAssert([ret.deploy.approvals count] == 1);
                Approval * approval = (Approval*) [ret.deploy.approvals objectAtIndex:0];
                XCTAssert([approval.signer isEqualToString:@"014caf1ce908f9ef3d427dceac17e5c47950becf15d1def0810c235e0d58a9efad"]);
                XCTAssert([approval.signature isEqualToString:@"018f91767a59056e74a9a51a32daea403983b17220eba56e8c9adf3cd3ae05e49acbdf0c9708e5707155eaf4d9612ef8019acf56c6c5875dc0c6beddaeba949c05"]);
            }
        } else {
            NSLog(@"Error get deploy with error message:%@ and error code:%@",cem.message,cem.code);
        }
       
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
          //  [self closeWithCompletionHandler:nil];
        }];
}
- (void) testGetDeploy {
    GetDeployParams * gpr = [[GetDeployParams alloc] init];
    gpr.deploy_hash = @"777253965d76166caba6a4b861a2b4f0bfdfa8bfd46abbcf48f6a1b2cdff02f4";
    NSString * jsonString1 = [gpr generatePostParam];
    [self getDeploy:jsonString1 withCallIndex:@"call1"];
    //List(Tuple2(Key,U256)
    gpr.deploy_hash = @"afab485f7534d593bf9e30ae34e003d6faf81819a983048b972dbbb4ff441ecc";
    NSString * jsonString2 = [gpr generatePostParam];
    [self getDeploy:jsonString2 withCallIndex:@"call2"];
    //List(Map(String,String)
    gpr.deploy_hash = @"AaB4aa0C14a37Bc9386020609aa1CabaD895c3E2E104d877B936C6Ffa2302268";
    //BytesArray, Bool,U512
    gpr.deploy_hash = @"1d113022631c587444166e4d1efbc3d475e49b28b90f1414d9cadee6dcddf65f";
    //ModuleBytes blank for session
    gpr.deploy_hash = @"2ad794272a1a805082f171f96f1ea0e71fcac3ae6dd0c525343199b553be8a61";
    //List(Tuple2(Key,U256)) in session ModuleBytes
    gpr.deploy_hash = @"afab485f7534d593bf9e30ae34e003d6faf81819a983048b972dbbb4ff441ecc";
    //Option, U32, U64, Key, List(String),U512
    gpr.deploy_hash = @"9ff98d8027795a002e41a709d5b5846e49c2e9f9c8bfbe74e4c857adc26d5571";
    //U256,URef, U64,Key,List(String)
    gpr.deploy_hash = @"0fe0adccf645e99b9b58493c843516cd354b189e1c3efe62c4f2768716a41932";
    //U8, List(U8), List(ByteArray)
    gpr.deploy_hash = @"ac654d996f17720e780fe4eae9a7d57d57cdadb069998666a369a0833aebb7f8";
    //PublicKey, Option(U64)
    gpr.deploy_hash = @"fa02357bffd204b34d3a3495f393fc5651541e1be4376072d6d94297daa688d6";
    //Transform of type Withdraw and Bid
    gpr.deploy_hash = @"acb4d78cbb900fe91a896ea8a427374c5d600cd9206efae2051863316265f1b1";
    //Transform of type WriteBid and WriteWithdraw
    gpr.deploy_hash = @"acb4d78cbb900fe91a896ea8a427374c5d600cd9206efae2051863316265f1b1";
    //List(Map(String,String)  in session StoredContractByHash
    gpr.deploy_hash = @"a91d468e2ddc8936f7866bc594794b322f747508c2192fd4eca90ef8a121d45e";
    NSString * jsonString = [gpr generatePostParam];
    [self getDeploy:jsonString withCallIndex:@"call10"];
}
@end
