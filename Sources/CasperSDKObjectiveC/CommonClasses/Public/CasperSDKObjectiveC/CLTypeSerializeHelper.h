#ifndef CLTypeSerializeHelper_h
#define CLTypeSerializeHelper_h
#import <Foundation/Foundation.h>

#import <CasperSDKObjectiveC/CLType.h>
/**
 This class do the work of serialize the CLType object
 */
@interface CLTypeSerializeHelper:NSObject
/**
 This function do the work of serialize the CLTYpe object
 Input: the CLType object
 Output: the serialization of the CLType object
 */
+(NSString *) serializeForCLType:(CLType*) clType;
@end

#endif
