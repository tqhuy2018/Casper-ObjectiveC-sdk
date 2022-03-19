#ifndef Transform_Failure_h
#define Transform_Failure_h
@interface Transform_Failure:NSObject
@property NSString * itsValue;
+(Transform_Failure*) fromJsonDictToTransform_Failure:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
