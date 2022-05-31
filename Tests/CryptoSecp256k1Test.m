#import <XCTest/XCTest.h>
#import <CasperSDKObjectiveC/Secp256k1Crypto.h>
#import <CasperSDKObjectiveC/CryptoKeyPair.h>
@interface Secp256k1CryptoTest : XCTestCase

@end

@implementation Secp256k1CryptoTest
-(void) testAll {
    [self testKeyGeneration];
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
