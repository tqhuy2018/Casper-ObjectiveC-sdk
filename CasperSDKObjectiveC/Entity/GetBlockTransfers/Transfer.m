#import <Foundation/Foundation.h>
#import "Transfer.h"
#import "U512Class.h"
@implementation Transfer
+(NSMutableArray*) fromJsonDictToTransferList:(NSArray*) nsArray {
    NSMutableArray * ret = [[NSMutableArray alloc] init];
    
    return ret;
}
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
        ret.id = (UInt64) jsonDict[@"id"];
    } else {
        ret.is_id_exists = false;
    }
    return ret;
}
@end
