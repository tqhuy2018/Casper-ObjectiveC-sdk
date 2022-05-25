
#ifndef ValidatorWeight_h
#define ValidatorWeight_h
#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/U512Class.h>
/**Class built for storing ValidatorWeight information
 */
@interface ValidatorWeight:NSObject
@property NSString * validator;
@property U512Class * weight;
@end
#endif 
