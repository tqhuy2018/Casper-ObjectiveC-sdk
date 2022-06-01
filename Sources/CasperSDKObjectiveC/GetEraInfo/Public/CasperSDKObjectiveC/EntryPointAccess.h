#ifndef EntryPointAccess_h
#define EntryPointAccess_h
#import <Foundation/Foundation.h>
/**Class built for storing EntryPointAccess information
 */
///This class represent the Enum type as described in this address
///https://docs.rs/casper-types/1.4.6/casper_types/enum.EntryPointAccess.html
@interface EntryPointAccess:NSObject
///This property is determined whether the type is Public, if false then it is of type Groups, which is an Array of Group object
@property bool is_type_public;
@property NSMutableArray * Groups;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to EntryPointAccess object
 */
+(EntryPointAccess*) fromJsonDictToEntryPointAccess:(NSDictionary*) fromDict;
@end

#endif
