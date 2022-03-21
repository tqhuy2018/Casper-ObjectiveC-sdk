#import <Foundation/Foundation.h>
#import "ContractPackage.h"
#import "DisabledVersion.h"
#import "Groups.h"
#import "ContractVersion.h"
@implementation ContractPackage
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
    if(totalDV>0) {
        ret.versions = [[NSMutableArray alloc] init];
        for(int i = 0 ; i < totalCV;i++) {
            ContractVersion * oneCV = [[ContractVersion alloc] init];
            oneCV = [ContractVersion fromJsonDictToContractVersion:(NSDictionary *) [listCV objectAtIndex:i]];
            [ret.versions addObject:oneCV];
        }
    }
    return ret;
}
-(void) logInfo {
    NSLog(@"ContractPackage, access_key:%@",self.access_key);
    if(self.disabled_versions.count>0) {
        int totalDV = (int) self.disabled_versions.count;
        for(int i = 0 ;i < totalDV;i ++) {
            DisabledVersion * oneDV = (DisabledVersion*) [self.disabled_versions objectAtIndex:i];
            [oneDV logInfo];
        }
    } else {
        NSLog(@"ContractPackage, disabled_versions empty");
    }
    if(self.groups.count>0) {
        int totalG = (int) self.groups.count;
        for(int i = 0 ;i < totalG;i ++) {
            Groups * oneG = (Groups*) [self.groups objectAtIndex:i];
            [oneG logInfo];
        }
    } else {
        NSLog(@"ContractPackage, groups empty");
    }
    if(self.versions.count>0) {
        int totalV = (int) self.versions.count;
        for(int i = 0 ;i < totalV;i ++) {
            ContractVersion * oneCV = (ContractVersion*) [self.versions objectAtIndex:i];
            [oneCV logInfo];
        }
    } else {
        NSLog(@"ContractPackage, disabled_versions empty");
    }
}
@end
