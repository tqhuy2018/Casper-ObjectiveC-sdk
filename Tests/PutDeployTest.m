#import <XCTest/XCTest.h>
#import <CasperSDKObjectiveC/Utils.h>
#import <CasperSDKObjectiveC/PutDeployUtils.h>
#import <CasperSDKObjectiveC/DeploySerializeHelper.h>
#import <CasperSDKObjectiveC/DeployHeader.h>
#import <CasperSDKObjectiveC/Deploy.h>
#import <CasperSDKObjectiveC/Approval.h>
#import <CasperSDKObjectiveC/ConstValues.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem_StoredContractByName.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem_ModuleBytes.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem_Transfer.h>
#import <CasperSDKObjectiveC/NamedArg.h>
#import <CasperSDKObjectiveC/CLType.h>
#import <CasperSDKObjectiveC/CLValue.h>
#import <CasperSDKObjectiveC/Ed25519Crypto.h>
#import <CasperSDKObjectiveC/Secp256k1Crypto.h>
#import <CasperSDKObjectiveC/CryptoKeyPair.h>
#import <CasperSDKObjectiveC/CasperErrorMessage.h>
#import <CasperSDKObjectiveC/PutDeployResult.h>
#import <CasperSDKObjectiveC/PutDeployParams.h>
#import <CasperSDKObjectiveC/PutDeployRPC.h>
@import CasperCryptoHandlePackage;
@interface PutDeployTest : XCTestCase

@end

@implementation PutDeployTest

