#ifndef Approval_h
#define Approval_h
@interface Approval: NSObject
@property NSString * signature;
@property NSString * signer;
+(Approval*) fromJsonDictToApproval:(NSDictionary*) fromDict;
+(NSMutableArray*) fromArrayToListApproval:(NSArray*) fromArray;
-(void) logInfo;
@end

#endif
