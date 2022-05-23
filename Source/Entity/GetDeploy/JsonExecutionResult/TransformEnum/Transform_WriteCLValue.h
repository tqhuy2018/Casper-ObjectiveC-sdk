#ifndef Transform_WriteCLValue_h
#define Transform_WriteCLValue_h
#import "CLValue.h"
/**Class built for storing Transform_WriteCLValue information. This class store Transform enum of type  WriteCLValue. The Transform enum is based on this address:
 https://docs.rs/casper-types/1.4.6/casper_types/enum.Transform.html
 */
@interface Transform_WriteCLValue:NSObject
@property CLValue * itsValue;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to Transform_WriteCLValue object
 */
+(Transform_WriteCLValue*) fromJsonDictToTransform_WriteCLValue:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
