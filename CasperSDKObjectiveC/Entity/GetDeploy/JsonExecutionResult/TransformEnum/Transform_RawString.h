#ifndef Transform_RawString_h
#define Transform_RawString_h
@interface Transform_RawString:NSObject
///Type of TransformRawString, which can hold the following value: Identity, WriteContractWasm,WriteContract,WriteContractPackage
@property NSString * itsType;
+(Transform_RawString * ) fromJsonDictToTransform_RawString:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
