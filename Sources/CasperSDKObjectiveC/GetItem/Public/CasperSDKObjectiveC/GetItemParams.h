#ifndef GetItemParams_h
#define GetItemParams_h
/**Class built for storing GetItemParams information, used for sending state_get_item RPC method
 */
#import <Foundation/Foundation.h>
@interface GetItemParams:NSObject
@property NSString * state_root_hash;
@property NSString * key;
@property NSMutableArray * path;
/**This function generate the json data used for sending POST method for state_get_item RPC call.
Based on the GetBalanceParams data, the JSON string is built somehow like this:
 
 {"method" : "state_get_item","id" : 1,"params" :{"state_root_hash" : "d360e2755f7cee816cce3f0eeb2000dfa03113769743ae5481816f3983d5f228","key":"withdraw-df067278a61946b1b1f784d16e28336ae79f48cf692b13f6e40af9c7eadb2fb1","path":[]},"jsonrpc" : "2.0"}
 
 */
-(NSString *) toJsonString;
@end

#endif 
