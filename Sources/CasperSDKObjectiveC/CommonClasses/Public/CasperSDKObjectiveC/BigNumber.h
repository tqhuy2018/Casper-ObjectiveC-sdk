#ifndef BigNumber_h
#define BigNumber_h
/**Class built for storing Big Number value
 */
#import <Foundation/Foundation.h>
@interface BigNumber:NSObject
@property NSString * itsValue;
-(NSString*) serialize;
@end

#endif 
