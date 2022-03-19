#ifndef Transform_WriteBid_h
#define Transform_WriteBid_h
#import "Bid.h"
@interface Transform_WriteBid:NSObject
@property Bid * bidValue;
+(Transform_WriteBid*) fromJsonDictToTransform_WriteBid:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
