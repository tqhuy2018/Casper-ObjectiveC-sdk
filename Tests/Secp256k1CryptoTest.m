//
//  Secp256k1CryptoTest.m
//  CasperSDKObjectiveC
//
//  Created by Hien on 22/05/2022.
//
#import <XCTest/XCTest.h>
#import <CasperSDKObjectiveC/Secp256k1Crypto.h>
#import <CasperSDKObjectiveC/CryptoKeyPair.h>
@interface Secp256k1CryptoTest : XCTestCase

@end

@implementation Secp256k1CryptoTest

- (void) testGenerateKey {
    return;
    Secp256k1Crypto * item = [[Secp256k1Crypto alloc] init];
    CryptoKeyPair * keyPair = [item secpGenerateKey];
    [item secpGenerateAndWritePrivateKeyToPemFile:@"Secp256k1Private.pem"];
    NSString * privatePemStr = [item secpReadPrivateKeyFromPemFile:@"ReadSwiftPrivateKeySecp256k1.pem"];
    NSString * deployHash = @"94c6a55ee87c34220142560650f03bac3367f7a609221641b162ba46c80c4b48";
    NSString * signature = [item secpSignMessageWithValue:deployHash withPrivateKey:privatePemStr];
    NSLog(@"signature is:%@",signature);
    NSLog(@"Private ");
}
@end
