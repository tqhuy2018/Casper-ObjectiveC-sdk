#import <XCTest/XCTest.h>
#import <CasperSDKObjectiveC/NamedArg.h>
#import <CasperSDKObjectiveC/CLValue.h>
#import <CasperSDKObjectiveC/CLType.h>
#import <CasperSDKObjectiveC/ConstValues.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem_ModuleBytes.h>
#import <CasperSDKObjectiveC/ExecutableDeployItemSerializationHelper.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem_StoredContractByHash.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem_StoredContractByName.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem_StoredVersionedContractByHash.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem_StoredVersionedContractByName.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem_Transfer.h>
#import <CasperSDKObjectiveC/RuntimeArgs.h>
@interface Serialization_ExecutableDeployItemTest : XCTestCase

@end

@implementation Serialization_ExecutableDeployItemTest

- (void) testExecutableDeployItemSerialization {
    //Test for ModuleBytes
    ExecutableDeployItem * edi = [[ExecutableDeployItem alloc] init];
    edi.itsType = EDI_MODULEBYTES;
    edi.itsValue = [[NSMutableArray alloc] init];
    
    ExecutableDeployItem_ModuleBytes * edi_mb = [[ExecutableDeployItem_ModuleBytes alloc] init];
    edi_mb.module_bytes = @"";
    //set up RuntimeArgs with 1 element of NamedArg only
    //setup 1 NamedArgs
    NamedArg * oneNA = [[NamedArg alloc] init];
    oneNA.itsName = @"amount";
    CLValue * oneCLValue = [[CLValue alloc] init];
    CLType * oneCLType = [[CLType alloc] init];
    CLParsed * oneCLParse = [[CLParsed alloc] init];
    oneCLParse.itsValueStr = @"100000000";
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
   
    [edi.itsValue addObject:edi_mb];
    NSString * mbs = [ExecutableDeployItemSerializationHelper serializeForExecutableDeployItem:edi];
    XCTAssert([mbs isEqualToString:@"00000000000100000006000000616d6f756e74050000000400e1f50508"]);
    
    //Test for StoredContractByHash
    ExecutableDeployItem_StoredContractByHash * item2 = [[ExecutableDeployItem_StoredContractByHash alloc] init];
    item2.itsHash = @"c4c411864f7b717c27839e56f6f1ebe5da3f35ec0043f437324325d65a22afa4";
    item2.entry_point = @"pclphXwfYmCmdITj8hnh";
    //Setup args
    
    NamedArg * oneNA2 = [[NamedArg alloc] init];
    oneNA2.itsName = @"amount";
    CLValue * oneCLValue2 = [[CLValue alloc] init];
    CLType * oneCLType2 = [[CLType alloc] init];
    CLParsed * oneCLParse2 = [[CLParsed alloc] init];
    oneCLParse2.itsValueStr = @"999888666555444999887988887777666655556666777888999666999";
    oneCLParse2.itsCLType = [[CLType alloc] init];
    oneCLParse2.itsCLType.itsType = CLTYPE_U512;
    oneCLType2.itsType = CLTYPE_U512;
    oneCLValue2.cl_type = oneCLType2;
    oneCLValue2.parsed = oneCLParse2;
    oneNA2.itsCLValue = oneCLValue2;
    RuntimeArgs * ra2 = [[RuntimeArgs alloc] init];
    ra2.listArgs = [[NSMutableArray alloc] init];
    [ra2.listArgs addObject:oneNA2];
    item2.args = ra2;
    [edi.itsValue removeAllObjects];
    [edi.itsValue addObject:item2];
    edi.itsType = EDI_STORED_CONTRACT_BY_HASH;
    NSString * serial2 = [ExecutableDeployItemSerializationHelper serializeForExecutableDeployItem:edi];
    XCTAssert([serial2 isEqualToString:@"01c4c411864f7b717c27839e56f6f1ebe5da3f35ec0043f437324325d65a22afa41400000070636c7068587766596d436d6449546a38686e680100000006000000616d6f756e74190000001837f578fca55492f299ea354eaca52b6e9de47d592453c72808"]);
    
    
    //Test for StoredContractByName
    ExecutableDeployItem_StoredContractByName * item3 = [[ExecutableDeployItem_StoredContractByName alloc] init];
    item3.name = @"casper-example";
    item3.entry_point = @"example-entry-point";
    //Setup args
    NamedArg * oneNA3 = [[NamedArg alloc] init];
    oneNA3.itsName = @"quantity";
    CLValue * oneCLValue3 = [[CLValue alloc] init];
    CLType * oneCLType3 = [[CLType alloc] init];
    CLParsed * oneCLParse3 = [[CLParsed alloc] init];
    oneCLParse3.itsValueStr = @"1000";
    oneCLParse3.itsCLType = [[CLType alloc] init];
    oneCLParse3.itsCLType.itsType = CLTYPE_I32;
    oneCLType3.itsType = CLTYPE_I32;
    oneCLValue3.cl_type = oneCLType3;
    oneCLValue3.parsed = oneCLParse3;
    oneNA3.itsCLValue = oneCLValue3;
    RuntimeArgs * ra3 = [[RuntimeArgs alloc] init];
    ra3.listArgs = [[NSMutableArray alloc] init];
    [ra3.listArgs addObject:oneNA3];
    item3.args = ra3;
    [edi.itsValue removeAllObjects];
    [edi.itsValue addObject:item3];
    edi.itsType = EDI_STORED_CONTRACT_BY_NAME;
    NSString * serial3 = [ExecutableDeployItemSerializationHelper serializeForExecutableDeployItem:edi];
    XCTAssert([serial3 isEqualToString:@"020e0000006361737065722d6578616d706c65130000006578616d706c652d656e7472792d706f696e7401000000080000007175616e7469747904000000e803000001"]);
    
    //Test for StoredVersionedContractByHash
    
    ExecutableDeployItem_StoredVersionedContractByHash * item4 = [[ExecutableDeployItem_StoredVersionedContractByHash alloc] init];
    item4.itsHash = @"b348fdd0d0b3f66468687df93141b5924f6bb957d5893c08b60d5a78d0b9a423";
    item4.entry_point = @"PsLz5c7JsqT8BK8ll0kF";
    item4.is_version_exists = false;//This is set for Version to nil
    //Setup args
    item4.args = ra2;
    [edi.itsValue removeAllObjects];
    [edi.itsValue addObject:item4];
    edi.itsType = EDI_STORED_VERSIONED_CONTRACT_BY_HASH;
    NSString * serial4 = [ExecutableDeployItemSerializationHelper serializeForExecutableDeployItem:edi];
    XCTAssert([serial4 isEqualToString:@"03b348fdd0d0b3f66468687df93141b5924f6bb957d5893c08b60d5a78d0b9a423001400000050734c7a3563374a73715438424b386c6c306b460100000006000000616d6f756e74190000001837f578fca55492f299ea354eaca52b6e9de47d592453c72808"]);
    //Test for StoredVersionedContractByName
    
    ExecutableDeployItem_StoredVersionedContractByName * item5 = [[ExecutableDeployItem_StoredVersionedContractByName alloc] init];
    item5.name = @"lWJWKdZUEudSakJzw1tn";
    item5.entry_point = @"S1cXRT3E1jyFlWBAIVQ8";
    item5.is_version_exists = true;//This is set for Version to nil
    item5.version = 1632552656;
    //Setup args
    item5.args = ra2;
    [edi.itsValue removeAllObjects];
    [edi.itsValue addObject:item5];
    edi.itsType = EDI_STORED_VERSIONED_CONTRACT_BY_NAME;
    NSString * serial5 = [ExecutableDeployItemSerializationHelper serializeForExecutableDeployItem:edi];
    XCTAssert([serial5 isEqualToString:@"04140000006c574a574b645a5545756453616b4a7a7731746e01d0c64e61140000005331635852543345316a79466c574241495651380100000006000000616d6f756e74190000001837f578fca55492f299ea354eaca52b6e9de47d592453c72808"]);
    
    //Test for Transfer
    ExecutableDeployItem_Transfer * item6 = [[ExecutableDeployItem_Transfer alloc] init];
    //Setup args
    oneNA3.itsName = @"amount";
    item6.args = ra3;
    [edi.itsValue removeAllObjects];
    [edi.itsValue addObject:item6];
    edi.itsType = EDI_TRANSFER;
    NSString * serial6 = [ExecutableDeployItemSerializationHelper serializeForExecutableDeployItem:edi];
    XCTAssert([serial6 isEqualToString:@"050100000006000000616d6f756e7404000000e803000001"]);
}

@end
