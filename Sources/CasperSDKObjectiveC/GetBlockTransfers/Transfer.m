#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/Transfer.h>
//#import "U512Class.h"
/**Class built for storing Transfer information
 */
@implementation Transfer
/**This function parse the Array object (as part of the JSON object taken from server RPC method call) to a list of Transfer object
 */
+(NSMutableArray*) fromJsonDictToTransferList:(NSArray*) nsArray {
    NSMutableArray * listTransfer = [[NSMutableArray alloc]init];
    for (id obj in nsArray) {
        Transfer * oneTransfer = [Transfer fromJsonDictToTransfer:obj];
        [listTransfer addObject:oneTransfer];
    }
    return listTransfer;
}
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to Transfer object
 */
+(Transfer *) fromJsonDictToTransfer:(NSDictionary*) jsonDict {
    Transfer * ret = [[Transfer alloc] init];
    ret.is_to_exists = true;
    ret.is_id_exists = true;
    ret.deploy_hash = jsonDict[@"deploy_hash"];
    ret.from = jsonDict[@"from"];
    ret.source = jsonDict[@"source"];
    ret.target = jsonDict[@"target"];
    ret.amount = [U512Class fromStrToClass: jsonDict[@"amount"]];
    ret.gas = [U512Class fromStrToClass:jsonDict[@"gas"]];
    
    if(![jsonDict[@"to"] isEqual:[NSNull null]]) {
        ret.to = jsonDict[@"to"];
    } else {
        ret.is_to_exists = false;
    }
    if(![jsonDict[@"id"] isEqual:[NSNull null]]) {
        ret.id = [(NSString*) jsonDict[@"id"] longLongValue];
    } else {
        ret.is_id_exists = false;
    }
    return ret;
}
@end
