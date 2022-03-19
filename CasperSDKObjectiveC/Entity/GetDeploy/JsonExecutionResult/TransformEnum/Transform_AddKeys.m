#import <Foundation/Foundation.h>
#import "Transform_AddKeys.h"
#import "NamedKey.h"
@implementation Transform_AddKeys
+(Transform_AddKeys*) fromJSonDictToTransform_AddKeys:(NSDictionary *)fromDict {
    Transform_AddKeys * ret = [[Transform_AddKeys alloc] init];
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    NSArray * list = (NSArray*) fromDict[@"AddKeys"];
    int totalElement = (int) list.count;
    for (int i = 0 ; i < totalElement ; i ++) {
        NamedKey * oneNK = [[NamedKey alloc] init];
        oneNK = [NamedKey fromJsonDictToNamedKey:(NSDictionary*) [list objectAtIndex:i]];
        [arr addObject:oneNK];
    }
    ret.listKey = arr;
    return ret;
}
-(void) logInfo {
    int totalNamedKey = (int) self.listKey.count;
    NSLog(@"Transform_AddKeys, total NamedKey:%i",totalNamedKey);
    if (totalNamedKey >0) {
        NamedKey * firstNamedKey = self.listKey.firstObject;
        NSLog(@"First NamedKey key:%@",firstNamedKey.key);
        NSLog(@"First NamedKey name:%@",firstNamedKey.name);
    }
}
@end
