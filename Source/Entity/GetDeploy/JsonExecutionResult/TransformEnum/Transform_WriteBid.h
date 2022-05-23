#ifndef Transform_WriteBid_h
#define Transform_WriteBid_h
#import "Bid.h"
/**Class built for storing Transform_WriteBid information. This class store Transform enum of type  WriteBid. The Transform enum is based on this address:
 https://docs.rs/casper-types/1.4.6/casper_types/enum.Transform.html
 */
@interface Transform_WriteBid:NSObject
@property Bid * bidValue;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to Transform_WriteBid object
 */
+(Transform_WriteBid*) fromJsonDictToTransform_WriteBid:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
