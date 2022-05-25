#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/JsonExecutionResult.h>
#import <CasperSDKObjectiveC/U512Class.h>
/**Class built for storing JsonExecutionResult information
 */
@implementation JsonExecutionResult
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to JsonExecutionResult object
 */
+(JsonExecutionResult*) fromJsonDictToJsonExecutionResult:(NSDictionary*) fromDict {
    JsonExecutionResult * ret = [[JsonExecutionResult alloc] init];
    ret.block_hash = fromDict[@"block_hash"];
    NSDictionary * result = (NSDictionary*) fromDict[@"result"];
    //Result Success
    if(!(result[@"Success"] == nil)) {
        ret.is_ExecutionResult_success = true;
        NSDictionary * resultDict = (NSDictionary*) result[@"Success"];
        ret.cost = [U512Class fromStrToClass:(NSString *) resultDict[@"cost"]];
        //get transfers
        NSArray * transfers = (NSArray*) resultDict[@"transfers"];
        int totalTransfer = (int) transfers.count;
        if(totalTransfer >0) {
            ret.transfers = [[NSMutableArray alloc] init];
            for(int i = 0 ; i < totalTransfer ;i ++) {
                NSString * oneTransfer = (NSString*) [transfers objectAtIndex:i];
                [ret.transfers addObject:oneTransfer];
            }
        }
        //get ExecutionEffect
        ret.effect = [ExecutionEffect fromJsonDictToExecutionEffect:resultDict[@"effect"]];
    } else { //Result Failure
        ret.is_ExecutionResult_success = false;
        NSDictionary * resultDict = (NSDictionary*) result[@"Failure"];
        ret.error_message = (NSString*) resultDict[@"error_message"];
        //get transfers
        NSArray * transfers = (NSArray*) resultDict[@"transfers"];
        int totalTransfer = (int) transfers.count;
        if(totalTransfer >0) {
            ret.transfers = [[NSMutableArray alloc] init];
            for(int i = 0 ; i < totalTransfer ;i ++) {
                NSString * oneTransfer = (NSString*) [transfers objectAtIndex:i];
                [ret.transfers addObject:oneTransfer];
            }
        }
        //get ExecutionEffect
        ret.effect = [ExecutionEffect fromJsonDictToExecutionEffect:resultDict[@"effect"]];
    }
    return ret;
}
-(void) logInfo {
    NSLog(@"JsonExecutionResult, block_hash:%@",self.block_hash);
    if(self.is_ExecutionResult_success == true) {
        NSLog(@"JsonExecutionResult of type Success");
        NSLog(@"JsonExecutionResult cost:%@",self.cost.itsValue);
        //Effect information
        NSLog(@"JsonExecutionResult effect information");
        [self.effect logInfo];
        //Transfer information
        int totalTransfer = (int) self.transfers.count;
        NSLog(@"JsonExecutionResult,Total transfer:%i",totalTransfer);
        if (totalTransfer >0) {
            for(int i = 0 ;i < totalTransfer; i++) {
                NSLog(@"JsonExecutionResult, transfer number:%i, value:%@",i+1,(NSString*) [self.transfers objectAtIndex:i]);
            }
        }
        
    } else {
        NSLog(@"JsonExecutionResult of type Failure");
        NSLog(@"JsonExecutionResult error message:%@",self.error_message);
        NSLog(@"JsonExecutionResult cost:%@",self.cost.itsValue);

    }
}
@end
