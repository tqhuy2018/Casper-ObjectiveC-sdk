#import <Foundation/Foundation.h>
#import "JsonBlock.h"
#import "JsonBlockHeader.h"
#import "JsonBlockBody.h"
#import "JsonProof.h"
/**Class built for storing JsonBlock information
 */
@implementation JsonBlock
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to JsonBlock object
 */
+(JsonBlock*) fromJsonDictToJsonBlock:(NSDictionary*) fromDict {
    JsonBlock * ret = [[JsonBlock alloc] init];
    ret.blockHash = fromDict[@"hash"];//done
    ret.header = [JsonBlockHeader fromJsonDictToJsonBlockHeader:fromDict[@"header"]];
    ret.body = [JsonBlockBody fromJsonDictToJsonBlockBody:fromDict[@"body"]];
    ret.proofs = [JsonProof fromJsonDictToJsonProofList:(NSArray*) fromDict[@"proofs"]];
    return ret;
}
-(void) logInfo {
    NSLog(@"JsonBlock, block_hash:%@",self.blockHash);
    [self.header logInfo];
    [self.body logInfo];
    NSLog(@"JsonBlock,Total proof:%lu",self.proofs.count);
    if (self.proofs.count>0) {
        JsonProof * oneProof = self.proofs.firstObject;
        NSLog(@"JsonBlock, firstJsonProof public_key:%@",oneProof.public_key);
        NSLog(@"JsonBlock, firstJsonProof signature:%@",oneProof.signature);
    }
}
@end
