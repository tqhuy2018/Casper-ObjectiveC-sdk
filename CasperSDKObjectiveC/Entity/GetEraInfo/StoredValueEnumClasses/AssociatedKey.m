#import <Foundation/Foundation.h>
#import "AssociatedKey.h"
@implementation AssociatedKey
-(void) logInfo {
    NSLog(@"AssociatedKey, account_hash:%@",self.account_hash);
    NSLog(@"AssociatedKey, weight:%i",self.weight);
}
@end
