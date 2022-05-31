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
    // PRIVATE KEY LOAD FROM PEM FILE - POSITIVE PATH TEST
    //Test 2: Load private key from pem file - positive path - give the right pem file location/name with right pem file format.
    //Assign this value directly to the line below or change the value of pem file to this variable
    //ED25519_PRIVATE_KEY_PEMFILE in the ConstValues.m file
    NSString * pemFile = ED25519_PRIVATE_KEY_PEMFILE;
    //Reading the private key and put it into a string with value in this format
    //58_1_61_242_77_251_54_204_135_74_45_117_67_18_30_184_144_193_158_142_182_68_229_185_27_56_181_134_38_235_28_51
    NSString * privateKeyStr = [self loadPrivateKeyFromPemFile:pemFile];
    NSArray * arr = [privateKeyStr componentsSeparatedByString:@"_"];
    XCTAssert([privateKeyStr length] > 50);
    //The private key should be of 32 bytes
    XCTAssert([arr count] == 32);
    // PRIVATE KEY LOAD FROM PEM FILE - NEGATIVE PATH TEST
    //Test 3: Load private key from pem file - negative path - point to non-existing file - error string is returned
    NSString * pemFileWrong = @"Test.pem";
    NSString * privateKeyStrWrong = [self loadPrivateKeyFromPemFile:pemFileWrong];
    XCTAssert([privateKeyStrWrong isEqualToString:ERROR_STRING]);
    //Test 4: Load private key from pem file - negative path - point to existing file but with wrong format - error string is returned
    NSString * pemFileWrong2 = ED25519_PUBLIC_KEY_PEMFILE;
    NSString * privateKeyStrWrong2 = [self loadPrivateKeyFromPemFile:pemFileWrong2];
    XCTAssert([privateKeyStrWrong2 isEqualToString:ERROR_STRING]);
    
    // PUBLIC KEY LOAD FROM PEM FILE - POSITIVE PATH TEST
    //Test 5: Load public key from pem file - positive path - give the right pem file location/name with right pem file format.
    //Assign this value directly to the line below or change the value of pem file to this variable
    //ED25519_PUBLIC_KEY_PEMFILE in the ConstValues.m file
    NSString * publicPemFile = ED25519_PUBLIC_KEY_PEMFILE;
    NSString * publicKeyStr = [self loadPublicKeyFromPemFile:publicPemFile];
    NSArray * arrPublic = [publicKeyStr componentsSeparatedByString:@"_"];
    XCTAssert([publicKeyStr length] > 50);
    //The public key should be of 32 bytes
    XCTAssert([arrPublic count] == 32);
    
    // PUBLIC KEY LOAD FROM PEM FILE - NEGATIVE PATH TEST
    //Test 6: Load public key from pem file - negative path - point to non-existing file - error string is returned
    NSString * publicPemWrong = @"TestPublic.pem";
    NSString * publicStrWrong = [self loadPublicKeyFromPemFile:publicPemWrong];
    XCTAssert([publicStrWrong isEqualToString:ERROR_STRING]);
    //Test 7: Load private key from pem file - negative path - point to existing file but with wrong format - error string is returned
    NSString * publicPemWrong2 = ED25519_PRIVATE_KEY_PEMFILE;
    NSString * publicStrWrong2 = [self loadPublicKeyFromPemFile:publicPemWrong2];
    XCTAssert([publicStrWrong2 isEqualToString:ERROR_STRING]);
    
    // PRIVATE KEY WRITE TO PEM FILE - POSITIVE PATH TEST
    //Test 8: Generate and write private key to pem file - - please choose a correct folder with file name that does not exist
    NSString * writePrivatePemFile = @"/Users/hien/Ed25519/writePrivate1.pem";
    NSString * writePrivateKeyPemFile = [[NSString alloc] initWithFormat:@"%@%@",CRYPTO_PATH_ED25519,writePrivatePemFile];
    Boolean writePrivateResult = [self writePrivateKeyToPemFile:writePrivateKeyPemFile];
    XCTAssert(writePrivateResult == true);
    // PRIVATE KEY WRITE TO PEM FILE - POSITIVE PATH TEST
    //Test 9: Generate and write private key to wrong path file
    NSString * writePrivatePemFileWrongFile = @"wrongFolder/writePrivate1.pem";
    Boolean writePrivateResult2 = [self writePrivateKeyToPemFile:writePrivatePemFileWrongFile];
    XCTAssert(writePrivateResult2 == false);
    
    // PUBLIC KEY WRITE TO PEM FILE - POSITIVE PATH TEST
    //Test 10: Generate and write public key to pem file - please choose a correct folder with file name that does not exist
    NSString * writePublicPemFile = @"/Users/hien/Ed25519/writePublic1.pem";
   // NSString * writePublicKeyPemFile = [[NSString alloc] initWithFormat:@"%@%@",CRYPTO_PATH_ED25519,writePublicPemFile];
    Boolean writePublicResult = [self writePublicKeyToPemFile:writePublicPemFile];
    XCTAssert(writePublicResult == true);
    // PUBLIC KEY WRITE TO PEM FILE - POSITIVE PATH TEST
    //Test 11: Generate and write private key to wrong path file
    NSString * writePublicPemFileWrongFile = @"wrongFolder/writePublic1.pem";
    Boolean writePublicResult2 = [self writePublicKeyToPemFile:writePublicPemFileWrongFile];
    XCTAssert(writePublicResult2 == false);
    
    //TEST SIGN MESSAGE - POSITIVE PATH
    //Take message as a sample deploy hash
    NSString * message = @"8e9351d1f3de0e5e833fe0cb723485ebcc7d9fcf92888b2795281b1a35496ad6";
    //Generate the key pair
    CryptoKeyPair * keyPair1 = [[CryptoKeyPair alloc] init];
    Ed25519Crypto * ed25519 = [[Ed25519Crypto alloc] init];
    keyPair1 = [ed25519 generateKey];
    NSString * signature = [self signMessageWithMessage:message andPrivateKey:keyPair1.privateKeyStr];
    XCTAssert([signature length] == 128);
    //TEST VERIFY MESSAGE
    Boolean isSignatureValid = [self verifySignature:signature forOriginalMessage:message withPublicKey:keyPair1.publicKeyStr];
    XCTAssert(isSignatureValid == true);
    
    //TEST VERIFY MESSAGE - NEGATIVE PATH - USE A DIFFERENT PUBLIC KEY
    Ed25519Crypto * ed25519_2 = [[Ed25519Crypto alloc] init];
    CryptoKeyPair * keyPair2 = [ed25519_2 generateKey];
    Boolean isSignatureValid2 = [self verifySignature:signature forOriginalMessage:message withPublicKey:keyPair2.publicKeyStr];
    XCTAssert(isSignatureValid2 == false);
    
    //TEST SIGN MESSAGE - NEGATIVE PATH
    //Do the wrong thing - sign message with wrong private key string
    NSString * signatureWrong = [self signMessageWithMessage:message andPrivateKey:@"1_2_3_4_5"];
    XCTAssert([signatureWrong isEqualToString:ERROR_STRING]);
}
-(void) testKeyGeneration {
    CryptoKeyPair * keyPair1 = [[CryptoKeyPair alloc] init];
    Ed25519Crypto * ed25519 = [[Ed25519Crypto alloc] init];
    keyPair1 = [ed25519 generateKey];
    XCTAssert(keyPair1.privateKeyStr.length > 0);
    XCTAssert(keyPair1.publicKeyStr.length > 0);
}