- (void) putDeploy:(Deploy*) deploy withCallIndex:(NSString*) callIndex {
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"put deploy"];
    PutDeployUtils.deploy = [[Deploy alloc] init];
    PutDeployUtils.deploy = deploy;
    PutDeployUtils.isPutDeploySuccess =  true;
    NSString * casperURL =  URL_TEST_NET;
   // casperURL = @"https://node-clarity-mainnet.make.services/rpc";
    NSString * deployJsonString = [deploy toPutDeployParameterStr];
    NSLog(@"Put deploy, deploy hash is:%@",deploy.itsHash);
    NSLog(@"Put deploy full is:%@",deployJsonString);
    NSData * jsonData = [deployJsonString dataUsingEncoding:NSUTF8StringEncoding];
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
            PutDeployResult * ret = [[PutDeployResult alloc] init];
            ret = [PutDeployResult fromJsonObjectToPutDeployResult:(NSDictionary*) forJSONObject[@"result"]];
            NSLog(@"Put deploy success with deploy hash:%@ with the counter:%d and deployHash:%@",ret.deployHash,PutDeployUtils.putDeployCounter,deploy.itsHash);
            if([callIndex isEqualToString:@"call1"]) {
            } else  if([callIndex isEqualToString:@"call2"]) {
            }
            XCTAssert([ret.deployHash isEqualToString: deploy.itsHash] == true);
            PutDeployUtils.isPutDeploySuccess = true;
            PutDeployUtils.putDeployCounter = 0;
        } else {
            if([cem.message isEqualToString: @"invalid deploy: the approval at index 0 is invalid: asymmetric key error: failed to verify secp256k1 signature: signature error"]) {
                NSLog(@"Deploy hash when put again is:%@",PutDeployUtils.deploy.itsHash);
                PutDeployUtils.isPutDeploySuccess = false;
            }
        }
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
          //  [self closeWithCompletionHandler:nil];
        }];
    if(PutDeployUtils.isPutDeploySuccess == false) {
        //[PutDeployUtils utilsPutDeploy];
        NSString * deployHash = PutDeployUtils.deploy.itsHash;
        NSLog(@"Call put deploy again, deploy hash is:%@ and body hash:%@ and private key pem string:%@",deployHash,[PutDeployUtils.deploy getBodyHash],PutDeployUtils.secpPrivateKeyPemStr);
        Secp256k1Crypto * secp = [[Secp256k1Crypto alloc] init];
        NSString * signature = [secp secpSignMessageWithValue:deployHash withPrivateKey:PutDeployUtils.secpPrivateKeyPemStr];
        signature = [[NSString alloc] initWithFormat:@"02%@",signature];
        Approval * oneA = [[Approval alloc] init];
        oneA = [PutDeployUtils.deploy.approvals objectAtIndex:0];
        oneA.signature = signature;
        [PutDeployUtils.deploy.approvals removeAllObjects];
        [PutDeployUtils.deploy.approvals addObject:oneA];
        PutDeployUtils.putDeployCounter += 1;
        if(PutDeployUtils.putDeployCounter > 10) {
            PutDeployUtils.putDeployCounter = 0;
        } else {
            [self putDeploy:PutDeployUtils.deploy withCallIndex:@"call1"];
        }
    }
    
}
- (void) testPutDeploySecp256k1 {
    //return;
    Deploy * deploy = [[Deploy alloc] init];
    Ed25519Crypto * ed25519 = [[Ed25519Crypto alloc] init];
    bool isEd25519 = false;
    // Setup for Header
    DeployHeader * dh = [[DeployHeader alloc] init];
    NSString * accountEd25519 = @"01d12bf1e1789974fb288ca16fba7bd48e6ad7ec523991c3f26fbb7a3b446c2ea3";
    NSString * accountSecp256k1 = @"0202572ee4c44b925477dc7cd252f678e8cc407da31b2257e70e11cf6bcb278eb04b";
    if(isEd25519) {
        dh.account = accountEd25519;
    } else {
        dh.account = accountSecp256k1;
    }
    dh.timestamp = [ed25519 generateTime];// @"2022-05-22T08:13:49.424Z";
    NSLog(@"Time is:%@",dh.timestamp);
    dh.ttl = @"1h 30m";
    dh.gas_price = 1;
    dh.dependencies = [[NSMutableArray alloc] init];
    //[dh.dependencies addObject:@"0101010101010101010101010101010101010101010101010101010101010101"];
    dh.chain_name = @"casper-test";
    //dh.body_hash = @"798a65dae48dbefb398ba2f0916fa5591950768b7a467ca609a9a631caf13001";
    deploy.header = dh;
    //deploy.itsHash = @"1cdb7d55641a70e19e5fa0293a4e13bb47a55c5838e8935143a054fd23ce1b12";
    // Setup for payment
    ExecutableDeployItem * payment = [[ExecutableDeployItem alloc] init];
    payment.itsType = EDI_MODULEBYTES;
    payment.itsValue = [[NSMutableArray alloc] init];
    ExecutableDeployItem_ModuleBytes * edi_mb = [[ExecutableDeployItem_ModuleBytes alloc] init];
    edi_mb.module_bytes = @"";
    //set up RuntimeArgs with 1 element of NamedArg only
    //setup 1 NamedArgs
    NamedArg * oneNA = [[NamedArg alloc] init];
    oneNA.itsName = @"amount";
    CLValue * oneCLValue = [[CLValue alloc] init];
    CLType * oneCLType = [[CLType alloc] init];
    CLParsed * oneCLParse = [[CLParsed alloc] init];
    oneCLParse.itsValueStr = @"1000000000";
    oneCLParse.itsCLType = [[CLType alloc] init];
    oneCLParse.itsCLType.itsType = CLTYPE_U512;
    oneCLType.itsType = CLTYPE_U512;
    oneCLValue.cl_type = oneCLType;
    oneCLValue.parsed = oneCLParse;
    oneNA.itsCLValue = oneCLValue;
    RuntimeArgs * ra = [[RuntimeArgs alloc] init];
    ra.listArgs = [[NSMutableArray alloc] init];
    [ra.listArgs addObject:oneNA];
    edi_mb.args = ra;
    [payment.itsValue addObject:edi_mb];
    deploy.payment = payment;
    // Deploy session initialization, base on this
     // https://testnet.cspr.live/deploy/f49fbc552914fb3fcbbcf948a613c5413ef3f1afe2c29b9c8aea3ecc89207a8a
     // 1st namedArg
    ExecutableDeployItem * session = [[ExecutableDeployItem alloc] init];
    session.itsType = EDI_TRANSFER;
    session.itsValue = [[NSMutableArray alloc] init];
    ExecutableDeployItem_Transfer * ediSession = [[ExecutableDeployItem_Transfer alloc] init];
    //set up RuntimeArgs with 1 element of NamedArg only
    //setup 1st NamedArgs U512 cltype
    NamedArg * oneNASession = [[NamedArg alloc] init];
    oneNASession.itsName = @"amount";
    CLValue * oneCLValueSession = [[CLValue alloc] init];
    CLType * oneCLTypeSession = [[CLType alloc] init];
    CLParsed * oneCLParseSession = [[CLParsed alloc] init];
    oneCLParseSession.itsValueStr = @"3000000000";
    oneCLParseSession.itsCLType = [[CLType alloc] init];
    oneCLParseSession.itsCLType.itsType = CLTYPE_U512;
    oneCLTypeSession.itsType = CLTYPE_U512;
    oneCLParseSession.itsCLType = oneCLTypeSession;
    oneCLValueSession.cl_type = oneCLTypeSession;
    oneCLValueSession.parsed = oneCLParseSession;
    oneNASession.itsCLValue = oneCLValueSession;
    //setup 2nd NameArg PublicKey cltype
    NamedArg * oneNASession2 = [[NamedArg alloc] init];
    oneNASession2.itsName = @"target";
    CLValue * oneCLValueSession2 = [[CLValue alloc] init];
    CLType * oneCLTypeSession2 = [[CLType alloc] init];
    CLParsed * oneCLParseSession2 = [[CLParsed alloc] init];
    oneCLParseSession2.itsValueStr = @"015f12b5776c66d2782a4408d3910f64485dd4047448040955573aa026256cfa0a";
    oneCLParseSession2.itsCLType = [[CLType alloc]init];
    oneCLParseSession2.itsCLType.itsType = CLTYPE_PUBLICKEY;
    oneCLTypeSession2.itsType = CLTYPE_PUBLICKEY;
    oneCLParseSession2.itsCLType = oneCLTypeSession2;
    oneCLValueSession2.cl_type = oneCLTypeSession2;
    oneCLValueSession2.parsed = oneCLParseSession2;
    oneNASession2.itsCLValue = oneCLValueSession2;
    //setup 3rd NameArg - Option(U64) cltype
    NamedArg * oneNASession3 = [[NamedArg alloc] init];
    oneNASession3.itsName = @"id";
    CLValue * oneCLValueSession3 = [[CLValue alloc] init];
    CLType * oneCLTypeSession3 = [[CLType alloc] init];
    oneCLTypeSession3.itsType = CLTYPE_OPTION;
    oneCLTypeSession3.innerType1 = [[CLType alloc] init];
    oneCLTypeSession3.innerType1.itsType = CLTYPE_U64;
    CLParsed * oneCLParseSession3 = [[CLParsed alloc] init];
    CLParsed * parsed3Inner = [[CLParsed alloc] init];
    parsed3Inner.itsCLType = [[CLType alloc] init];
    parsed3Inner.itsCLType.itsType = CLTYPE_U64;
    parsed3Inner.itsValueStr = @"0";
    oneCLParseSession3.itsCLType = [[CLType alloc] init];
    oneCLParseSession3.itsCLType.itsType = CLTYPE_OPTION;
    oneCLParseSession3.itsCLType = oneCLTypeSession3;
    oneCLParseSession3.innerParsed1 = parsed3Inner;
    oneCLValueSession3.cl_type = oneCLTypeSession3;
    oneCLValueSession3.parsed = oneCLParseSession3;
    oneNASession3.itsCLValue = oneCLValueSession3;
    //setup 4th NameArg - key cltype
    NamedArg * oneNASession4 = [[NamedArg alloc] init];
    oneNASession4.itsName = @"spender";
    CLValue * oneCLValueSession4 = [[CLValue alloc] init];
    CLType * oneCLTypeSession4 = [[CLType alloc] init];
    oneCLTypeSession4.itsType = CLTYPE_KEY;
    CLParsed * oneCLParseSession4 = [[CLParsed alloc] init];
    oneCLParseSession4.itsValueStr = @"hash-dde7472639058717a42e22d297d6cf3e07906bb57bc28efceac3677f8a3dc83b";
    oneCLParseSession4.itsCLType = [[CLType alloc] init];
    oneCLParseSession4.itsCLType.itsType = CLTYPE_KEY;
    oneCLParseSession4.itsCLType = oneCLTypeSession4;
    oneCLValueSession4.cl_type = oneCLTypeSession4;
    oneCLValueSession4.parsed = oneCLParseSession4;
    oneCLValueSession4.bytes = @"01dde7472639058717a42e22d297d6cf3e07906bb57bc28efceac3677f8a3dc83b";
    oneNASession4.itsCLValue = oneCLValueSession4;
    
    //setup 5th NameArg - key ByteArray
    NamedArg * oneNASession5 = [[NamedArg alloc] init];
    oneNASession5.itsName = @"testBytesArray";
    CLValue * oneCLValueSession5 = [[CLValue alloc] init];
    CLType * oneCLTypeSession5 = [[CLType alloc] init];
    oneCLTypeSession5.itsType = CLTYPE_BYTEARRAY;
    CLParsed * oneCLParseSession5 = [[CLParsed alloc] init];
    oneCLParseSession5.itsValueStr = @"006d0be2fb64bcc8d170443fbadc885378fdd1c71975e2ddd349281dd9cc59cc";
    oneCLParseSession5.itsCLType = oneCLTypeSession5;
    oneCLValueSession5.cl_type = oneCLTypeSession5;
    oneCLValueSession5.parsed = oneCLParseSession5;
    oneCLValueSession5.bytes = @"006d0be2fb64bcc8d170443fbadc885378fdd1c71975e2ddd349281dd9cc59cc";
    oneNASession5.itsCLValue = oneCLValueSession5;
    //Put all the NameArg to the RuntimeArgs
    RuntimeArgs * raSession = [[RuntimeArgs alloc] init];
    raSession.listArgs = [[NSMutableArray alloc] init];
    [raSession.listArgs addObject:oneNASession];
    [raSession.listArgs addObject:oneNASession2];
    [raSession.listArgs addObject:oneNASession3];
    [raSession.listArgs addObject:oneNASession4];
   // [raSession.listArgs addObject:oneNASession5];
    ediSession.args = raSession;
    [session.itsValue addObject:ediSession];
    deploy.session = session;
    // Setup approvals
    NSMutableArray * listApprovals = [[NSMutableArray alloc] init];
   
   // oneA.signature = @"012dbf03817a51794a8e19e0724884075e6d1fbec326b766ecfa6658b41f81290da85e23b24e88b1c8d9761185c961daee1adab0649912a6477bcd2e69bd91bd08";
    
    //deploy.itsHash = @"01da3c604f71e0e7df83ff1ab4ef15bb04de64ca02e3d2b78de6950e8b5ee187";
    NSString * bodyHash = [deploy getBodyHash];
    dh.body_hash = bodyHash;
    NSString * deployHash = [deploy getDeployHash];
    deploy.itsHash = deployHash;
    NSLog(@"Deploy hash is:%@",deployHash);
    NSString * signature =  @"";
    if(isEd25519) {
        NSString * privateKeyStr = [ed25519 readPrivateKeyFromPemFile:@"ReadSwiftPrivateKeyEd25519.pem"];
        NSLog(@"Privaet kiey is:%@",privateKeyStr);
        signature = [ed25519 signMessageWithValue: deployHash withPrivateKey:privateKeyStr];
        NSLog(@"Signature is: %@",signature); //should add 01 prefix
        signature = [[NSString alloc] initWithFormat:@"01%@",signature];
        NSLog(@"Signature is: %@",signature);
    } else { //Sign with Secp256k1
        NSLog(@"Sign with Secp256k1");
        Secp256k1Crypto * secp = [[Secp256k1Crypto alloc] init];
        NSString * privateKeyPemStr = [secp secpReadPrivateKeyFromPemFile:@"ReadSwiftPrivateKeySecp256k1.pem"];
        PutDeployUtils.secpPrivateKeyPemStr = privateKeyPemStr;
        NSLog(@"private key pem string to putDeployUtils:%@",PutDeployUtils.secpPrivateKeyPemStr);
        signature = [secp secpSignMessageWithValue:deployHash withPrivateKey:privateKeyPemStr];
        signature = [[NSString alloc] initWithFormat:@"02%@",signature];
        NSLog(@"Signature is: %@",signature);
    }
    Approval * oneA = [[Approval alloc] init];
    if(isEd25519) {
        oneA.signer = accountEd25519;
    } else {
        oneA.signer = accountSecp256k1;
    }
    oneA.signature = signature;
    [listApprovals addObject:oneA];
    deploy.approvals = listApprovals;
    /*PutDeployRPC * putDeployRPC = [[PutDeployRPC alloc] init];
    PutDeployParams * putDeployParams = [[PutDeployParams alloc] init];
    putDeployParams.deploy = deploy;
    putDeployRPC.params = putDeployParams;
    [putDeployRPC putDeploy];*/
    [self putDeploy:deploy withCallIndex:@"call1"];
}
- (void) testPutDeployEd25519 {
    return;
    Deploy * deploy = [[Deploy alloc] init];
    Ed25519Crypto * ed25519 = [[Ed25519Crypto alloc] init];
    bool isEd25519 = true;
    // Setup for Header
    DeployHeader * dh = [[DeployHeader alloc] init];
    NSString * accountEd25519 = @"01d12bf1e1789974fb288ca16fba7bd48e6ad7ec523991c3f26fbb7a3b446c2ea3";
    NSString * accountSecp256k1 = @"0202572ee4c44b925477dc7cd252f678e8cc407da31b2257e70e11cf6bcb278eb04b";
    if(isEd25519) {
        dh.account = accountEd25519;
    } else {
        dh.account = accountSecp256k1;
    }
    dh.timestamp = [ed25519 generateTime];// @"2022-05-22T08:13:49.424Z";
    NSLog(@"Time is:%@",dh.timestamp);
    dh.ttl = @"1h 30m";
    dh.gas_price = 1;
    dh.dependencies = [[NSMutableArray alloc] init];
    //[dh.dependencies addObject:@"0101010101010101010101010101010101010101010101010101010101010101"];
    dh.chain_name = @"casper-test";
    //dh.body_hash = @"798a65dae48dbefb398ba2f0916fa5591950768b7a467ca609a9a631caf13001";
    deploy.header = dh;
    //deploy.itsHash = @"1cdb7d55641a70e19e5fa0293a4e13bb47a55c5838e8935143a054fd23ce1b12";
    // Setup for payment
    ExecutableDeployItem * payment = [[ExecutableDeployItem alloc] init];
    payment.itsType = EDI_MODULEBYTES;
    payment.itsValue = [[NSMutableArray alloc] init];
    ExecutableDeployItem_ModuleBytes * edi_mb = [[ExecutableDeployItem_ModuleBytes alloc] init];
    edi_mb.module_bytes = @"";
    //set up RuntimeArgs with 1 element of NamedArg only
    //setup 1 NamedArgs
    NamedArg * oneNA = [[NamedArg alloc] init];
    oneNA.itsName = @"amount";
    CLValue * oneCLValue = [[CLValue alloc] init];
    CLType * oneCLType = [[CLType alloc] init];
    CLParsed * oneCLParse = [[CLParsed alloc] init];
    oneCLParse.itsValueStr = @"1000000000";
    oneCLParse.itsCLType = [[CLType alloc] init];
    oneCLParse.itsCLType.itsType = CLTYPE_U512;
    oneCLType.itsType = CLTYPE_U512;
    oneCLValue.cl_type = oneCLType;
    oneCLValue.parsed = oneCLParse;
    oneNA.itsCLValue = oneCLValue;
    RuntimeArgs * ra = [[RuntimeArgs alloc] init];
    ra.listArgs = [[NSMutableArray alloc] init];
    [ra.listArgs addObject:oneNA];
    edi_mb.args = ra;
    [payment.itsValue addObject:edi_mb];
    deploy.payment = payment;
    // Deploy session initialization, base on this
     // https://testnet.cspr.live/deploy/f49fbc552914fb3fcbbcf948a613c5413ef3f1afe2c29b9c8aea3ecc89207a8a
     // 1st namedArg
    ExecutableDeployItem * session = [[ExecutableDeployItem alloc] init];
    session.itsType = EDI_TRANSFER;
    session.itsValue = [[NSMutableArray alloc] init];
    ExecutableDeployItem_Transfer * ediSession = [[ExecutableDeployItem_Transfer alloc] init];
    //set up RuntimeArgs with 1 element of NamedArg only
    //setup 1st NamedArgs U512 cltype
    NamedArg * oneNASession = [[NamedArg alloc] init];
    oneNASession.itsName = @"amount";
    CLValue * oneCLValueSession = [[CLValue alloc] init];
    CLType * oneCLTypeSession = [[CLType alloc] init];
    CLParsed * oneCLParseSession = [[CLParsed alloc] init];
    oneCLParseSession.itsValueStr = @"3000000000";
    oneCLParseSession.itsCLType = [[CLType alloc] init];
    oneCLParseSession.itsCLType.itsType = CLTYPE_U512;
    oneCLTypeSession.itsType = CLTYPE_U512;
    oneCLParseSession.itsCLType = oneCLTypeSession;
    oneCLValueSession.cl_type = oneCLTypeSession;
    oneCLValueSession.parsed = oneCLParseSession;
    oneNASession.itsCLValue = oneCLValueSession;
    //setup 2nd NameArg PublicKey cltype
    NamedArg * oneNASession2 = [[NamedArg alloc] init];
    oneNASession2.itsName = @"target";
    CLValue * oneCLValueSession2 = [[CLValue alloc] init];
    CLType * oneCLTypeSession2 = [[CLType alloc] init];
    CLParsed * oneCLParseSession2 = [[CLParsed alloc] init];
    oneCLParseSession2.itsValueStr = @"015f12b5776c66d2782a4408d3910f64485dd4047448040955573aa026256cfa0a";
    oneCLParseSession2.itsCLType = [[CLType alloc]init];
    oneCLParseSession2.itsCLType.itsType = CLTYPE_PUBLICKEY;
    oneCLTypeSession2.itsType = CLTYPE_PUBLICKEY;
    oneCLParseSession2.itsCLType = oneCLTypeSession2;
    oneCLValueSession2.cl_type = oneCLTypeSession2;
    oneCLValueSession2.parsed = oneCLParseSession2;
    oneNASession2.itsCLValue = oneCLValueSession2;
    //setup 3rd NameArg - Option(U64) cltype
    NamedArg * oneNASession3 = [[NamedArg alloc] init];
    oneNASession3.itsName = @"id";
    CLValue * oneCLValueSession3 = [[CLValue alloc] init];
    CLType * oneCLTypeSession3 = [[CLType alloc] init];
    oneCLTypeSession3.itsType = CLTYPE_OPTION;
    oneCLTypeSession3.innerType1 = [[CLType alloc] init];
    oneCLTypeSession3.innerType1.itsType = CLTYPE_U64;
    CLParsed * oneCLParseSession3 = [[CLParsed alloc] init];
    CLParsed * parsed3Inner = [[CLParsed alloc] init];
    parsed3Inner.itsCLType = [[CLType alloc] init];
    parsed3Inner.itsCLType.itsType = CLTYPE_U64;
    parsed3Inner.itsValueStr = @"0";
    oneCLParseSession3.itsCLType = [[CLType alloc] init];
    oneCLParseSession3.itsCLType.itsType = CLTYPE_OPTION;
    oneCLParseSession3.itsCLType = oneCLTypeSession3;
    oneCLParseSession3.innerParsed1 = parsed3Inner;
    oneCLValueSession3.cl_type = oneCLTypeSession3;
    oneCLValueSession3.parsed = oneCLParseSession3;
    oneNASession3.itsCLValue = oneCLValueSession3;
    //setup 4th NameArg - key cltype
    NamedArg * oneNASession4 = [[NamedArg alloc] init];
    oneNASession4.itsName = @"spender";
    CLValue * oneCLValueSession4 = [[CLValue alloc] init];
    CLType * oneCLTypeSession4 = [[CLType alloc] init];
    oneCLTypeSession4.itsType = CLTYPE_KEY;
    CLParsed * oneCLParseSession4 = [[CLParsed alloc] init];
    oneCLParseSession4.itsValueStr = @"hash-dde7472639058717a42e22d297d6cf3e07906bb57bc28efceac3677f8a3dc83b";
    oneCLParseSession4.itsCLType = [[CLType alloc] init];
    oneCLParseSession4.itsCLType.itsType = CLTYPE_KEY;
    oneCLParseSession4.itsCLType = oneCLTypeSession4;
    oneCLValueSession4.cl_type = oneCLTypeSession4;
    oneCLValueSession4.parsed = oneCLParseSession4;
    oneCLValueSession4.bytes = @"01dde7472639058717a42e22d297d6cf3e07906bb57bc28efceac3677f8a3dc83b";
    oneNASession4.itsCLValue = oneCLValueSession4;
    
    //setup 5th NameArg - key ByteArray
    NamedArg * oneNASession5 = [[NamedArg alloc] init];
    oneNASession5.itsName = @"testBytesArray";
    CLValue * oneCLValueSession5 = [[CLValue alloc] init];
    CLType * oneCLTypeSession5 = [[CLType alloc] init];
    oneCLTypeSession5.itsType = CLTYPE_BYTEARRAY;
    CLParsed * oneCLParseSession5 = [[CLParsed alloc] init];
    oneCLParseSession5.itsValueStr = @"006d0be2fb64bcc8d170443fbadc885378fdd1c71975e2ddd349281dd9cc59cc";
    oneCLParseSession5.itsCLType = oneCLTypeSession5;
    oneCLValueSession5.cl_type = oneCLTypeSession5;
    oneCLValueSession5.parsed = oneCLParseSession5;
    oneCLValueSession5.bytes = @"006d0be2fb64bcc8d170443fbadc885378fdd1c71975e2ddd349281dd9cc59cc";
    oneNASession5.itsCLValue = oneCLValueSession5;
    //Put all the NameArg to the RuntimeArgs
    RuntimeArgs * raSession = [[RuntimeArgs alloc] init];
    raSession.listArgs = [[NSMutableArray alloc] init];
    [raSession.listArgs addObject:oneNASession];
    [raSession.listArgs addObject:oneNASession2];
    [raSession.listArgs addObject:oneNASession3];
    [raSession.listArgs addObject:oneNASession4];
   // [raSession.listArgs addObject:oneNASession5];
    ediSession.args = raSession;
    [session.itsValue addObject:ediSession];
    deploy.session = session;
    // Setup approvals
    NSMutableArray * listApprovals = [[NSMutableArray alloc] init];
   
   // oneA.signature = @"012dbf03817a51794a8e19e0724884075e6d1fbec326b766ecfa6658b41f81290da85e23b24e88b1c8d9761185c961daee1adab0649912a6477bcd2e69bd91bd08";
    
    //deploy.itsHash = @"01da3c604f71e0e7df83ff1ab4ef15bb04de64ca02e3d2b78de6950e8b5ee187";
    NSString * bodyHash = [deploy getBodyHash];
    dh.body_hash = bodyHash;
    NSString * deployHash = [deploy getDeployHash];
    deploy.itsHash = deployHash;
    NSLog(@"Deploy hash is:%@",deployHash);
    NSString * signature =  @"";
    if(isEd25519) {
        NSString * privateKeyStr = [ed25519 readPrivateKeyFromPemFile:@"ReadSwiftPrivateKeyEd25519.pem"];
        NSLog(@"Privaet kiey is:%@",privateKeyStr);
        signature = [ed25519 signMessageWithValue: deployHash withPrivateKey:privateKeyStr];
        NSLog(@"Signature is: %@",signature); //should add 01 prefix
        signature = [[NSString alloc] initWithFormat:@"01%@",signature];
        NSLog(@"Signature is: %@",signature);
    } else { //Sign with Secp256k1
        Secp256k1Crypto * secp = [[Secp256k1Crypto alloc] init];
        NSString * privateKeyPemStr = [secp secpReadPrivateKeyFromPemFile:@"ReadSwiftPrivateKeySecp256k1.pem"];
        PutDeployUtils.secpPrivateKeyPemStr = privateKeyPemStr;
        signature = [secp secpSignMessageWithValue:deployHash withPrivateKey:privateKeyPemStr];
        signature = [[NSString alloc] initWithFormat:@"02%@",signature];
        NSLog(@"Signature is: %@",signature);
    }
    Approval * oneA = [[Approval alloc] init];
    if(isEd25519) {
        oneA.signer = accountEd25519;
    } else {
        oneA.signer = accountSecp256k1;
    }
    oneA.signature = signature;
    [listApprovals addObject:oneA];
    deploy.approvals = listApprovals;
    /*PutDeployRPC * putDeployRPC = [[PutDeployRPC alloc] init];
    PutDeployParams * putDeployParams = [[PutDeployParams alloc] init];
    putDeployParams.deploy = deploy;
    putDeployRPC.params = putDeployParams;
    [putDeployRPC putDeploy];*/
    [self putDeploy:deploy withCallIndex:@"call1"];
}
@end
