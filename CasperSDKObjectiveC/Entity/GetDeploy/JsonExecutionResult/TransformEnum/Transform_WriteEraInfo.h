#ifndef Transform_WriteEraInfo_h
#define Transform_WriteEraInfo_h
#import "EraInfo.h"
@interface Transform_WriteEraInfo:NSObject
@property EraInfo * itsEraInfo;
+(Transform_WriteEraInfo*) fromJsonArrayToTransform_WriteEraInfo:(NSArray*) fromDict;
-(void) logInfo;
@end

#endif
