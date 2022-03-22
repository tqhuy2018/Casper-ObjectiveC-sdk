#import <Foundation/Foundation.h>
#import "Account.h"
#import "NamedKey.h"
#import "AssociatedKey.h"
#import "ActionThresholds.h"
@implementation Account
+(Account*) fromJsonDictToAccount:(NSDictionary *) fromDict {
    Account * ret = [[Account alloc] init];
    ret.account_hash = fromDict[@"account_hash"];
    ret.main_purse = fromDict[@"main_purse"];
    //get NamedKey list
    NSArray * listNamedKey = (NSArray*) fromDict[@"named_keys"];
    int totalNamedKey = (int) listNamedKey.count;
    if(totalNamedKey>0) {
        ret.named_keys = [[NSMutableArray alloc] init];
        for(int i = 0; i < totalNamedKey; i++) {
            NSDictionary * oneNKDict = (NSDictionary*) [listNamedKey objectAtIndex:i];
            NamedKey * oneNK = [[NamedKey alloc] init];
            oneNK = [NamedKey fromJsonDictToNamedKey:oneNKDict];
            [ret.named_keys addObject:oneNK];
        }
    }
    //get AssociatedKey list
    NSArray * listAssociatedKey = (NSArray*) fromDict[@"associated_keys"];
    int totalAK = (int) listAssociatedKey.count;
    if(totalAK>0) {
        ret.associated_keys = [[NSMutableArray alloc] init];
        for(int i = 0; i < totalAK ; i++) {
            NSDictionary * oneAKDict = (NSDictionary*) [listAssociatedKey objectAtIndex:i];
            AssociatedKey * oneAK = [[AssociatedKey alloc] init];
            oneAK = [[AssociatedKey alloc] init];
            oneAK.weight = (int) [oneAKDict[@"weight"] intValue];
            oneAK.account_hash = (NSString*) oneAKDict[@"account_hash"];
            [ret.associated_keys addObject:oneAK];
        }
    }
    //get ActionThresholds
    NSDictionary * atDict = (NSDictionary*) fromDict[@"action_thresholds"];
    ret.action_thresholds = [[ActionThresholds alloc] init];
    ret.action_thresholds.deployment = (int) [atDict[@"deployment"] intValue];
    ret.action_thresholds.key_management = (int) [atDict[@"key_management"] intValue];
    return ret;
   
}
-(void) logInfo {
    NSLog(@"-----Stored value, Account information----");
    NSLog(@"Stored value, Account, account_hash:%@",self.account_hash);
    NSLog(@"Stored value, Account, main_purse:%@",self.main_purse);
    int totalNamedKey = (int) self.named_keys.count;
    NSLog(@"Stored value, Account, total NamedKey:%i",totalNamedKey);
    if(totalNamedKey > 0) {
        for(int i = 0; i < totalNamedKey ;i ++) {
            NamedKey * oneNK = (NamedKey*) [self.named_keys objectAtIndex:i];
            [oneNK logInfo];
        }
    }
    int totalAK = (int) self.associated_keys.count;
    NSLog(@"Stored value, Account, total AssociatedKey:%i",totalAK);
    if(totalAK > 0) {
        for(int i = 0; i < totalAK ;i ++) {
            AssociatedKey * oneAK = (AssociatedKey*) [self.associated_keys objectAtIndex:i];
            [oneAK logInfo];
        }
    }
    NSLog(@"Stored value, Account,ActionThresholds,deployment:%i",self.action_thresholds.deployment);
    NSLog(@"Stored value, Account,ActionThresholds,key_management:%i",self.action_thresholds.key_management);
}
@end
