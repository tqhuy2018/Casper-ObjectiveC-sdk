#ifndef Transform_AddKeys_h
#define Transform_AddKeys_h
@interface Transform_AddKeys:NSObject
@property NSMutableArray * listKey;
+(Transform_AddKeys*) fromJSonArrayToTransform_AddKeys:(NSArray*) fromArray;
-(void) logInfo;
@end

#endif