-(NSString *) loadPrivateKeyFromPemFile:(NSString *) pemFile {
    Ed25519Crypto * ed25519 = [[Ed25519Crypto alloc] init];
    NSString * privateKeyStr = [ed25519 readPrivateKeyFromPemFile:pemFile];
    return privateKeyStr;
}
-(Boolean) writePrivateKeyToPemFile:(NSString*) fileName {
    //Generate the key pair
    CryptoKeyPair * keyPair1 = [[CryptoKeyPair alloc] init];
    Ed25519Crypto * ed25519 = [[Ed25519Crypto alloc] init];
    keyPair1 = [ed25519 generateKey];
    //Write the key to the given fileName
    Boolean isWriteSuccess = [ed25519 writePrivateKey:keyPair1.privateKeyStr toPemFile:fileName];
    return isWriteSuccess;
}
-(NSString*) loadPublicKeyFromPemFile: (NSString * ) pemFile {
    Ed25519Crypto * ed25519 = [[Ed25519Crypto alloc] init];
    NSString * publicKeyStr = [ed25519 readPublicKeyFromPemFile:pemFile];
    return publicKeyStr;
}
-(Boolean) writePublicKeyToPemFile:(NSString*) fileName {
    //Generate the key pair
    CryptoKeyPair * keyPair1 = [[CryptoKeyPair alloc] init];
    Ed25519Crypto * ed25519 = [[Ed25519Crypto alloc] init];
    keyPair1 = [ed25519 generateKey];
    //Write the key to the given fileName
    Boolean isWriteSuccess = [ed25519 writePublicKey:keyPair1.publicKeyStr toPemFile:fileName];
    return isWriteSuccess;
}

-(NSString*) signMessageWithMessage:(NSString*) message andPrivateKey:(NSString*) privateKeyStr {
    Ed25519Crypto * ed25519 = [[Ed25519Crypto alloc] init];
    NSString * signature = [ed25519 signMessageWithValue:message withPrivateKey:privateKeyStr];
    return  signature;
}
-(Boolean) verifySignature:(NSString*) signature forOriginalMessage:(NSString*) message withPublicKey:(NSString*) publicKeyStr{
    Ed25519Crypto * ed25519 = [[Ed25519Crypto alloc] init];
    Boolean result = [ed25519 verifyMessage:signature withPublicKey:publicKeyStr forOriginalMessage:message];
    return  result;
}
@end
