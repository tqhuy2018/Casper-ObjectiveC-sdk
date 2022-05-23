#ifndef Secp256k1Crypto_h
#define Secp256k1Crypto_h
#import "CryptoKeyPair.h"
@interface Secp256k1Crypto:NSObject

@property CryptoKeyPair * keyPair; // This is for public and private key pair
// This function generates the key pair, encapsulated in Ed25519KeyPair object
-(CryptoKeyPair *) secpGenerateKey;
// PRIVATE KEY HANDLE
/** This function reads the private key from pem file. If the private key is valid, the private key in string is return. Otherwise error string is returned
 The private key is a string represents the private key's raw representation bytes array
 Sample value is 58_1_61_242_77_251_54_204_135_74_45_117_67_18_30_184_144_193_158_142_182_68_229_185_27_56_181_134_38_235_28_51 */
-(NSString*) secpReadPrivateKeyFromPemFile:(NSString*) fileName;
// This function generates a private key then write its content to a Pem file
-(Boolean) secpGenerateAndWritePrivateKeyToPemFile:(NSString*) fileName;
// This function writes an existing private key to a Pem file
// The private key is a string represents the private key's raw representation bytes array
-(Boolean) secpWritePrivateKey:(NSString*) privateKeyStr toPemFile:(NSString*) pemFile;

// PUBLIC KEY HANDLE
/** This function reads the public key from pem file. If the public key is valid, the public key in string is return. Otherwise error string is returned
 The public key is a string represents the public key's raw representation bytes array
 Sample value is 138_121_31_76_52_190_241_244_216_11_26_29_151_147_196_119_186_49_12_134_43_21_243_127_134_56_3_169_170_156_4_233 */
-(NSString*) secpReadPublicKeyFromPemFile:(NSString*) fileName;
// This function generates a public key then write its content to a Pem file
-(Boolean) secpGenerateAndWritePublicKeyToPemFile:(NSString*) fileName;
/** This function writes an existing public key to a Pem file
The public key is a string represents the public key's raw representation bytes array */
-(Boolean) secpWritePublicKey:(NSString*) publicKeyStr toPemFile:(NSString*) pemFile;

// SIGNATURE HANDLE
/** This function signs the message with given private key
 This function calls the Swift function to sign the message with given key.
 If success, then the signature is returned, otherwise the ERROR_STRING message is return
 */
-(NSString*) secpSignMessageWithValue:(NSString*) messageToSign withPrivateKey:(NSString*) privateKeyStr;
/** This function verifies the signed message with given public key and original message
 This function calls the Swift function to verify the message.
 If the message is verified successfully then the true value is returned, otherwise the false value is returned
 */
-(Boolean) secpVerifyMessage:(NSString*) signedMessage withPublicKey:(NSString*) publicKeyStr forOriginalMessage:(NSString*) originalMessage;
-(NSString*) generateTime;
@end
#endif
