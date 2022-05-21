#import <Foundation/Foundation.h>
#import "Ed25519Crypto.h"
#import <CasperSDKObjectiveC/CasperSDKObjectiveC-Swift.h>
@import CasperCryptoHandlePackage;
@implementation Ed25519Crypto
-(void) readPrivateKeyFromPemFileFromLocalFile:(NSString*) fileName {
    
}
-(void) writePrivateKeyToPemFile:(NSString*) fileName {
    
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
-(Boolean) readKeyFromPemFile:(NSString*) fileName {
    
    return true;
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
