#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/Ed25519Crypto.h>
//#import <CasperSDKObjectiveC/CasperSDKObjectiveC-Swift.h>
#import <CasperSDKObjectiveC/ConstValues.h>
@import CasperCryptoHandlePackage;
@implementation Ed25519Crypto
// This function generates the private/public key pair and assign their values in Ed25519KeyPair class object
-(CryptoKeyPair *) generateKey {
    CryptoKeyPair * ret = [[CryptoKeyPair alloc] init];
    Ed25519CrytoSwift * ed25519 = [[Ed25519CrytoSwift alloc] init];
    KeyPairClass * kpc = [ed25519 generateKeyPair];
    ret.privateKeyStr = kpc.privateKeyInStr;
    ret.publicKeyStr = kpc.publicKeyInStr;
    return ret;
}

// This function generates a private key then write its content to a Pem file
-(Boolean) generateAndWritePrivateKeyToPemFile:(NSString*) fileName {
    Ed25519CrytoSwift * ed25519 = [[Ed25519CrytoSwift alloc] init];
    KeyPairClass * kpc = [ed25519 generateKeyPair];
    NSString * privateKey = kpc.privateKeyInStr;
    privateKey = [ed25519 getPrivateKeyStringForPemFileWithPrivateKeyStr:privateKey];
    if([privateKey isEqualToString:ERROR_STRING]) {
        return false; // Fail because error generated private key - the private key string is invalid
    }
    NSString * filePath = [[NSString alloc] initWithFormat:@"/Users/hien/Ed25519/%@",fileName];
    NSURL * url = [NSURL fileURLWithPath:filePath];
    BOOL isSuccess = [privateKey writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if(isSuccess == YES) {
        return true;
    }
    return false; // Fail because File URL does not exist
}
// This function writes an existing private key to a Pem file
// The private key is a string represents the private key's raw representation bytes array
-(Boolean) writePrivateKey:(NSString*) privateKeyStr toPemFile:(NSString*) pemFile {
    Ed25519CrytoSwift * ed25519 = [[Ed25519CrytoSwift alloc] init];
    NSString * privateKey = [ed25519 getPrivateKeyStringForPemFileWithPrivateKeyStr:privateKeyStr];
    if([privateKey isEqualToString:ERROR_STRING]) {
        return false; // Fail because error generated private key - the private key string is invalid
    }
    NSString * filePath = [[NSString alloc] initWithFormat:@"/Users/hien/Ed25519/%@",pemFile];
    NSURL * url = [NSURL fileURLWithPath:filePath];
    BOOL isSuccess =  [privateKey writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if(isSuccess == YES) {
        return true;
    }
    return false; // Fail because File URL does not exist
}
/** This function reads the private key from pem file. If the private key is valid, the private key in string is return. Otherwise error string is returned
 The private key is a string represents the private key's raw representation bytes array
 Sample value is 58_1_61_242_77_251_54_204_135_74_45_117_67_18_30_184_144_193_158_142_182_68_229_185_27_56_181_134_38_235_28_51 */
-(NSString * ) readPrivateKeyFromPemFile:(NSString*) fileName {
    NSString * filePath = [[NSString alloc] initWithFormat:@"/Users/hien/Ed25519/%@",fileName];
    NSURL * url = [NSURL fileURLWithPath:filePath];
    NSString * fileContent = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"File content is:%@",fileContent);
    if(!fileContent) {
        return ERROR_STRING;
    }
    fileContent = [fileContent stringByReplacingOccurrencesOfString:@"-----BEGIN PRIVATE KEY-----" withString:@""];
    fileContent = [fileContent stringByReplacingOccurrencesOfString:@"-----END PRIVATE KEY-----" withString:@""];
    fileContent = [[fileContent componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
    NSLog(@"File content again is:%@",fileContent);
    Ed25519CrytoSwift * ed25519 = [[Ed25519CrytoSwift alloc] init];
    NSString * privateKey = [ed25519 getPrivateKeyStringFromPemStringWithPemStr:fileContent];
    NSLog(@"Private key is:%@",privateKey);
    return privateKey;
}

// PUBLIC KEY HANDLE
/** This function reads the public key from pem file. If the public key is valid, the public key in string is return. Otherwise error string is returned
 The public key is a string represents the public key's raw representation bytes array
 Sample value is 138_121_31_76_52_190_241_244_216_11_26_29_151_147_196_119_186_49_12_134_43_21_243_127_134_56_3_169_170_156_4_233 */
-(NSString*) readPublicKeyFromPemFile:(NSString*) fileName {
    NSString * filePath = [[NSString alloc] initWithFormat:@"/Users/hien/Ed25519/%@",fileName];
    NSURL * url = [NSURL fileURLWithPath:filePath];
    NSString * fileContent = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"File content is:%@",fileContent);
    if(!fileContent) {
        return ERROR_STRING;
    }
    fileContent = [fileContent stringByReplacingOccurrencesOfString:@"-----BEGIN PUBLIC KEY-----" withString:@""];
    fileContent = [fileContent stringByReplacingOccurrencesOfString:@"-----END PUBLIC KEY-----" withString:@""];
    fileContent = [[fileContent componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
    NSLog(@"File content again is:%@",fileContent);
    Ed25519CrytoSwift * ed25519 = [[Ed25519CrytoSwift alloc] init];
    NSString * publicKey = [ed25519 getPublicKeyStringFromPemStringWithPemStr:fileContent];
    NSLog(@"Public key is:%@",publicKey);
    return publicKey;
}
// This function generates a public key then write its content to a Pem file
-(Boolean) generateAndWritePublicKeyToPemFile:(NSString*) fileName {
    Ed25519CrytoSwift * ed25519 = [[Ed25519CrytoSwift alloc] init];
    KeyPairClass * kpc = [ed25519 generateKeyPair];
    NSString * publicKey = kpc.publicKeyInStr;
    publicKey = [ed25519 getPublicKeyStringFromPemStringWithPemStr:publicKey];
    if([publicKey isEqualToString:ERROR_STRING]) {
        return false; // Fail because error generated public key - the private key string is invalid
    }
    NSString * filePath = [[NSString alloc] initWithFormat:@"/Users/hien/Ed25519/%@",fileName];
    NSURL * url = [NSURL fileURLWithPath:filePath];
    BOOL isSuccess = [publicKey writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if(isSuccess == YES) {
        return true;
    }
    return false; // Fail because File URL does not exist
}
/** This function writes an existing public key to a Pem file
The public key is a string represents the public key's raw representation bytes array */
-(Boolean) writePublicKey:(NSString*) publicKeyStr toPemFile:(NSString*) pemFile {
    Ed25519CrytoSwift * ed25519 = [[Ed25519CrytoSwift alloc] init];
    NSString * publicKey = [ed25519 getPublicKeyStringFromPemStringWithPemStr:publicKeyStr];
    if([publicKey isEqualToString:ERROR_STRING]) {
        return false; // Fail because error generated public key - the private key string is invalid
    }
    NSString * filePath = [[NSString alloc] initWithFormat:@"/Users/hien/Ed25519/%@",pemFile];
    NSURL * url = [NSURL fileURLWithPath:filePath];
    BOOL isSuccess = [publicKey writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if(isSuccess == YES) {
        return true;
    }
    return false; // Fail because File URL does not exist
    return false;
}

/** This function verifies the signed message with given public key and original message
 This function calls the Swift function to verify the message.
 If the message is verified successfully then the true value is returned, otherwise the false value is returned
 */
-(Boolean) verifyMessage:(NSString*) signedMessage withPublicKey:(NSString*) publicKeyStr forOriginalMessage:(NSString*) originalMessage {
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
-(NSString*) signMessageWithValue:(NSString*) messageToSign withPrivateKey:(NSString*) privateKeyStr {
    Ed25519CrytoSwift * ed25519 = [[Ed25519CrytoSwift alloc] init];
    NSLog(@"Message to sign:%@ and privateKeyStr:%@",messageToSign,privateKeyStr);
    NSString * ret = [ed25519 signMessageStringWithMessageToSign:messageToSign privateKeyStr:privateKeyStr];
    return ret;
}
-(NSString *) generateTime {
    SwiftUtilClass * util = [[SwiftUtilClass alloc] init];
    NSString * ret = [util generateTime];
    return ret;
}
@end
