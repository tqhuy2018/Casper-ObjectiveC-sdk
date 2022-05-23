#import <Foundation/Foundation.h>
#import "GetBalanceParams.h"
/**Class built for storing GetBalanceParams information, used for sending state_get_balance RPC method
 */
@implementation GetBalanceParams
/**This function generate the json data used for sending POST method for state_get_balance RPC call.
Based on the GetBalanceParams data, the JSON string is built somehow like this:
 
 {"method" : "state_get_balance","id" : 1,"params" :{"state_root_hash" : "8b463b56f2d124f43e7c157e602e31d5d2d5009659de7f1e79afbd238cbaa189","purse_uref":"uref-be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c6-007"},"jsonrpc" : "2.0"}
 
 */
-(NSString*) toJsonString {
    NSString * ret =  [[NSString alloc] initWithFormat:@"{\"method\" : \"state_get_balance\",\"id\" : 1,\"params\" :{\"state_root_hash\" : \"%@\",\"purse_uref\":\"%@\"},\"jsonrpc\" : \"2.0\"}",self.state_root_hash,self.purse_uref];
    return ret;
}
@end
