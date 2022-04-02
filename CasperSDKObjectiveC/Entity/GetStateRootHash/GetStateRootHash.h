#ifndef GetStateRootHash_h
#define GetStateRootHash_h
@interface GetStateRootHash:NSObject
///This function get the state root hash from Json object taken from the POST request of chain_get_state_root_hash RPC call
+(NSString*) fromJsonToStateRootHash:(NSDictionary*) fromDict;
///This function initiate the process of sending POST request with given parameter in JSON string format
+(void) getStateRootHashWithJsonParam:(NSString*) jsonString;
@end

#endif
