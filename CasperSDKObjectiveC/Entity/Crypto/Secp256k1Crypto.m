#import <Foundation/Foundation.h>
#import "Secp256k1Crypto.h"
#import <CasperSDKObjectiveC/CasperSDKObjectiveC-Swift.h>
#import "ConstValues.h"
@import CasperCryptoHandlePackage;
@implementation Secp256k1Crypto
// This function generates the private/public key pair and assign their values in Ed25519KeyPair class object
-(CryptoKeyPair *) secpGenerateKey {
    CryptoKeyPair * ret = [[CryptoKeyPair alloc] init];
    Secp256k1CryptoSwift * secp256k1 = [[Secp256k1CryptoSwift alloc] init];
    KeyPairClass * kpc = [secp256k1 generateKeyPair];
    ret.privateKeyStr = kpc.privateKeyInStr;
    ret.publicKeyStr = kpc.publicKeyInStr;
    NSLog(@"Secp256k1, private key is:%@",ret.privateKeyStr);
    NSLog(@"Secp256k1, public key is:%@",ret.publicKeyStr);
    return ret;
}
// This function generates a private key then write its content to a Pem file
-(Boolean) secpGenerateAndWritePrivateKeyToPemFile:(NSString*) fileName {
    Secp256k1CryptoSwift * secp256k1 = [[Secp256k1CryptoSwift alloc] init];
    KeyPairClass * kpc = [secp256k1 generateKeyPair];
    NSString * privateKey = kpc.privateKeyInStr;
    if([privateKey isEqualToString:ERROR_STRING]) {
        return false; // Fail because error generated private key - the private key string is invalid
    }
    NSString * filePath = [[NSString alloc] initWithFormat:@"/Users/hien/Secp256k1/%@",fileName];
    NSURL * url = [NSURL fileURLWithPath:filePath];
    BOOL isSuccess = [privateKey writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if(isSuccess == YES) {
        return true;
    }
    return false; // Fail because File URL does not exist
}
// This function writes an existing private key - already in Pem format -  to a Pem file
// The private key is a string represents the private key's raw representation bytes array
-(Boolean) secpWritePrivateKey:(NSString*) privateKeyPemStr toPemFile:(NSString*) pemFile {
    NSString * filePath = [[NSString alloc] initWithFormat:@"/Users/hien/Ed25519/%@",pemFile];
    NSURL * url = [NSURL fileURLWithPath:filePath];
    BOOL isSuccess =  [privateKeyPemStr writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if(isSuccess == YES) {
        return true;
    }
    return false; // Fail because File URL does not exist
}
/** This function reads the private key from pem file. If the private key is valid, the private key in string is return. Otherwise error string is returned
 The private key is a string represents the private key's raw representation bytes array
 Sample value is 58_1_61_242_77_251_54_204_135_74_45_117_67_18_30_184_144_193_158_142_182_68_229_185_27_56_181_134_38_235_28_51 */
-(NSString * ) secpReadPrivateKeyFromPemFile:(NSString*) fileName {
    NSString * filePath = [[NSString alloc] initWithFormat:@"/Users/hien/Secp256k1/%@",fileName];
    NSURL * url = [NSURL fileURLWithPath:filePath];
    NSString * fileContent = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"File content is:%@",fileContent);
    if(!fileContent) {
        return ERROR_STRING; // File url doesn't exist
    }
    Secp256k1CryptoSwift * secp256k1 = [[Secp256k1CryptoSwift alloc] init];
    //Check if file content in Pem format can turn to an private key, if yes return the fileContent
    //else return ERROR_STRING
    bool privateKeyValid = [secp256k1 checkPrivateKeyPemStringValidWithPemString:fileContent];
    if(privateKeyValid) {
        return fileContent;
    } else {
        return ERROR_STRING;
    }
}

// PUBLIC KEY HANDLE
/** This function reads the public key from pem file. If the public key is valid, the public key in string is return. Otherwise error string is returned
 The public key is a string represents the public key's raw representation bytes array
 Sample value is 138_121_31_76_52_190_241_244_216_11_26_29_151_147_196_119_186_49_12_134_43_21_243_127_134_56_3_169_170_156_4_233 */
-(NSString*) secpReadPublicKeyFromPemFile:(NSString*) fileName {
    NSString * filePath = [[NSString alloc] initWithFormat:@"/Users/hien/Ed25519/%@",fileName];
    NSURL * url = [NSURL fileURLWithPath:filePath];
    NSString * fileContent = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"File content is:%@",fileContent);
    if(!fileContent) {
        return ERROR_STRING; //Error if invalid file URL
    }
    Secp256k1CryptoSwift * secp256k1 = [[Secp256k1CryptoSwift alloc] init];
    //Check if file content in Pem format can turn to an private key, if yes return the fileContent
    //else return ERROR_STRING
    bool publicKeyValid = [secp256k1 checkPublicKeyPemStringValidWithPemString:fileContent];
    if(publicKeyValid) {
        return fileContent;
    } else {
        return ERROR_STRING;
    }
}
// This function generates a public key then write its content to a Pem file
-(Boolean) secpGenerateAndWritePublicKeyToPemFile:(NSString*) fileName {
    Secp256k1CryptoSwift * secp256k1 = [[Secp256k1CryptoSwift alloc] init];
    KeyPairClass * kpc = [secp256k1 generateKeyPair];
    NSString * publicKey = kpc.publicKeyInStr;
    if([publicKey isEqualToString:ERROR_STRING]) {
        return false; // Fail because error generated private key - the private key string is invalid
    }
    NSString * filePath = [[NSString alloc] initWithFormat:@"/Users/hien/Secp256k1/%@",fileName];
    NSURL * url = [NSURL fileURLWithPath:filePath];
    BOOL isSuccess = [publicKey writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if(isSuccess == YES) {
        return true;
    }
    return false; // Fail because File URL does not exist
}
/** This function writes an existing public key to a Pem file
The public key is pem string represent the public key */
-(Boolean) secpWritePublicKey:(NSString*) publicKeyStr toPemFile:(NSString*) pemFile {
    NSString * filePath = [[NSString alloc] initWithFormat:@"/Users/hien/Ed25519/%@",pemFile];
    NSURL * url = [NSURL fileURLWithPath:filePath];
    BOOL isSuccess =  [publicKeyStr writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if(isSuccess == YES) {
        return true;
    }
    return false; // Fail because File URL does not exist
}

/** This function verifies the signed message with given public key and original message
 This function calls the Swift function to verify the message.
 If the message is verified successfully then the true value is returned, otherwise the false value is returned
 */
-(Boolean) secpVerifyMessage:(NSString*) signedMessage withPublicKey:(NSString*) publicKeyStr forOriginalMessage:(NSString*) originalMessage {
    Ed25519CrytoSwift * ed25519 = [[Ed25519CrytoSwift alloc] init];
    Boolean result = [ed25519 verifyMessageWithSignedMessage:signedMessage publicKeyToVerifyString:publicKeyStr originalMessage:originalMessage];
    if(result) {
        NSLog(@"Verify success");
    } else {
        NSLog(@"Verify failed");
    }
    return result;
}
/** This function signs the message with given private key
 This function calls the Swift function to sign the message with given key.
 If success, then the signature is returned, otherwise the ERROR_STRING message is return
 */
-(NSString*) secpSignMessageWithValue:(NSString*) messageToSign withPrivateKey:(NSString*) privateKeyStr {
    Secp256k1CryptoSwift * secp = [[Secp256k1CryptoSwift alloc] init];
    NSLog(@"Message to sign:%@ and privateKeyStr:%@",messageToSign,privateKeyStr);
    NSString * ret = [secp signMessageWithMessageToSign:messageToSign withPrivateKeyPemString:privateKeyStr];
    return ret;
}
-(NSString *) generateTime {
    SwiftUtilClass * util = [[SwiftUtilClass alloc] init];
    NSString * ret = [util generateTime];
    return ret;
}
@end
