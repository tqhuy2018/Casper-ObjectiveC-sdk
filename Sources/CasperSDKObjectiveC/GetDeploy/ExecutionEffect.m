#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/ExecutionEffect.h>
#import <CasperSDKObjectiveC/Operation.h>
#import <CasperSDKObjectiveC/TransformEntry.h>
/**Class built for storing ExecutionEffect information
 */
@implementation ExecutionEffect
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to ExecutionEffect object
 */
+(ExecutionEffect*) fromJsonDictToExecutionEffect:(NSDictionary*) fromDict {
    ExecutionEffect * ret = [[ExecutionEffect alloc] init];
    NSArray * operationList = (NSArray*) fromDict[@"operations"];
    NSArray * transformList = (NSArray*) fromDict[@"transforms"];
    int totalOperation = (int) operationList.count;
    int totalTransform = (int) transformList.count;
    //get operations
    if (totalOperation>0) {
        ret.operations = [[NSMutableArray alloc] init];
        for(int i = 0 ; i < totalOperation; i ++) {
            NSDictionary * oneOperationDict = (NSDictionary*) [operationList objectAtIndex:i];
            Operation * oneOperation = [[Operation alloc]init];
            oneOperation.key = oneOperationDict[@"key"];
            oneOperation.kind = oneOperationDict[@"kind"];
            [ret.operations addObject:oneOperation];
        }
    }
    //add Transform
    if(totalTransform >0) {
        ret.transforms = [[NSMutableArray alloc] init];
        for(int i = 0; i < totalTransform; i++) {
            NSDictionary * oneTransformDict = (NSDictionary*) [transformList objectAtIndex:i];
            TransformEntry * oneTransform = [[TransformEntry alloc] init];
            oneTransform = [TransformEntry fromJsonDictToTransformEntry:oneTransformDict];
            [ret.transforms addObject:oneTransform];
        }
    }
    return ret;
}
@end
