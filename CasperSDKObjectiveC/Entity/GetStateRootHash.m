#import <Foundation/Foundation.h>
#import "GetStateRootHash.h"
#import "HttpHandler.h"
#import "ConstValues.h"
@implementation GetStateRootHash

+(NSString*) fromJsonToStateRootHash:(NSDictionary*) nsData {
    NSDictionary * result = [nsData objectForKey:@"result"];
    NSString * state_root_hash = [result objectForKey:@"state_root_hash"];
    return state_root_hash;
}

+(void) getStateRootHashWithJsonParam:(NSString*) jsonString {
    [HttpHandler handleRequestWithParam:jsonString andRPCMethod:CASPER_RPC_METHOD_GET_STATE_ROOT_HASH];
}

@end
