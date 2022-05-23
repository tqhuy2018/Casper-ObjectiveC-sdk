#ifndef Ed25519KeyPair_h
#define Ed25519KeyPair_h
//This class is for storing public and private key pair, in form of string
//For example the private key can be in this format
//144_197_209_19_213_188_171_19_27_251_109_216_10_145_22_200_21_146_118_83_168_154_6_7_116_149_227_213_112_213_42_121_
//And public key is in this format
//76_97_89_95_14_123_252_99_216_98_179_172_244_186_131_123_13_61_42_186_31_228_58_231_184_69_42_156_120_175_1_214_
@interface CryptoKeyPair:NSObject
@property NSString * privateKeyStr;
@property NSString * publicKeyStr;
@end

#endif
