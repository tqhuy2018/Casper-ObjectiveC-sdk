#ifndef Transform_WriteCLValue_h
#define Transform_WriteCLValue_h
#import "CLValue.h"
@interface Transform_WriteCLValue:NSObject
@property CLValue * itsValue;
+(Transform_WriteCLValue*) fromJsonDictToTransform_WriteCLValue:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
