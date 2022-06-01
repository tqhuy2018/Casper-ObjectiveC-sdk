#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/ContractPackage.h>
#import <CasperSDKObjectiveC/DisabledVersion.h>
#import <CasperSDKObjectiveC/Groups.h>
#import <CasperSDKObjectiveC/ContractVersion.h>
/**Class built for storing ContractPackage information
 */
@implementation ContractPackage
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to ContractPackage object
 */
+(ContractPackage*) fromJsonDictToContractPackage:(NSDictionary*) fromDict {
    ContractPackage * ret = [[ContractPackage alloc] init];
    ret.access_key = (NSString*) fromDict[@"access_key"];
    //Get list of DisabledVersion
    NSArray * listDisabledVersion = (NSArray*) fromDict[@"disabled_versions"];
    int totalDV = (int) listDisabledVersion.count;
    if(totalDV>0) {
        ret.disabled_versions = [[NSMutableArray alloc] init];
        for(int i = 0 ; i < totalDV; i ++) {
            DisabledVersion * oneDV = [[DisabledVersion alloc] init];
            NSDictionary * oneDVDict = (NSDictionary*) [listDisabledVersion objectAtIndex:i];
            oneDV = [DisabledVersion fromJsonDictToDisabledVersion:oneDVDict];
            [ret.disabled_versions addObject:oneDV];
        }
    }
    //Get list of Groups
    NSArray * listGroups = (NSArray*) fromDict[@"groups"];
    int totalGroup = (int) listGroups.count;
    if(totalGroup>0) {
        ret.groups = [[NSMutableArray alloc] init];
        for(int i = 0 ; i < totalGroup; i++) {
            Groups * oneGroup = [[Groups alloc] init];
            oneGroup = [Groups fromJSonDictToGroups:(NSDictionary*) [listGroups objectAtIndex:i]];
            [ret.groups addObject:oneGroup];
        }
    }
    //Get list of ContractVersion
    NSArray * listCV = (NSArray*) fromDict[@"versions"];
    int totalCV = (int) listCV.count;
    if(totalCV>0) {
        ret.versions = [[NSMutableArray alloc] init];
        for(int i = 0 ; i < totalCV;i++) {
            ContractVersion * oneCV = [[ContractVersion alloc] init];
            oneCV = [ContractVersion fromJsonDictToContractVersion:(NSDictionary *) [listCV objectAtIndex:i]];
            [ret.versions addObject:oneCV];
        }
    }
    return ret;
}
@end
