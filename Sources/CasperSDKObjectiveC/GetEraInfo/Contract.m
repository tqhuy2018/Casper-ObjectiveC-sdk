#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/Contract.h>
#import <CasperSDKObjectiveC/EntryPoint.h>
/**Class built for storing Contract information
 */
@implementation Contract
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to Contract object
 */
+(Contract*) fromJsonDictToContact:(NSDictionary*) fromDict {
    Contract * ret = [[Contract alloc] init];
    ret.contract_package_hash = (NSString*) fromDict[@"contract_package_hash"];
    ret.contract_wasm_hash = (NSString*) fromDict[@"contract_wasm_hash"];
    ret.protocol_version = (NSString*) fromDict[@"protocol_version"];
    NSArray *  listEP = (NSArray*) fromDict[@"entry_points"];
    int totalEP = (int) listEP.count;
    if(totalEP >0) {
        for(int i = 0 ; i < totalEP ; i++ ){
            EntryPoint * oneEP = [[EntryPoint alloc] init];
            oneEP = [EntryPoint fromJsonDictToEntryPoint:(NSDictionary *)[listEP objectAtIndex:i]];
            [ret.entry_points addObject: oneEP];
        }
    }
    return ret;
}

@end
