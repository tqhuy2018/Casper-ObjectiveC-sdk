#import <Foundation/Foundation.h>
#import "ExecutionEffect.h"
#import "Operation.h"
#import "TransformEntry.h"
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
-(void) logInfo {
    int totalOperation = (int) self.operations.count;
    int totalTransform = (int) self.transforms.count;
    if(totalOperation>0) {
        NSLog(@"Total operation:%i",totalOperation);
        NSLog(@"First operation information");
        Operation * oneO = [self.operations objectAtIndex:0];
        NSLog(@"Operation item  key:%@, kind:%@",oneO.key,oneO.kind);
    } else {
        NSLog(@"Operation:[]");
    }
    if(totalTransform >0) {
        NSLog(@"Total transform:%i",totalTransform);
        NSLog(@"First transform information");
        TransformEntry * oneTE = self.transforms.firstObject;
        [oneTE logInfo];
    } else {
        NSLog(@"Transform:[]");
    }
}
@end
