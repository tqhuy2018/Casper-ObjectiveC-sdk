#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/GetStatusResult.h>
#import <CasperSDKObjectiveC/GetPeerList.h>
#import <CasperSDKObjectiveC/NextUpgrade.h>
#import <CasperSDKObjectiveC/ConstValues.h>
#import <CasperSDKObjectiveC/HttpHandler.h>
/**Class built for storing GetStatusResult information, taken from info_get_status RPC method
 */
@implementation GetStatusResult
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to GetStatusResult object
 */
+(GetStatusResult *) fromJsonDictToGetStatusResult:(NSDictionary*) jsonDict {
    GetStatusResult * ret = [[GetStatusResult alloc] init];
    ret.is_round_length_exists = true;
    ret.is_next_upgrade_exists = true;
    ret.is_last_added_block_info_exists = true;
    ret.is_our_public_signing_key_exists = true;
    NSDictionary * result = jsonDict[@"result"];
    ret.api_version = result[@"api_version"];
    ret.chainspec_name = result[@"chainspec_name"];
    ret.peers = [GetPeerList fromJsonToPeerMap:result];
    ret.starting_state_root_hash = result[@"starting_state_root_hash"];
    
    //check for optional values
    
    if(![result[@"last_added_block_info"] isEqual:[NSNull null]]) {
        ret.last_added_block_info = [[MinimalBlockInfo alloc]init];
        ret.last_added_block_info = [MinimalBlockInfo fromJsonToMinimalBlockInfo:result[@"last_added_block_info"]];
    } else {
        ret.is_last_added_block_info_exists = false;
    }
    if(![result[@"our_public_signing_key"] isEqual:[NSNull null]]) {
        ret.our_public_signing_key = result[@"our_public_signing_key"];
    } else {
        ret.is_our_public_signing_key_exists = false;
    }
    if(![result[@"round_length"] isEqual:[NSNull null]]) {
        ret.round_length = result[@"round_length"];
    } else {
        ret.is_round_length_exists  = false;
    }
   
    if (![result[@"next_upgrade"] isEqual:[NSNull null]]) {
        ret.next_upgrade = [NextUpgrade fromJsonDictToNextUpgrade:result[@"next_upgrade"]];
    } else {
        ret.is_next_upgrade_exists = false;
    }
    return ret;
}
/**This function initiate the process of sending POST request with given parameter in JSON string format
The input jsonString is used to send to server as parameter of the POST request to get the result back
The input jsonString is somehow like this:
 
 {"params" : [],"id" : 1,"method":"info_get_status","jsonrpc" : "2.0"}
 
 */
+(void) getStatusWithParams:(NSString*) jsonString {
    [HttpHandler handleRequestWithParam:jsonString andRPCMethod:CASPER_RPC_METHOD_INFO_GET_STATUS];
}

@end
