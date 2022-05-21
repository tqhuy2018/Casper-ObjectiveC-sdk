#import <XCTest/XCTest.h>
#import "Utils.h"
#import "DeploySerializeHelper.h"
#import "DeployHeader.h"
#import "Deploy.h"
#import "Approval.h"
#import "ConstValues.h"
#import "ExecutableDeployItem_StoredContractByName.h"
#import "ExecutableDeployItem_ModuleBytes.h"
#import "ExecutableDeployItem_Transfer.h"
#import "NamedArg.h"
#import "CLType.h"
#import "CLValue.h"
#import "Ed25519Crypto.h"
#import "Ed25519KeyPair.h"
#import <CasperSDKObjectiveC/CasperSDKObjectiveC-Swift.h>
//#import <CasperCryptoHandlePackage/CasperCryptoHandlePackage-Swift.h>
//#import "CasperSDKObjectiveC-swift.h"
@import CasperCryptoHandlePackage;
@interface PutDeployTest : XCTestCase

@end

@implementation PutDeployTest
- (void) testPutDeploy {
   /* TestCall * a = [[TestCall alloc] init];
    [a TestFunc];
    Sample1 * sample = [[Sample1 alloc] init];
    [sample  sayHello];
    [sample sayHello2WithNewName:@"Nguyen Van A" newAge:50];
    [a TestParameterWithPara1:@"Ba Thuoc" para2:20 para3:sample];
   // Ed25519 * ed = [[Ed25519Handle alloc] init];
   //[ed testCall];*/
    Deploy * deploy = [[Deploy alloc] init];
    // Setup for Header
    DeployHeader * dh = [[DeployHeader alloc] init];
    dh.account = @"0202572ee4c44b925477dc7cd252f678e8cc407da31b2257e70e11cf6bcb278eb04b";
    dh.timestamp = @"2022-05-18T07:49:43.637Z";
    dh.ttl = @"1h 30m";
    dh.gas_price = 1;
    
    dh.dependencies = [[NSMutableArray alloc] init];
    //[dh.dependencies addObject:@"0101010101010101010101010101010101010101010101010101010101010101"];
    dh.chain_name = @"casper-test";
    dh.body_hash = @"798a65dae48dbefb398ba2f0916fa5591950768b7a467ca609a9a631caf13001";
    deploy.header = dh;
    deploy.itsHash = @"1cdb7d55641a70e19e5fa0293a4e13bb47a55c5838e8935143a054fd23ce1b12";
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
    [raSession.listArgs addObject:oneNASession5];
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
    NSString * bodyHash = [deploy getBodyHash];
    dh.body_hash = bodyHash;
    NSString * deployHash = [deploy getDeployHash];
    //deploy.hash = DeploySerialization.getHeaderHash(fromDeployHeader: deployHeader)
   /* Ed25519Cryto * ed25519 = [[Ed25519Cryto alloc] init];
    KeyPairClass * kpc = [ed25519 generateKeyPair];
    NSLog(@"Private key is:%@, public key is:%@",kpc.privateKeyInStr,kpc.publicKeyInStr);*/
    Ed25519Crypto * ed25519 = [[Ed25519Crypto alloc] init];
    Ed25519KeyPair * keyPair = [ed25519 generateKey];
    NSLog(@"Deploy hash is:%@",deployHash);
    NSLog(@"Private key is:%@, public key is:%@",keyPair.privateKeyStr,keyPair.publicKeyStr);
    NSString * signature = [ed25519 signMessageWithValue: deployHash withPrivateKey:keyPair.privateKeyStr];
    [ed25519 writePrivateKeyToPemFile:@"Ed25519PrivateKey1.pem"];
    [ed25519 readPrivateKeyFromPemFile:@"ReadSwiftPrivateKeyEd25519.pem"];
    NSLog(@"Signature is: %@",signature); //should add 01 prefix
    Boolean isCorrect = [ed25519 verifyMessage:signature withPublicKey:keyPair.publicKeyStr forOriginalMessage:deployHash];
    if(isCorrect) {
        NSLog(@"Verify success!!!!");
    } else {
        NSLog(@"Verify fail!!!!");
    }
    NSLog(@"Signature is: %@",signature);
    NSString * deployJsonString = [deploy toPutDeployParameterStr];
}
@end
