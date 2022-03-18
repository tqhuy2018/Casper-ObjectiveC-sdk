#import <Foundation/Foundation.h>
#import "TransformEntry.h"
@implementation TransformEntry
+(TransformEntry*) fromJsonDictToTransformEntry:(NSDictionary*) fromDict {
    TransformEntry * ret = [[TransformEntry alloc] init];
    return ret;
}
@end
