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
@end
