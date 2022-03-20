#import <Foundation/Foundation.h>
#import "ExecutionEffect.h"
#import "Operation.h"
#import "TransformEntry.h"
@implementation ExecutionEffect
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
            NSLog(@"Get transform object index:%i",i+1);
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
        for(int i = 0; i < totalOperation; i ++) {
            Operation * oneO = [self.operations objectAtIndex:i];
            NSLog(@"Operation item %i, key:%@, kind:%@",i,oneO.key,oneO.kind);
        }
    } else {
        NSLog(@"Operation:[]");
    }
    if(totalTransform >0) {
        NSLog(@"Total transform:%i",totalTransform);
        for(int i = 0; i < totalTransform;i++) {
            NSLog(@"Information for Transform number %i",i);
            TransformEntry * oneTE = [self.transforms objectAtIndex:i];
            [oneTE logInfo];
        }
    } else {
        NSLog(@"Transform:[]");
    }
}
@end
