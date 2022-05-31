#import <XCTest/XCTest.h>
@import CasperCryptoHandlePackage;
#import <CasperSDKObjectiveC/Ed25519Crypto.h>
#import <CasperSDKObjectiveC/CryptoKeyPair.h>
#import <CasperSDKObjectiveC/ConstValues.h>
@interface Ed25519CryptoTest : XCTestCase
@property CryptoKeyPair * keyPair;
@end

@implementation Ed25519CryptoTest
-(void) testAll {
    // Test 1: Key generation
    [self testKeyGeneration];
    
    //Test 2: Load private key from pem file - positive path - give the right pem file location/name with right pem file format.
    //Assign this value directly to the line below or change the value of pem file to this variable
    //ED25519_PRIVATE_KEY_PEMFILE in the ConstValues.m file
    NSString * pemFile = ED25519_PRIVATE_KEY_PEMFILE;
    //Reading the private key and put it into a string with value in this format
    //58_1_61_242_77_251_54_204_135_74_45_117_67_18_30_184_144_193_158_142_182_68_229_185_27_56_181_134_38_235_28_51
    NSString * privateKeyStr = [self testLoadPrivateKeyFromPemFile:pemFile];
    NSArray * arr = [privateKeyStr componentsSeparatedByString:@"_"];
    XCTAssert([privateKeyStr length] > 50);
    //The private key should be of 32 bytes
    XCTAssert([arr count] == 32);
    
    //Test 3: Load private key from pem file - negative path - point to non-existing file - error string is returned
    NSString * pemFileWrong = @"Test.pem";
    NSString * privateKeyStrWrong = [self testLoadPrivateKeyFromPemFile:pemFileWrong];
    XCTAssert([privateKeyStrWrong isEqualToString:ERROR_STRING]);
    //Test 4: Load private key from pem file - negative path - point to existing file but with wrong format - error string is returned
    NSString * pemFileWrong2 = ED25519_PUBLIC_KEY_PEMFILE;
    NSString * privateKeyStrWrong2 = [self testLoadPrivateKeyFromPemFile:pemFileWrong2];
    XCTAssert([privateKeyStrWrong2 isEqualToString:ERROR_STRING]);
    
    //Test 5: Load public key from pem file - positive path - give the right pem file location/name with right pem file format.
    //Assign this value directly to the line below or change the value of pem file to this variable
    //ED25519_PUBLIC_KEY_PEMFILE in the ConstValues.m file
    NSString * publicPemFile = ED25519_PUBLIC_KEY_PEMFILE;
    NSString * publicKeyStr = [self testLoadPublicKeyFromPemFile:publicPemFile];
    NSArray * arrPublic = [publicKeyStr componentsSeparatedByString:@"_"];
    XCTAssert([publicKeyStr length] > 50);
    //The public key should be of 32 bytes
    XCTAssert([arrPublic count] == 32);
    
    //Test 6: Load public key from pem file - negative path - point to non-existing file - error string is returned
    NSString * publicPemWrong = @"TestPublic.pem";
    NSString * publicStrWrong = [self testLoadPublicKeyFromPemFile:publicPemWrong];
    XCTAssert([publicStrWrong isEqualToString:ERROR_STRING]);
    //Test 7: Load private key from pem file - negative path - point to existing file but with wrong format - error string is returned
    NSString * publicPemWrong2 = ED25519_PRIVATE_KEY_PEMFILE;
    NSString * publicStrWrong2 = [self testLoadPublicKeyFromPemFile:publicPemWrong2];
    XCTAssert([publicStrWrong2 isEqualToString:ERROR_STRING]);
    
}
-(void) testKeyGeneration {
    CryptoKeyPair * keyPair1 = [[CryptoKeyPair alloc] init];
    Ed25519Crypto * ed25519 = [[Ed25519Crypto alloc] init];
    keyPair1 = [ed25519 generateKey];
    XCTAssert(keyPair1.privateKeyStr.length > 0);
    XCTAssert(keyPair1.publicKeyStr.length > 0);
}

-(NSString *) testLoadPrivateKeyFromPemFile:(NSString *) pemFile {
    Ed25519Crypto * ed25519 = [[Ed25519Crypto alloc] init];
    NSString * privateKeyStr = [ed25519 readPrivateKeyFromPemFile:pemFile];
    return privateKeyStr;
}
-(Boolean) testWritePrivateKeyToPemFile:(NSString*) fileName {
    //Generate the key pair
    CryptoKeyPair * keyPair1 = [[CryptoKeyPair alloc] init];
    Ed25519Crypto * ed25519 = [[Ed25519Crypto alloc] init];
    keyPair1 = [ed25519 generateKey];
    Boolean isWriteSuccess = [ed25519 writePrivateKey:keyPair1.privateKeyStr toPemFile:fileName];
    return isWriteSuccess;
}
-(NSString*) testLoadPublicKeyFromPemFile: (NSString * ) pemFile {
    Ed25519Crypto * ed25519 = [[Ed25519Crypto alloc] init];
    NSString * publicKeyStr = [ed25519 readPublicKeyFromPemFile:pemFile];
    return publicKeyStr;
}
-(void) testWritePublicKeyToPemFile {
    
}

-(void) testSignMessage {
   
}
-(void) testVerifyMessage {
    
}
@end
