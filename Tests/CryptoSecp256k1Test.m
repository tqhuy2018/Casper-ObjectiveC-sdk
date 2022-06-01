#import <XCTest/XCTest.h>
#import <CasperSDKObjectiveC/Secp256k1Crypto.h>
#import <CasperSDKObjectiveC/CryptoKeyPair.h>
#import <CasperSDKObjectiveC/ConstValues.h>

@interface Secp256k1CryptoTest : XCTestCase

@end

@implementation Secp256k1CryptoTest
-(void) testAll {
    [self testKeyGeneration];
    // PRIVATE KEY LOAD FROM PEM FILE - POSITIVE PATH TEST
    //Test 2: Load private key from pem file - positive path - give the right pem file location/name with right pem file format.
    //Assign this value directly to the line below or change the value of pem file to this variable
    //SECP256K1_PRIVATE_KEY_PEMFILE in the ConstValues.m file
    NSString * pemFile = SECP256K1_PRIVATE_KEY_PEMFILE;
    //Reading the private key and put it into a string with value in this format
    /*
     -----BEGIN EC PRIVATE KEY-----
     MHQCAQEEIHkVqFr+bAr/U33m51e+ZIyGgk4lohASW+MT2fsUJIn3oAcGBSuBBAAK
     oUQDQgAEVy7kxEuSVHfcfNJS9njozEB9oxsiV+cOEc9ryyeOsEszu7fgJW3x88Hr
     Bpzm26oLuG8U8KtbCTV4Jhi2yfKfJg==
     -----END EC PRIVATE KEY-----
     */
    NSString * privateKeyStr = [self loadPrivateKeyFromPemFile:pemFile];
    XCTAssert([privateKeyStr length] > 100);
    
    // PRIVATE KEY LOAD FROM PEM FILE - NEGATIVE PATH TEST
    //Test 3: Load private key from pem file - negative path - point to non-existing file - error string is returned
    NSString * pemFileWrong = @"Test.pem";
    NSString * privateKeyStrWrong = [self loadPrivateKeyFromPemFile:pemFileWrong];
    XCTAssert([privateKeyStrWrong isEqualToString:ERROR_STRING]);
    //Test 4: Load private key from pem file - negative path - point to existing file but with wrong format - error string is returned
    NSString * pemFileWrong2 = SECP256K1_PUBLIC_KEY_PEMFILE;
    NSString * privateKeyStrWrong2 = [self loadPrivateKeyFromPemFile:pemFileWrong2];
    XCTAssert([privateKeyStrWrong2 isEqualToString:ERROR_STRING]);
    // PUBLIC KEY LOAD FROM PEM FILE - POSITIVE PATH TEST
    //Test 5: Load public key from pem file - positive path - give the right pem file location/name with right pem file format.
    //Assign this value directly to the line below or change the value of pem file to this variable
    //SECP256K1_PUBLIC_KEY_PEMFILE in the ConstValues.m file
    NSString * publicPemFile = SECP256K1_PUBLIC_KEY_PEMFILE;
    //Reading the public key and put it into a string with value in this format
    /*
     -----BEGIN PUBLIC KEY-----
     MFYwEAYHKoZIzj0CAQYFK4EEAAoDQgAExtEDVh+DpBKB0njgfkWQVSm/JddPoYRj
     GjCa/nvD3AZbWpRrnx2PmN7Z2Ax7AFZlKkZH/DXHzTw1hEzTMIcnwA==
     -----END PUBLIC KEY-----
     */
    NSString * publicKeyStr = [self loadPublicKeyFromPemFile:publicPemFile];
    XCTAssert([publicKeyStr length] > 100);
    
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
    NSString * writePrivatePemFile = [[NSString alloc] initWithFormat:@"%@writePrivate1.pem",CRYPTO_PATH_SECP256K1];;
    Boolean writePrivateResult = [self writePrivateKeyToPemFile:writePrivatePemFile];
    XCTAssert(writePrivateResult == true);
    // PRIVATE KEY WRITE TO PEM FILE - POSITIVE PATH TEST
    //Test 9: Generate and write private key to wrong path file
    NSString * writePrivatePemFileWrongFile = @"wrongFolder/writePrivate1.pem";
    Boolean writePrivateResult2 = [self writePrivateKeyToPemFile:writePrivatePemFileWrongFile];
    XCTAssert(writePrivateResult2 == false);
    
    // PUBLIC KEY WRITE TO PEM FILE - POSITIVE PATH TEST
    //Test 10: Generate and write public key to pem file - please choose a correct folder with file name that does not exist
    NSString * writePublicPemFile = [[NSString alloc] initWithFormat:@"%@writePublic1.pem",CRYPTO_PATH_SECP256K1];
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
    Secp256k1Crypto * secp256k1 = [[Secp256k1Crypto alloc] init];
    CryptoKeyPair * keyPair1 = [[CryptoKeyPair alloc] init];
    keyPair1 = [secp256k1 secpGenerateKey];
    NSString * signature = [self signMessageWithMessage:message andPrivateKey:keyPair1.privateKeyStr];
    XCTAssert([signature length] == 128);
    //TEST VERIFY MESSAGE
    Boolean isSignatureValid = [self verifySignature:signature forOriginalMessage:message withPublicKey:keyPair1.publicKeyStr];
    XCTAssert(isSignatureValid == true);
}
- (void) testKeyGeneration {
    Secp256k1Crypto * secp256k1 = [[Secp256k1Crypto alloc] init];
    CryptoKeyPair * keyPair = [[CryptoKeyPair alloc] init];
    keyPair = [secp256k1 secpGenerateKey];
    XCTAssert(keyPair.privateKeyStr.length > 0);
    XCTAssert(keyPair.publicKeyStr.length > 0);
}

