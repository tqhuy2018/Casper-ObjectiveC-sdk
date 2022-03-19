#ifndef Transform_AddNumber_h
#define Transform_AddNumber_h
///General class for all type of AddInt32, AddUInt64,AddUInt128,AddUInt256,AddUInt512
@interface Transform_AddNumber : NSObject
///Type of add, which can be AddInt32, AddUInt64,AddUInt128,AddUInt256,AddUInt512
@property NSString * numberType;
@property NSString * numberValue;
///Get Transform_AddNumber from Json dictionary
+(Transform_AddNumber*) fromJsonDictToTransform_AddNumber:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif