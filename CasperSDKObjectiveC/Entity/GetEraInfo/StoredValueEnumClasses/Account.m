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
            oneAK.weight = (UInt8) oneAKDict[@"weight"];
            oneAK.account_hash = (NSString*) oneAKDict[@"account_hash"];
            [ret.associated_keys addObject:oneAK];
        }
    }
    //get ActionThresholds list
    NSArray * listActionThreshold = (NSArray*) fromDict[@"action_thresholds"];
    int totalAT = (int) listActionThreshold.count;
    if(totalAT>0) {
        ret.action_thresholds = [[NSMutableArray alloc] init];
        for(int i = 0 ; i< totalAT;i++) {
            NSDictionary * oneATDict = (NSDictionary*) [listActionThreshold objectAtIndex:i];
            ActionThresholds * oneAT = [[ActionThresholds alloc] init];
            oneAT.deployment = oneATDict[@"deployment"];
            oneAT.key_management = oneATDict[@"key_management"];
            [ret.action_thresholds addObject:oneAT];
        }
    }
    return ret;
   
}
-(void) logInfo {
    NSLog(@"-----Stored value, Account information----");
    NSLog(@"Stored value, Account, account_hash:%@",self.account_hash);
    NSLog(@"Stored value, Account, main_purse:%@",self.main_purse);
    int totalNamedKey = (int) self.named_keys.count;
    NSLog(@"Stored value, Account, total NamedKey:%@",totalNamedKey);
    if(totalNamedKey > 0) {
        for(int i = 0; i < totalNamedKey ;i ++) {
            NamedKey * oneNK = (NamedKey*) [self.named_keys objectAtIndex:i];
            [oneNK logInfo];
        }
    }
    int totalAK = (int) self.associated_keys.count;
    NSLog(@"Stored value, Account, total AssociatedKey:%@",totalAK);
    if(totalAK > 0) {
        for(int i = 0; i < totalAK ;i ++) {
            AssociatedKey * oneAK = (AssociatedKey*) [self.associated_keys objectAtIndex:i];
            [oneAK logInfo];
        }
    }
    int totalAT = (int) self.action_thresholds.count;
    NSLog(@"Stored value, Account, total ActionThresholds:%@",totalAT);
    if(totalAT > 0) {
        for(int i = 0; i < totalAT ;i ++) {
            ActionThresholds * oneAT = (ActionThresholds*) [self.action_thresholds objectAtIndex:i];
            NSLog(@"ActionThresholds,deployment:%i",oneAT.deployment);
            NSLog(@"ActionThresholds,key_management:%i",oneAT.key_management);
        }
    }
}
@end
