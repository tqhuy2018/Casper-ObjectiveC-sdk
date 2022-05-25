#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/DisabledVersion.h>
/**Class built for storing DisabledVersion information
 */
@implementation DisabledVersion
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to DisabledVersion object
 */
+(DisabledVersion*) fromJsonDictToDisabledVersion:(NSDictionary*) fromDict {
    DisabledVersion * ret = [[DisabledVersion alloc] init];
    ret.contract_version = (unsigned int)[(NSString*) fromDict[@"contract_version"] intValue];
    ret.protocol_version_major = (unsigned int)[(NSString*) fromDict[@"protocol_version_major"] intValue];
    return ret;
}
-(void) logInfo {
    NSLog(@"DisabledVersion, contract_version:%u",self.contract_version);
    NSLog(@"DisabledVersion, protocol_version_major:%u",(unsigned int)self.protocol_version_major);
}

@end