-(NSString *) loadPrivateKeyFromPemFile:(NSString *) pemFile {
    Secp256k1Crypto * secp256k1 = [[Secp256k1Crypto alloc] init];
    NSString * privateKeyStr = [secp256k1 secpReadPrivateKeyFromPemFile:pemFile];
    return privateKeyStr;
}
-(Boolean) writePrivateKeyToPemFile:(NSString*) fileName {
    //Generate the key pair
    CryptoKeyPair * keyPair1 = [[CryptoKeyPair alloc] init];
    Secp256k1Crypto * secp256k1 = [[Secp256k1Crypto alloc] init];
    keyPair1 = [secp256k1 secpGenerateKey];
    //Write the key to the given fileName
    Boolean isWriteSuccess = [secp256k1 secpWritePrivateKey: keyPair1.privateKeyStr toPemFile:fileName];
    return isWriteSuccess;
}
-(NSString*) loadPublicKeyFromPemFile: (NSString * ) pemFile {
    Secp256k1Crypto * secp256k1 = [[Secp256k1Crypto alloc] init];
    NSString * publicKeyStr = [secp256k1 secpReadPublicKeyFromPemFile:pemFile];
    return publicKeyStr;
}
-(Boolean) writePublicKeyToPemFile:(NSString*) fileName {
    //Generate the key pair
    CryptoKeyPair * keyPair1 = [[CryptoKeyPair alloc] init];
    Secp256k1Crypto * secp256k1 = [[Secp256k1Crypto alloc] init];
    keyPair1 = [secp256k1 secpGenerateKey];
    //Write the key to the given fileName
    Boolean isWriteSuccess = [secp256k1 secpWritePublicKey: keyPair1.publicKeyStr toPemFile:fileName];
    return isWriteSuccess;
}

-(NSString*) signMessageWithMessage:(NSString*) message andPrivateKey:(NSString*) privateKeyStr {
    Secp256k1Crypto * secp256k1 = [[Secp256k1Crypto alloc] init];
    NSString * signature = [secp256k1 secpSignMessageWithValue :message withPrivateKey:privateKeyStr];
    return  signature;
}
-(Boolean) verifySignature:(NSString*) signature forOriginalMessage:(NSString*) message withPublicKey:(NSString*) publicKeyStr{
    Secp256k1Crypto * secp256k1 = [[Secp256k1Crypto alloc] init];
    Boolean result = [secp256k1 secpVerifyMessage:signature withPublicKey:publicKeyStr forOriginalMessage:message];
    return  result;
}
@end
