#ifndef ContractPackage_h
#define ContractPackage_h
@interface ContractPackage:NSObject
///Access key of type URef
@property NSString * access_key;
///List of DisabledVersion;
@property NSMutableArray * disabled_versions;
///List of Group
@property NSMutableArray * groups;
///List of ContractVersion
@property NSMutableArray * versions;
+(ContractPackage*) fromJsonDictToContractPackage:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
