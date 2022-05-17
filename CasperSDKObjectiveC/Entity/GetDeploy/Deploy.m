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
    NSString * headerStr = [[NSString alloc] initWithFormat:@"\"header\": {\"account\": \"%@\",\"timestamp\": \"\%@\",\"ttl\": \"%@\",\"gas_price\": %@","\"body_hash\": \"%@\",\"dependencies\": [],\"chain_name\": \"%@\"}",self.header.account,self.header.timestamp,self.header.ttl,self.header.gas_price,self.header.body_hash,self.header.chain_name];
    NSString * paymentEDIStr = [ExecutableDeployItem toJsonString:self.payment];
    NSString * paymentStr = [[NSString alloc] initWithFormat:@"\"payment\": %@",paymentEDIStr];
    NSString * sessionEDIStr = [ExecutableDeployItem toJsonString:self.session];
    NSString * sessionStr = [[NSString alloc] initWithFormat:@"\"session\": %@",sessionEDIStr];
    /*
     [[NSString alloc] initWithFormat: @"{\"id\" : 1,\"method\" : \"info_get_deploy\",\"params\" : {\"deploy_hash\" : \"%@\"},\"jsonrpc\" : \"2.0\"}",self.deploy_hash];
     */
   /* let headerString: String = "\"header\": {\"account\": \"\(header.account)\",\"timestamp\": \"\(header.timestamp)\",\"ttl\": \"\(header.ttl)\",\"gas_price\": \(header.gasPrice),\"body_hash\": \"\(header.bodyHash)\",\"dependencies\": [],\"chain_name\": \"\(header.chainName)\"}"
    let paymentJsonStr = "\"payment\": " + ExecutableDeployItemHelper.toJsonString(input: payment!)
    let sessionJsonStr =  "\"session\": " +  ExecutableDeployItemHelper.toJsonString(input: session!)
    let approvalJsonStr: String = "\"approvals\": [{\"signer\": \"\(approvals[0].signer)\",\"signature\": \"\(approvals[0].signature)\"}]"
    let hashStr = "\"hash\": \"\(hash)\""
    let deployJsonStr: String = "{\"id\": 1,\"method\": \"account_put_deploy\",\"jsonrpc\": \"2.0\",\"params\": [{" + headerString + ","+paymentJsonStr + "," + sessionJsonStr + "," + approvalJsonStr + "," + hashStr + "}]}"
    return deployJsonStr*/
}
@end
