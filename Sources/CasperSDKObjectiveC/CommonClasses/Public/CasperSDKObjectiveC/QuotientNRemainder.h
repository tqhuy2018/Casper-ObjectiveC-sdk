#ifndef QuotientNRemainder_h
#define QuotientNRemainder_h
#import <Foundation/Foundation.h>
/**Class built for storing QuotientNRemainder information of a divide equotion of number of all size (could be very big number such as U128, U256 and U512)
 This class is used for number serialization
 */
@interface QuotientNRemainder:NSObject
@property int remainder;
@property NSString * quotient;
@end

#endif
