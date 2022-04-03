#import <Foundation/Foundation.h>
#import "AssociatedKey.h"
/**Class built for storing AssociatedKey information
 */
@implementation AssociatedKey
-(void) logInfo {
    NSLog(@"AssociatedKey, account_hash:%@",self.account_hash);
    NSLog(@"AssociatedKey, weight:%i",self.weight);
}
@end
