#import <Foundation/Foundation.h>
#import "GetItemParams.h"
/**Class built for storing GetItemParams information, used for sending state_get_item RPC method
 */
@implementation GetItemParams
/**This function generate the json data used for sending POST method for state_get_item RPC call.
Based on the GetBalanceParams data, the JSON string is built somehow like this:
 
 {"method" : "state_get_item","id" : 1,"params" :{"state_root_hash" : "d360e2755f7cee816cce3f0eeb2000dfa03113769743ae5481816f3983d5f228","key":"withdraw-df067278a61946b1b1f784d16e28336ae79f48cf692b13f6e40af9c7eadb2fb1","path":[]},"jsonrpc" : "2.0"}
 
 */
-(NSString*) toJsonString {
    NSString * pathStr = @"";
    if(self.path.count>0) {
        int totalPath = (int) self.path.count;
        pathStr = @"[";
        for(int i = 0 ; i < totalPath; i ++) {
            pathStr = [pathStr stringByAppendingString:[NSString stringWithFormat:@"\"%@\"", (NSString *)[self.path objectAtIndex:i]]];
        }
        pathStr = [pathStr stringByAppendingString:@"]"];
    } else {
        pathStr = @"[]";
    }
    NSString * ret =  [[NSString alloc] initWithFormat:@"{\"method\" : \"state_get_item\",\"id\" : 1,\"params\" :{\"state_root_hash\" : \"%@\",\"key\":\"%@\",\"path\":%@},\"jsonrpc\" : \"2.0\"}",self.state_root_hash,self.key,pathStr];
    return ret;
}
@end
