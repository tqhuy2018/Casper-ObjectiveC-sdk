#ifndef EntryPoint_h
#define EntryPoint_h
#import "EntryPointAccess.h"
#import "CLType.h"
@interface EntryPoint:NSObject
@property NSString * entry_point_type;
@property NSString * name;
@property CLType * cl_type;
@property EntryPointAccess * access;
///List of Parameter
@property NSMutableArray * args;
+(EntryPoint*) fromJsonDictToEntryPoint:(NSDictionary*) fromDict;
-(void) logInfo;
@end


#endif 
