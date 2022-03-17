#ifndef CLType_h
#define CLType_h
@interface CLType:NSObject
/// Type of the CLType, can be Bool, String, I32, I64, List, Map,...
@property NSString * itsType;
///Tag for CLType, 0 for Bool, 1 for I32, 2 for I64...
@property NSString * itsTag;
@property CLType * innerType1;
@property CLType * innerType2;
@property CLType * innerType3;
@property bool is_innerType1_exists;
@property bool is_innerType2_exists;
@property bool is_innerType3_exists;
-(bool) isCLTypePrimitive;
-(NSString*) getItsType;
+(CLType*) fromObjToCLType:(NSObject*) fromObj;
+(CLType*) fromObjToCompoundCLType:(NSDictionary*) fromDict;
+(CLType*) fromObjToPrimitiveCLType:(NSObject*) fromObj;
-(void) logInfo;
@end

#endif 
