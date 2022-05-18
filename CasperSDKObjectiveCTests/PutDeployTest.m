#import <XCTest/XCTest.h>
#import "Utils.h"
#import "DeploySerializeHelper.h"
#import "DeployHeader.h"
#import "Deploy.h"
#import "Approval.h"
#import "ConstValues.h"
#import "ExecutableDeployItem_StoredContractByName.h"
#import "ExecutableDeployItem_Transfer.h"
#import "NamedArg.h"
#import "CLType.h"
#import "CLValue.h"
@interface PutDeployTest : XCTestCase

@end

@implementation PutDeployTest
- (void) testPutDeploy {
    Deploy * deploy = [[Deploy alloc] init];
    // Setup for Header
    DeployHeader * dh = [[DeployHeader alloc] init];
    dh.account = @"01d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900c";
    dh.timestamp = @"2020-11-17T00:39:24.072Z";
    dh.ttl = @"1h";
    dh.gas_price = 1;
    dh.body_hash = @"4811966d37fe5674a8af4001884ea0d9042d1c06668da0c963769c3a01ebd08f";
    dh.dependencies = [[NSMutableArray alloc] init];
    [dh.dependencies addObject:@"0101010101010101010101010101010101010101010101010101010101010101"];
    dh.chain_name = @"casper-example";
    dh.body_hash = @"body_hash SAMPLE";
    deploy.header = dh;
    deploy.itsHash = @"Deploy HASH SAMPLE";
    // Setup for payment
    ExecutableDeployItem * payment = [[ExecutableDeployItem alloc] init];
    payment.itsType = EDI_STORED_CONTRACT_BY_NAME;
    payment.itsValue = [[NSMutableArray alloc] init];
    ExecutableDeployItem_StoredContractByName * edi_mb = [[ExecutableDeployItem_StoredContractByName alloc] init];
    edi_mb.name = @"casper-test";
    edi_mb.entry_point = @"example-entry-point";
    //set up RuntimeArgs with 1 element of NamedArg only
    //setup 1 NamedArgs
    NamedArg * oneNA = [[NamedArg alloc] init];
    oneNA.itsName = @"amount";
    CLValue * oneCLValue = [[CLValue alloc] init];
    CLType * oneCLType = [[CLType alloc] init];
    CLParsed * oneCLParse = [[CLParsed alloc] init];
    oneCLParse.itsValueStr = @"1000000000";
    oneCLParse.itsCLTypeStr = CLTYPE_U512;
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
    oneCLParseSession.itsCLTypeStr = CLTYPE_U512;
    oneCLTypeSession.itsType = CLTYPE_U512;
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
    oneCLParseSession2.itsCLTypeStr = CLTYPE_PUBLICKEY;
    oneCLTypeSession2.itsType = CLTYPE_PUBLICKEY;
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
    oneCLParseSession3.itsValueStr = @"0";
    oneCLParseSession3.itsCLTypeStr = CLTYPE_OPTION;
    oneCLValueSession3.cl_type = oneCLTypeSession3;
    oneCLValueSession3.parsed = oneCLParseSession3;
    oneNASession3.itsCLValue = oneCLValueSession3;
    //setup 4th NameArg - key cltype
    NamedArg * oneNASession4 = [[NamedArg alloc] init];
    oneNASession4.itsName = @"id";
    CLValue * oneCLValueSession4 = [[CLValue alloc] init];
    CLType * oneCLTypeSession4 = [[CLType alloc] init];
    oneCLTypeSession4.itsType = CLTYPE_KEY;
    CLParsed * oneCLParseSession4 = [[CLParsed alloc] init];
    oneCLParseSession4.itsValueStr = @"hash-006d0be2fb64bcc8d170443fbadc885378fdd1c71975e2ddd349281dd9cc59cc";
    oneCLParseSession4.itsCLTypeStr = CLTYPE_KEY;
    oneCLValueSession4.cl_type = oneCLTypeSession4;
    oneCLValueSession4.parsed = oneCLParseSession4;
    oneCLValueSession4.bytes = @"01dde7472639058717a42e22d297d6cf3e07906bb57bc28efceac3677f8a3dc83b";
    oneNASession4.itsCLValue = oneCLValueSession4;
    
    //setup 4th NameArg - key ByteArray
    NamedArg * oneNASession4 = [[NamedArg alloc] init];
    oneNASession4.itsName = @"id";
    CLValue * oneCLValueSession4 = [[CLValue alloc] init];
    CLType * oneCLTypeSession4 = [[CLType alloc] init];
    oneCLTypeSession4.itsType = CLTYPE_BYTEARRAY;
    CLParsed * oneCLParseSession4 = [[CLParsed alloc] init];
    oneCLParseSession4.itsValueStr = @"hash-dde7472639058717a42e22d297d6cf3e07906bb57bc28efceac3677f8a3dc83b";
    oneCLParseSession4.itsCLTypeStr = CLTYPE_BYTEARRAY;
    oneCLValueSession4.cl_type = oneCLTypeSession4;
    oneCLValueSession4.parsed = oneCLParseSession4;
    oneCLValueSession4.bytes = @"01dde7472639058717a42e22d297d6cf3e07906bb57bc28efceac3677f8a3dc83b";
    oneNASession4.itsCLValue = oneCLValueSession4;
    //Put all the NameArg to the RuntimeArgs
    RuntimeArgs * raSession = [[RuntimeArgs alloc] init];
    raSession.listArgs = [[NSMutableArray alloc] init];
    [raSession.listArgs addObject:oneNASession];
    [raSession.listArgs addObject:oneNASession2];
    [raSession.listArgs addObject:oneNASession3];
    [raSession.listArgs addObject:oneNASession4];
    ediSession.args = raSession;
    [session.itsValue addObject:ediSession];
    deploy.session = session;
    // Setup approvals
    NSMutableArray * listApprovals = [[NSMutableArray alloc] init];
    Approval * oneA = [[Approval alloc] init];
    oneA.signer = @"01d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900c";
    oneA.signature = @"012dbf03817a51794a8e19e0724884075e6d1fbec326b766ecfa6658b41f81290da85e23b24e88b1c8d9761185c961daee1adab0649912a6477bcd2e69bd91bd08";
    [listApprovals addObject:oneA];
    deploy.approvals = listApprovals;
    deploy.itsHash = @"01da3c604f71e0e7df83ff1ab4ef15bb04de64ca02e3d2b78de6950e8b5ee187";
    NSString * deployJsonString = [deploy toPutDeployParameterStr];
}
@end
