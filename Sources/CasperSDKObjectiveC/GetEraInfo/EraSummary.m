#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/EraSummary.h>
/**Class built for storing EraSummary information
 */
@implementation EraSummary
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to EraSummary object
 */
+(EraSummary*) fromJsonDictToEraSummary:(NSDictionary*) fromDict {
    EraSummary * ret = [[EraSummary alloc] init];
    ret.block_hash = (NSString*) fromDict[@"block_hash"];
    ret.era_id = [(NSString *) fromDict[@"era_id"] longLongValue];
    ret.state_root_hash = (NSString*) fromDict[@"state_root_hash"];
    ret.merkle_proof = (NSString*) fromDict[@"merkle_proof"];
    ret.stored_value = [StoredValue fromJsonDictToStoredValue:fromDict[@"stored_value"]];
    return ret;
}
-(void) logInfo {
    NSLog(@"EraSummary, block_hash:%@",self.block_hash);
    NSLog(@"EraSummary, era_id:%llu",self.era_id);
    NSLog(@"EraSummary, state_root_hash:%@",self.state_root_hash);
    NSLog(@"EraSummary, merkle_proof length:%lu",(unsigned long)self.merkle_proof.length);
    [self.stored_value logInfo];
}
@end
