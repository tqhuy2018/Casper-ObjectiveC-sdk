#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/JsonBlock.h>
#import <CasperSDKObjectiveC/JsonBlockHeader.h>
#import <CasperSDKObjectiveC/JsonBlockBody.h>
#import <CasperSDKObjectiveC/JsonProof.h>
/**Class built for storing JsonBlock information
 */
@implementation JsonBlock
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to JsonBlock object
 */
+(JsonBlock*) fromJsonDictToJsonBlock:(NSDictionary*) fromDict {
    JsonBlock * ret = [[JsonBlock alloc] init];
    ret.blockHash = fromDict[@"hash"];
    ret.header = [JsonBlockHeader fromJsonDictToJsonBlockHeader:fromDict[@"header"]];
    ret.body = [JsonBlockBody fromJsonDictToJsonBlockBody:fromDict[@"body"]];
    ret.proofs = [JsonProof fromJsonDictToJsonProofList:(NSArray*) fromDict[@"proofs"]];
    return ret;
}
@end
