#ifndef ContractVersion_h
#define ContractVersion_h
@interface ContractVersion:NSObject
@property NSString * contract_hash;
@property UInt32 contract_version;
@property UInt32 protocol_version_major;
+(ContractVersion*) fromJsonDictToContractVersion:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
