#import <Foundation/Foundation.h>
#import "Ed25519Crypto.h"
#import <CasperSDKObjectiveC/CasperSDKObjectiveC-Swift.h>
@import CasperCryptoHandlePackage;
@implementation Ed25519Crypto
-(void) readPrivateKeyFromPemFileFromLocalFile:(NSString*) fileName {
    
}

-(Ed25519KeyPair *) generateKey {
    Ed25519KeyPair * ret = [[Ed25519KeyPair alloc] init];
    Ed25519CrytoSwift * ed25519 = [[Ed25519CrytoSwift alloc] init];
    KeyPairClass * kpc = [ed25519 generateKeyPair];
    ret.privateKeyStr = kpc.privateKeyInStr;
    ret.publicKeyStr = kpc.publicKeyInStr;
    return ret;
}

-(NSString*) signMessageWithValue:(NSString*) messageToSign withPrivateKey:(NSString*) privateKeyStr {
    Ed25519CrytoSwift * ed25519 = [[Ed25519CrytoSwift alloc] init];
    NSString * ret = [ed25519 signMessageStringWithMessageToSign:messageToSign privateKeyStr:privateKeyStr];
    return ret;
}
-(Boolean) writePrivateKeyToPemFile:(NSString*) fileName {
    /*NSString * filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
    NSLog(@"Fiel name is:%@",filePath);
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    NSString * str = @"HOw to say what to do? No one knows. What can I do right now?";
    [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];*/
    NSString * filePath = [[NSString alloc] initWithFormat:@"/Users/hien/Ed25519/%@",fileName];
    NSURL * url = [NSURL fileURLWithPath:filePath];
    NSString * fileContent = @"Write something here";
    [fileContent writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:nil];
    return true;
}
// This function read the private key from pem file. If the private key is valid, the private key in string is return. Otherwise error string is returned
// The private key is a string represent the private key in raw representation of the key in bytes array format
// Sample value is 58_1_61_242_77_251_54_204_135_74_45_117_67_18_30_184_144_193_158_142_182_68_229_185_27_56_181_134_38_235_28_51
-(NSString * ) readPrivateKeyFromPemFile:(NSString*) fileName {
    NSString * filePath = [[NSString alloc] initWithFormat:@"/Users/hien/Ed25519/%@",fileName];
    NSURL * url = [NSURL fileURLWithPath:filePath];
    NSString * fileContent = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"File content is:%@",fileContent);
    fileContent = [fileContent stringByReplacingOccurrencesOfString:@"-----BEGIN PRIVATE KEY-----" withString:@""];
    fileContent = [fileContent stringByReplacingOccurrencesOfString:@"-----END PRIVATE KEY-----" withString:@""];
    fileContent = [[fileContent componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
    NSLog(@"File content again is:%@",fileContent);
    Ed25519CrytoSwift * ed25519 = [[Ed25519CrytoSwift alloc] init];
    NSString * privateKey = [ed25519 readPrivateKeyFromPemStringWithPemStr:fileContent];
    NSLog(@"Private key is:%@",privateKey);
    return privateKey;
}
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
@end
