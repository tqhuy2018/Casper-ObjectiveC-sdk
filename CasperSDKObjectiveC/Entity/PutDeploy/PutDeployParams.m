#import <Foundation/Foundation.h>
#import "PutDeployParams.h"
/**Class built for storing GetItemParams information, used for sending state_get_item RPC method
 */
@implementation PutDeployParams
/**This function generate the json data used for sending POST method for account_put_deploy RPC call.
Based on the PutDeployParams data, the JSON string is built somehow like this:
 {"id": 1,"method": "account_put_deploy","jsonrpc": "2.0","params": [{"header": {"account": "0202572ee4c44b925477dc7cd252f678e8cc407da31b2257e70e11cf6bcb278eb04b","timestamp": "2022-05-16T15:08:01.230Z","ttl": "1h 30m","gas_price": 1,"body_hash": "798a65dae48dbefb398ba2f0916fa5591950768b7a467ca609a9a631caf13001","dependencies": [],"chain_name": "casper-test"},"payment": {"ModuleBytes": {"module_bytes": "","args": [["amount",{"bytes": "0400ca9a3b","parsed": "1000000000","cl_type": "U512"}]]}},"session": {"Transfer": {"args": [["amount",{"bytes": "04005ed0b2","parsed": "3000000000","cl_type": "U512"}],["target",{"bytes": "015f12b5776c66d2782a4408d3910f64485dd4047448040955573aa026256cfa0a","parsed": "015f12b5776c66d2782a4408d3910f64485dd4047448040955573aa026256cfa0a","cl_type": "PublicKey"}],["id",{"bytes": "010000000000000000","parsed": 0,"cl_type": {"Option": "U64"}}],["spender",{"bytes": "01dde7472639058717a42e22d297d6cf3e07906bb57bc28efceac3677f8a3dc83b","parsed": {"Hash": "hash-dde7472639058717a42e22d297d6cf3e07906bb57bc28efceac3677f8a3dc83b"},"cl_type": "Key"}]]}},"approvals": [{"signer": "0202572ee4c44b925477dc7cd252f678e8cc407da31b2257e70e11cf6bcb278eb04b","signature": "026ec143c5605d988ac1a45419f8f6c7c634e5c836e1ce980f52d6b9e6e3b1001b2f2dcae2cd70b2ff4add2f21510f88b14b8f6f3502f991eedb2f5ec0b77aa6f5"}],"hash": "ae445b64274f8afbb94ed54d155af428e7a29756751134b7bdc381e9cb2f3cf1"}]}
 */
-(NSString*) toJsonString {
    NSString * ret = @"";
    NSString * headerStr ="\"header\": {\"account\": \"\(
    /*
     let headerString: String = "\"header\": {\"account\": \"\(header.account)\",\"timestamp\": \"\(header.timestamp)\",\"ttl\": \"\(header.ttl)\",\"gas_price\": \(header.gasPrice),\"body_hash\": \"\(header.bodyHash)\",\"dependencies\": [],\"chain_name\": \"\(header.chainName)\"}"
     let paymentJsonStr = "\"payment\": " + ExecutableDeployItemHelper.toJsonString(input: payment!)
     let sessionJsonStr =  "\"session\": " +  ExecutableDeployItemHelper.toJsonString(input: session!)
     let approvalJsonStr: String = "\"approvals\": [{\"signer\": \"\(approvals[0].signer)\",\"signature\": \"\(approvals[0].signature)\"}]"
     let hashStr = "\"hash\": \"\(hash)\""
     let deployJsonStr: String = "{\"id\": 1,\"method\": \"account_put_deploy\",\"jsonrpc\": \"2.0\",\"params\": [{" + headerString + ","+paymentJsonStr + "," + sessionJsonStr + "," + approvalJsonStr + "," + hashStr + "}]}"
     */
    return ret;
}
@end
