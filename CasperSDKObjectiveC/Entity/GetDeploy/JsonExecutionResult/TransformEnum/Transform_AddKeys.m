#import <Foundation/Foundation.h>
#import "Transform_AddKeys.h"
#import "NamedKey.h"
/**Class built for storing Transform_AddKeys information. This class store Transform enum of type  AddKeys. The Transform enum is based on this address:
 https://docs.rs/casper-types/1.4.6/casper_types/enum.Transform.html
 */
@implementation Transform_AddKeys
+(Transform_AddKeys*) fromJSonArrayToTransform_AddKeys:(NSArray *)fromArray {
    Transform_AddKeys * ret = [[Transform_AddKeys alloc] init];
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    int totalElement = (int) fromArray.count;
    for (int i = 0 ; i < totalElement ; i ++) {
        NamedKey * oneNK = [[NamedKey alloc] init];
        oneNK = [NamedKey fromJsonDictToNamedKey:(NSDictionary*) [fromArray objectAtIndex:i]];
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
