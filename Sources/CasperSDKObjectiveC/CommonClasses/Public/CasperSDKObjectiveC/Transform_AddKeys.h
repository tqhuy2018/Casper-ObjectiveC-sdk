#ifndef Transform_AddKeys_h
#define Transform_AddKeys_h
#import <Foundation/Foundation.h>
/**Class built for storing Transform_AddKeys information. This class store Transform enum of type  AddKeys. The Transform enum is based on this address:
 https://docs.rs/casper-types/1.4.6/casper_types/enum.Transform.html
 */
@interface Transform_AddKeys:NSObject
@property NSMutableArray * listKey;
/**This function parse the Array object (as part of the JSON object taken from server RPC method call) to Transform_AddKeys object
 */
+(Transform_AddKeys*) fromJSonArrayToTransform_AddKeys:(NSArray*) fromArray;
@end

#endif
