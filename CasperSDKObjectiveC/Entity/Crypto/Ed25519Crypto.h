#ifndef Ed25519Crypto_h
#define Ed25519Crypto_h
#import "Ed25519KeyPair.h"
@interface Ed25519Crypto:NSObject
@property Ed25519KeyPair * keyPair; //This is for public and private key pair
/// Read private key from pem file
-(void) readPrivateKeyFromPemFileFromLocalFile:(NSString*) fileName;
-(void) writePrivateKeyToPemFile:(NSString*) fileName;
//This function generate the key pair, encapsulated in Ed25519KeyPair object
-(Ed25519KeyPair *) generateKey;
-(Boolean) readKeyFromPemFile:(NSString*) fileName;
-(NSString*) signMessageWithValue:(NSString*) messageToSign withPrivateKey:(NSString*) privateKeyStr;
-(Boolean) verifyMessage:(NSString*) signedMessage withPublicKey:(NSString*) publicKeyStr forOriginalMessage:(NSString*) originalMessage;
@end

#endif
