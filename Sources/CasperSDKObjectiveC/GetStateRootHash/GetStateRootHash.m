#import <Foundation/Foundation.h>
#import "CasperSDKObjectiveC/GetStateRootHash.h"
#import <CasperSDKObjectiveC/HttpHandler.h>
#import <CasperSDKObjectiveC/ConstValues.h>
@implementation GetStateRootHash

///This function get the state root hash from Json object taken from the POST request of chain_get_state_root_hash RPC call
+(NSString*) fromJsonToStateRootHash:(NSDictionary*) fromDict {
    NSDictionary * result = [fromDict objectForKey:@"result"];
    NSString * state_root_hash = [result objectForKey:@"state_root_hash"];
    return state_root_hash;
}


+(void) getStateRootHashWithJsonParam1:(NSString*) jsonString {
    [HttpHandler handleRequestWithParam:jsonString andRPCMethod:CASPER_RPC_METHOD_GET_STATE_ROOT_HASH];
}

@end
