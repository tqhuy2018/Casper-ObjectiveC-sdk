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
    int totalDependency = (int) [self.header.dependencies count];
    NSString * dependencyString = @"[";
    int counter = 0;
    if(totalDependency > 0) {
        for(int i = 0 ;i < totalDependency; i ++) {
            NSString * oneD = [self.header.dependencies objectAtIndex:i];
            if(counter < totalDependency - 1) {
                dependencyString = [[NSString alloc] initWithFormat:@"%@\"%@\",",dependencyString,oneD];
            } else {
                dependencyString = [[NSString alloc] initWithFormat:@"%@\"%@\"]",dependencyString,oneD];
            }
        }
        counter ++;
    } else {
        dependencyString = @"[]";
    }
   
    NSString * headerStr1 = [[NSString alloc] initWithFormat:@"\"header\": {\"account\":\"%@\",\"timestamp\": \"%@\",\"ttl\": \"%@\",",self.header.account,self.header.timestamp,self.header.ttl];
     NSString * headerStr2 = [[NSString alloc] initWithFormat:@"\"gas_price\": %llu,\"body_hash\": \"%@\",\"dependencies\": %@,\"chain_name\": \"%@\"}",self.header.gas_price,self.header.body_hash,dependencyString,self.header.chain_name];
    NSString * headerStr = [[NSString alloc] initWithFormat:@"%@%@",headerStr1,headerStr2];
    NSLog(@"header Str is:%@",headerStr);
    NSString * paymentEDIStr = [ExecutableDeployItem toJsonString:self.payment];
    NSString * paymentStr = [[NSString alloc] initWithFormat:@"\"payment\": %@",paymentEDIStr];
    NSString * sessionEDIStr = [ExecutableDeployItem toJsonString:self.session];
    NSString * sessionStr = [[NSString alloc] initWithFormat:@"\"session\": %@",sessionEDIStr];
    NSLog(@"payment string is:%@",paymentStr);
    NSLog(@"session string is:%@",sessionStr);
    int totalApproval = (int) [self.approvals count];
    NSLog(@"Total approvals:%i",totalApproval);
    NSString * approvalStr = @"\"approvals\": [";
    counter = 0;
    for(int i = 0 ; i < totalApproval ; i ++ ) {
        Approval * oneApproval = [self.approvals objectAtIndex:i];
        NSString * oneApprovalStr = [[NSString alloc] initWithFormat:@"{\"signer\": \"%@\",\"signature\":\"%@\"}",oneApproval.signer,oneApproval.signature];
        if(counter < totalApproval - 1) {
            approvalStr = [[NSString alloc] initWithFormat:@"%@%@,",approvalStr,oneApprovalStr];
        } else {
            approvalStr = [[NSString alloc] initWithFormat:@"%@%@]",approvalStr,oneApprovalStr];
        }
    }
    NSLog(@"Approval string is:%@",approvalStr);
    NSString * hashStr = [[NSString alloc] initWithFormat:@"\"hash\": \"%@\"",self.itsHash];
    NSString * deployJsonStr = [[NSString alloc] initWithFormat:@"{\"id\": 1,\"method\": \"account_put_deploy\",\"jsonrpc\": \"2.0\",\"params\": [{%@,%@,%@,%@,%@}]}",headerStr,paymentStr,sessionStr,approvalStr,hashStr];
    NSLog(@"Full put deploy string is:%@",deployJsonStr);
    return ret;
}
@end
