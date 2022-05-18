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
@interface Serialization_DeployTest : XCTestCase

@end

@implementation Serialization_DeployTest
-(void) testDeployApprovalSerialization {
    // Test for list of 1 approval
    NSMutableArray * listApprovals = [[NSMutableArray alloc] init];
    Approval * oneA = [[Approval alloc] init];
    oneA.signer = @"0149bae8d79362d088197f8f68c5e8431fa074f780d290a2b1988b7201872cb5bc";
    oneA.signature = @"012d56b8a5620326484df6cdf770e6d2e054e64deabba5c4f34573bd6331239f8a4bfe2db9c14ec19b0cb4d6694bb3c1727e3d33501187391cfd47136840117b04";
    [listApprovals addObject:oneA];
    NSString * listASerialization = [DeploySerializeHelper serializeForDeployApproval:listApprovals];
    XCTAssert([listASerialization isEqualToString:@"010000000149bae8d79362d088197f8f68c5e8431fa074f780d290a2b1988b7201872cb5bc012d56b8a5620326484df6cdf770e6d2e054e64deabba5c4f34573bd6331239f8a4bfe2db9c14ec19b0cb4d6694bb3c1727e3d33501187391cfd47136840117b04"]);
    
    //Test for list of 2 approval
    NSMutableArray * listApprovals2 = [[NSMutableArray alloc] init];
    Approval * oneA1 = [[Approval alloc] init];
    oneA1.signer = @"013b665cdf8447cec49c26ee66ae80e749a39c103b085e7229a23e0a21f913d9a7";
    oneA1.signature = @"017c47aaf78b6d086327c480ab5fde436a2646fd3030c48b764c8c5636379af69176a666f2bc8996dbb32f7413028a5c7387f73336dfcec2588e65eae37c4b2204";
    Approval * oneA2 = [[Approval alloc] init];
    oneA2.signer = @"01282d57031a3c5a2acd33eb3fe75b218150d46f2272f6dfc31acd9b41253fbc29";
    oneA2.signature = @"012ff0833208a80630ca24b7ade59402479df8e50cc5539d48f065728cc156a064685befd8149df81c2af04bd1120ce11f906880f040e0906c19808be02f626b01";
    [listApprovals2 addObject:oneA1];
    [listApprovals2 addObject:oneA2];
    NSString * listASerialization2 = [DeploySerializeHelper serializeForDeployApproval:listApprovals2];
    XCTAssert([listASerialization2 isEqualToString:@"02000000013b665cdf8447cec49c26ee66ae80e749a39c103b085e7229a23e0a21f913d9a7017c47aaf78b6d086327c480ab5fde436a2646fd3030c48b764c8c5636379af69176a666f2bc8996dbb32f7413028a5c7387f73336dfcec2588e65eae37c4b220401282d57031a3c5a2acd33eb3fe75b218150d46f2272f6dfc31acd9b41253fbc29012ff0833208a80630ca24b7ade59402479df8e50cc5539d48f065728cc156a064685befd8149df81c2af04bd1120ce11f906880f040e0906c19808be02f626b01"]);
}
- (void) testDeploySerialization {
    return;
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
    deploy.header = dh;
    // Setup for payment
    ExecutableDeployItem * payment = [[ExecutableDeployItem alloc] init];
    payment.itsType = EDI_STORED_CONTRACT_BY_NAME;
    payment.itsValue = [[NSMutableArray alloc] init];
    ExecutableDeployItem_StoredContractByName * edi_mb = [[ExecutableDeployItem_StoredContractByName alloc] init];
    edi_mb.name = @"casper-example";
    edi_mb.entry_point = @"example-entry-point";
    //set up RuntimeArgs with 1 element of NamedArg only
    //setup 1 NamedArgs
    NamedArg * oneNA = [[NamedArg alloc] init];
    oneNA.itsName = @"quantity";
    CLValue * oneCLValue = [[CLValue alloc] init];
    CLType * oneCLType = [[CLType alloc] init];
    CLParsed * oneCLParse = [[CLParsed alloc] init];
    oneCLParse.itsValueStr = @"1000";
    oneCLParse.itsCLTypeStr = CLTYPE_I32;
    oneCLType.itsType = CLTYPE_I32;
    oneCLValue.cl_type = oneCLType;
    oneCLValue.parsed = oneCLParse;
    oneNA.itsCLValue = oneCLValue;
    RuntimeArgs * ra = [[RuntimeArgs alloc] init];
    ra.listArgs = [[NSMutableArray alloc] init];
    [ra.listArgs addObject:oneNA];
    edi_mb.args = ra;
    [payment.itsValue addObject:edi_mb];
    deploy.payment = payment;
    // Setup for session
    ExecutableDeployItem * session = [[ExecutableDeployItem alloc] init];
    session.itsType = EDI_TRANSFER;
    session.itsValue = [[NSMutableArray alloc] init];
    ExecutableDeployItem_Transfer * ediSession = [[ExecutableDeployItem_Transfer alloc] init];
    //set up RuntimeArgs with 1 element of NamedArg only
    //setup 1 NamedArgs
    NamedArg * oneNASession = [[NamedArg alloc] init];
    oneNASession.itsName = @"amount";
    CLValue * oneCLValueSession = [[CLValue alloc] init];
    CLType * oneCLTypeSession = [[CLType alloc] init];
    CLParsed * oneCLParseSession = [[CLParsed alloc] init];
    oneCLParseSession.itsValueStr = @"1000";
    oneCLParseSession.itsCLTypeStr = CLTYPE_I32;
    oneCLTypeSession.itsType = CLTYPE_I32;
    oneCLValueSession.cl_type = oneCLTypeSession;
    oneCLValueSession.parsed = oneCLParseSession;
    oneNASession.itsCLValue = oneCLValueSession;
    RuntimeArgs * raSession = [[RuntimeArgs alloc] init];
    raSession.listArgs = [[NSMutableArray alloc] init];
    [raSession.listArgs addObject:oneNASession];
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
    NSString * deploySerialization = [DeploySerializeHelper serializeForDeploy:deploy];
    XCTAssert([deploySerialization isEqualToString:@"01d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900ca856a4d37501000080ee36000000000001000000000000004811966d37fe5674a8af4001884ea0d9042d1c06668da0c963769c3a01ebd08f0100000001010101010101010101010101010101010101010101010101010101010101010e0000006361737065722d6578616d706c6501da3c604f71e0e7df83ff1ab4ef15bb04de64ca02e3d2b78de6950e8b5ee187020e0000006361737065722d6578616d706c65130000006578616d706c652d656e7472792d706f696e7401000000080000007175616e7469747904000000e803000001050100000006000000616d6f756e7404000000e8030000010100000001d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900c012dbf03817a51794a8e19e0724884075e6d1fbec326b766ecfa6658b41f81290da85e23b24e88b1c8d9761185c961daee1adab0649912a6477bcd2e69bd91bd08"]);
}
-(void) testDeployHeaderSerialization {
    DeployHeader * dh = [[DeployHeader alloc] init];
    dh.account = @"01d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900c";
    dh.timestamp = @"2020-11-17T00:39:24.072Z";
    dh.ttl = @"1h";
    dh.gas_price = 1;
    dh.body_hash = @"4811966d37fe5674a8af4001884ea0d9042d1c06668da0c963769c3a01ebd08f";
    dh.dependencies = [[NSMutableArray alloc] init];
    [dh.dependencies addObject:@"0101010101010101010101010101010101010101010101010101010101010101"];
    dh.chain_name = @"casper-example";
    NSString * headerSerialization = [DeploySerializeHelper serializeForHeader:dh];
    XCTAssert([headerSerialization isEqualToString:@"01d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900ca856a4d37501000080ee36000000000001000000000000004811966d37fe5674a8af4001884ea0d9042d1c06668da0c963769c3a01ebd08f0100000001010101010101010101010101010101010101010101010101010101010101010e0000006361737065722d6578616d706c65"]);
}
@end
