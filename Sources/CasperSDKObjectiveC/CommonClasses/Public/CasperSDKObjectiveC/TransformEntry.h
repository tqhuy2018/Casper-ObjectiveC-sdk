#ifndef TransformEntry_h
#define TransformEntry_h
#import <Foundation/Foundation.h>
/**Class built for storing TransformEntry information, base on this https://docs.rs/casper-types/1.4.6/casper_types/enum.Transform.html
 */
@interface TransformEntry:NSObject
@property NSString * key;
///Transform of type enum, but saved as 1 array of 1 element only. The value of the element is determined at parsing time to see what kind of Transform it is to put in the array; This can be Identity, WriteCLValue, WriteAccount, WriteContractWasm...
@property NSMutableArray * transform;
@property NSString * transformType;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to TransformEntry object
 */
+(TransformEntry*) fromJsonDictToTransformEntry:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
