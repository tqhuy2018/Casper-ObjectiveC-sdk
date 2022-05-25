#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/EntryPoint.h>
#import <CasperSDKObjectiveC/Parameter.h>
/**Class built for storing EntryPoint information
 */
@implementation EntryPoint
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to EntryPoint object
 */
+(EntryPoint*) fromJsonDictToEntryPoint:(NSDictionary*) fromDict{
    EntryPoint * ret = [[EntryPoint alloc] init];
    ret.name = (NSString*) fromDict[@"name"];
    ret.entry_point_type = (NSString*) fromDict[@"entry_point_type"];
    ret.cl_type = [CLType fromObjToCLType:fromDict[@"cl_type"]];
    //Get list of parameter
    NSArray * listArgs = (NSArray*) fromDict[@"args"];
    int totalArgs = (int) listArgs.count;
    if(totalArgs>0) {
        for(int i = 0 ; i < totalArgs;i ++) {
            Parameter * p = [[Parameter alloc] init];
            p = [Parameter fromJsonDictToParameter:(NSDictionary *) [listArgs objectAtIndex:i]];
            [ret.args addObject:p];
        }
    }
    //Get EntryPointAccess
    ret.access = [EntryPointAccess fromJsonDictToEntryPointAccess:fromDict[@"access"]];
    return ret;
}
-(void) logInfo {
    NSLog(@"Entry Point, name: %@",self.name);
    NSLog(@"Entry Point, entry_point_type: %@",self.entry_point_type);
}
@end
