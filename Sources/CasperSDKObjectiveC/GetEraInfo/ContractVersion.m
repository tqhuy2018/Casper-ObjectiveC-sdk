#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/ContractVersion.h>
/**Class built for storing ContractVersion information
 */
@implementation ContractVersion
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to ContractVersion object
 */
+(ContractVersion*) fromJsonDictToContractVersion:(NSDictionary*) fromDict {
    ContractVersion * ret = [[ContractVersion alloc] init];
    ret.contract_version = (unsigned int) [(NSString*) fromDict[@"contract_version"] intValue];
    ret.contract_hash = (NSString*) fromDict[@"contract_hash"];
    ret.protocol_version_major = (unsigned int) [(NSString*) fromDict[@"protocol_version_major"] intValue];
    return ret;
}
-(void) logInfo {
    NSLog(@"ContractVersion, contract_hash:%@",self.contract_hash);
    NSLog(@"ContractVersion, contract_version:%u",self.contract_version);
    NSLog(@"ContractVersion, protocol_version_major:%u",self.protocol_version_major);
}
@end
