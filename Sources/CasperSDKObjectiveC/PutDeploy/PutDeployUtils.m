#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/PutDeployUtils.h>
#import <CasperSDKObjectiveC/Secp256k1Crypto.h>
#import <CasperSDKObjectiveC/Approval.h>
#import <CasperSDKObjectiveC/PutDeployRPC.h>
#import <CasperSDKObjectiveC/PutDeployParams.h>
@implementation PutDeployUtils
static bool isPutDeploySuccess;
+ (bool) isPutDeploySuccess
{ @synchronized(self) { return isPutDeploySuccess; } }
+ (void) setIsPutDeploySuccess:(bool)val
{ @synchronized(self) { isPutDeploySuccess = val; } }

static int putDeployCounter;
+ (int) putDeployCounter
{ @synchronized(self) { return putDeployCounter; } }
+ (void) setPutDeployCounter:(int)val
{ @synchronized(self) { putDeployCounter = val; } }

static NSString* secpPrivateKeyPemStr;
+ (NSString*) secpPrivateKeyPemStr
{ @synchronized(self) { return secpPrivateKeyPemStr; } }
+ (void) setSecpPrivateKeyPemStr:(NSString*)val
{ @synchronized(self) { secpPrivateKeyPemStr = val; } }

static Deploy* deploy;
+ (Deploy*) deploy
{ @synchronized(self) { return deploy; } }
+ (void) setDeploy:(Deploy *) val
{ @synchronized(self) { deploy = val; } }

+(void) utilsPutDeploy {
    NSString * deployHash = PutDeployUtils.deploy.itsHash;
    Secp256k1Crypto * secp = [[Secp256k1Crypto alloc] init];
    NSString * signature = [secp secpSignMessageWithValue:deployHash withPrivateKey:PutDeployUtils.secpPrivateKeyPemStr];
    signature = [[NSString alloc] initWithFormat:@"02%@",signature];
    Approval * oneA = [[Approval alloc] init];
    oneA = [PutDeployUtils.deploy.approvals objectAtIndex:0];
    oneA.signature = signature;
    [PutDeployUtils.deploy.approvals removeAllObjects];
    [PutDeployUtils.deploy.approvals addObject:oneA];
    PutDeployUtils.putDeployCounter += 1;
    if(PutDeployUtils.putDeployCounter > 10) {
        PutDeployUtils.putDeployCounter = 0;
    } else {
        PutDeployRPC * putDeployRPC = [[PutDeployRPC alloc] init];
        PutDeployParams * params = [[PutDeployParams alloc] init];
        params.deploy = PutDeployUtils.deploy;
        putDeployRPC.params = params;
        [putDeployRPC putDeployForDeploy:PutDeployUtils.deploy];
    }
    
}
@end
