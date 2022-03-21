#ifndef DisabledVersion_h
#define DisabledVersion_h
@interface DisabledVersion:NSObject
@property UInt32 contract_version;
@property UInt32 protocol_version_major;
+(DisabledVersion*) fromJsonDictToDisabledVersion:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
