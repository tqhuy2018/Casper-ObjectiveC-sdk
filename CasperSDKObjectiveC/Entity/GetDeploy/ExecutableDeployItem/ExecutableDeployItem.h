#ifndef ExecutableDeployItem_h
#define ExecutableDeployItem_h
@interface ExecutableDeployItem:NSObject
///This is the type of the ExecutableDeployItem, which can be ModuleBytes,StoredContractByHash,StoredContractByName,StoredVersionedContractByHash,StoredVersionedContractByName,Transfer
@property NSString * itsType;
///This property only hold 1 item, which can be 1 among the 6 value of the enum of ExecutableDeployItem
@property NSMutableArray * itsValue;
+(ExecutableDeployItem*) fromJsonDictToExecutableDeployItem:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
