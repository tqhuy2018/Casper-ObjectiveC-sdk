#import <Foundation/Foundation.h>
#import "GetBalanceParams.h"
@implementation GetBalanceParams
-(NSString*) toJsonString {
    NSString * ret =  [[NSString alloc] initWithFormat:@"{\"method\" : \"state_get_balance\",\"id\" : 1,\"params\" :{\"state_root_hash\" : \"%@\",\"purse_uref\":\"%@\"},\"jsonrpc\" : \"2.0\"}",self.state_root_hash,self.purse_uref];
    return ret;
}
@end
