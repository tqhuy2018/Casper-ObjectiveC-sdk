#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/Account.h>
#import <CasperSDKObjectiveC/NamedKey.h>
#import <CasperSDKObjectiveC/AssociatedKey.h>
#import <CasperSDKObjectiveC/ActionThresholds.h>
/**Class built for storing Account information
 */
@implementation Account
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to Account object
 */
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
@end
