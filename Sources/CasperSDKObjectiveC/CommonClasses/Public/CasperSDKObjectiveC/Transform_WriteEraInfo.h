#ifndef Transform_WriteEraInfo_h
#define Transform_WriteEraInfo_h
#import "EraInfo.h"
#import <Foundation/Foundation.h>
/**Class built for storing Transform_WriteEraInfo information. This class store Transform enum of type  WriteEraInfo. The Transform enum is based on this address:
 https://docs.rs/casper-types/1.4.6/casper_types/enum.Transform.html
 */
@interface Transform_WriteEraInfo:NSObject
@property EraInfo * itsEraInfo;
/**This function parse the Array object (as part of the JSON object taken from server RPC method call) to Transform_WriteEraInfo object
 */
+(Transform_WriteEraInfo*) fromJsonArrayToTransform_WriteEraInfo:(NSArray*) fromDict;
@end

#endif
