#import <Foundation/Foundation.h>
#import "ExecutableDeployItem.h"
#import "ExecutableDeployItem_Transfer.h"
#import "ExecutableDeployItem_ModuleBytes.h"
#import "ExecutableDeployItem_StoredContractByHash.h"
#import "ExecutableDeployItem_StoredContractByName.h"
#import "ExecutableDeployItem_StoredVersionedContractByHash.h"
#import "ExecutableDeployItem_StoredVersionedContractByName.h"
@implementation ExecutableDeployItem
+(ExecutableDeployItem*) fromJsonDictToExecutableDeployItem:(NSDictionary*) fromDict {
    NSLog(@"fromDict:%@",fromDict);
    ExecutableDeployItem * ret = [[ExecutableDeployItem alloc] init];
    ret.itsValue = [[NSMutableArray alloc] init];
    /*if(fromDict[@"ModuleBytes"] == nil) {
        NSLog(@"Not a module bytes");
    } else {
        NSLog(@"A module bytes");
    }*/
    if (!(fromDict[@"ModuleBytes"] == nil)) {
        NSLog(@"value:%@",fromDict[@"ModuleBytes"]);
        ret.itsType = @"ModuleBytes";
        ExecutableDeployItem_ModuleBytes * moduleBytes = [[ExecutableDeployItem_ModuleBytes alloc] init];
        moduleBytes = [ExecutableDeployItem_ModuleBytes fromJsonDictToObj:fromDict[@"ModuleBytes"]];
        [ret.itsValue addObject:moduleBytes];
    } else if (!(fromDict[@"StoredContractByHash"] == nil)) {
        ret.itsType = @"StoredContractByHash";
        ExecutableDeployItem_StoredContractByHash * s = [[ExecutableDeployItem_StoredContractByHash alloc] init];
        s = [ExecutableDeployItem_StoredContractByHash fromJsonDictToObj:fromDict[@"StoredContractByHash"]];
        [ret.itsValue addObject:s];
    } else if (!(fromDict[@"StoredContractByName"] == nil)) {
        ret.itsType = @"StoredContractByName";
        ExecutableDeployItem_StoredContractByName * scbn = [[ExecutableDeployItem_StoredContractByName alloc] init];
        [ret.itsValue addObject:scbn];
    } else if (!(fromDict[@"StoredVersionedContractByHash"] == nil)) {
        ret.itsType = @"StoredVersionedContractByHash";
        ExecutableDeployItem_StoredVersionedContractByHash * s = [[ExecutableDeployItem_StoredVersionedContractByHash alloc] init];
        [ret.itsValue addObject:s];
    } else if (!(fromDict[@"StoredVersionedContractByName"] == nil)) {
        ret.itsType = @"StoredVersionedContractByName";
        ExecutableDeployItem_StoredVersionedContractByName * s = [[ExecutableDeployItem_StoredVersionedContractByName alloc] init];
        [ret.itsValue addObject:s];
    } else if (!(fromDict[@"Transfer"] == nil)) {
        ret.itsType = @"Transfer";
        ExecutableDeployItem_Transfer * s = [[ExecutableDeployItem_Transfer alloc] init];
        [ret.itsValue addObject:s];
    }
    return ret;
}
-(void) logInfo {
    NSLog(@"ExecutableDeployItem, type:%@",self.itsType);
    if([self.itsType isEqual:@"ModuleBytes"]) {
        ExecutableDeployItem_ModuleBytes * moduleBytes = [[ExecutableDeployItem_ModuleBytes alloc] init];
        moduleBytes = (ExecutableDeployItem_ModuleBytes*)[self.itsValue firstObject];
        [moduleBytes logInfo];
    } else  if([self.itsType isEqual:@"StoredContractByHash"]) {
        ExecutableDeployItem_StoredContractByHash * s = [[ExecutableDeployItem_StoredContractByHash alloc] init];
        s = (ExecutableDeployItem_StoredContractByHash*)[self.itsValue firstObject];
        [s logInfo];
    }
}
@end
