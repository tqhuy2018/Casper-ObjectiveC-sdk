#ifndef Ed25519Crypto_h
#define Ed25519Crypto_h
#import "Ed25519KeyPair.h"
@interface Ed25519Crypto:NSObject
@property Ed25519KeyPair * keyPair; //This is for public and private key pair
/// Read private key from pem file
-(void) readPrivateKeyFromPemFileFromLocalFile:(NSString*) fileName;
// This function generate the key pair, encapsulated in Ed25519KeyPair object
-(Ed25519KeyPair *) generateKey;
// This function read the private key from pem file. If the private key is valid, the private key in string is return. Otherwise error string is returned
// The private key is a string represent the private key in raw representation of the key in bytes array format
// Sample value is 58_1_61_242_77_251_54_204_135_74_45_117_67_18_30_184_144_193_158_142_182_68_229_185_27_56_181_134_38_235_28_51
-(NSString*) readPrivateKeyFromPemFile:(NSString*) fileName;
-(Boolean) writePrivateKeyToPemFile:(NSString*) fileName;
-(NSString*) signMessageWithValue:(NSString*) messageToSign withPrivateKey:(NSString*) privateKeyStr;
-(Boolean) verifyMessage:(NSString*) signedMessage withPublicKey:(NSString*) publicKeyStr forOriginalMessage:(NSString*) originalMessage;
@end

#endif
