#ifndef EntryPoint_h
#define EntryPoint_h
#import "EntryPointAccess.h"
#import <CasperSDKObjectiveC/CLType.h>
#import <Foundation/Foundation.h>
/**Class built for storing EntryPoint information
 */
@interface EntryPoint:NSObject
@property NSString * entry_point_type;
@property NSString * name;
@property CLType * cl_type;
@property EntryPointAccess * access;
///List of Parameter
@property NSMutableArray * args;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to EntryPoint object
 */
+(EntryPoint*) fromJsonDictToEntryPoint:(NSDictionary*) fromDict;
@end


#endif 
