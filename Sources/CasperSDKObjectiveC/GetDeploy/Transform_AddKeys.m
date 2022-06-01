#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/Transform_AddKeys.h>
#import <CasperSDKObjectiveC/NamedKey.h>
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

@end
