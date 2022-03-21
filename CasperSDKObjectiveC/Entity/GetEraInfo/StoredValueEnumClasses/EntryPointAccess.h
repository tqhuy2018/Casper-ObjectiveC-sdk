#ifndef EntryPointAccess_h
#define EntryPointAccess_h
///This class represent the Enum type as described in this address
///https://docs.rs/casper-types/1.4.6/casper_types/enum.EntryPointAccess.html
@interface EntryPointAccess:NSObject
///This property is determined whether the type is Public, if false then it is of type Groups, which is an Array of Group object
@property bool is_type_public;
@property NSMutableArray * Groups;
+(EntryPointAccess*) fromJsonDictToEntryPointAccess:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
