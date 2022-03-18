#ifndef Transform_WriteAccount_h
#define Transform_WriteAccount_h
@interface Transform_WriteAccount:NSObject
@property NSString * accountHash;
+(Transform_WriteAccount*) fromJsonDictToTransform_WriteAccount:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
