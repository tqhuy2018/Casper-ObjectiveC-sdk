#ifndef Transform_AddKeys_h
#define Transform_AddKeys_h
@interface Transform_AddKeys:NSObject
@property NSMutableArray * listKey;
+(Transform_AddKeys*) fromJSonDictToTransform_AddKeys:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
