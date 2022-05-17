#import <Foundation/Foundation.h>
#import "Deploy.h"
#import "DeployHeader.h"
#import "Approval.h"
/**Class built for storing Deploy information
 */
@implementation Deploy
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to Deploy object
 */
+(Deploy*) fromJsonDictToDeploy:(NSDictionary*) fromDict {
    Deploy * ret = [[Deploy alloc] init];
    ret.itsHash = fromDict[@"hash"];
    NSArray * listApprovals = (NSArray*) fromDict[@"approvals"];
    int totalApproval = (int) [listApprovals count];
    if(totalApproval > 0) {
        ret.approvals = [Approval fromArrayToListApproval:listApprovals];
    }
    ret.header = [DeployHeader fromJsonDictToDeployHeader:fromDict[@"header"]];
    ret.payment = [ExecutableDeployItem fromJsonDictToExecutableDeployItem:fromDict[@"payment"]];
    ret.session = [ExecutableDeployItem fromJsonDictToExecutableDeployItem:fromDict[@"session"]];
    return ret;
}
-(void) logInfo {
    NSLog(@"Deploy, hash:%@",self.itsHash);
    NSLog(@"Deploy header log:");
    [self.header logInfo];
    NSLog(@"Deploy payment log:");
    [self.payment logInfo];
    NSLog(@"Deploy session log:");
    [self.session logInfo];
}
-(NSString*) toPutDeployParameterStr {
    NSString * ret = @"";
    NSString * headerStr = [[NSString alloc] initWithFormat:@"\"header\": {\"account\": \"%@\",\"timestamp\": \"\%@\",\"ttl\": \"%@\",\"gas_price\": %@","\"body_hash\": \"%@\",\"dependencies\": [],\"chain_name\": \"%@\"}",self.header.account,self.header.timestamp,self.header.ttl,self.header.gas_price,self.header.body_hash,self.header.chain_name];
    NSString * paymentEDIStr = [ExecutableDeployItem toJsonString:self.payment];
    NSString * paymentStr = [[NSString alloc] initWithFormat:@"\"payment\": %@",paymentEDIStr];
    NSString * sessionEDIStr = [ExecutableDeployItem toJsonString:self.session];
    NSString * sessionStr = [[NSString alloc] initWithFormat:@"\"session\": %@",sessionEDIStr];
    int totalApproval = (int) [self.approvals count];
    NSString * approvalStr = @"";
    for(int i = 0 ; i < totalApproval ; i ++ ) {
        
    }
    return ret;
}
@end
