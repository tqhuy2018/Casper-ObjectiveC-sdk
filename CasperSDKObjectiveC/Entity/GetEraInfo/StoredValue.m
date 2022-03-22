#import <Foundation/Foundation.h>
#import "StoredValue.h"
#import "EraInfo.h"
#import "CLValue.h"
#import "ConstValues.h"
#import "Account.h"
#import "ContractPackage.h"
#import "Transfer.h"
#import "DeployInfo.h"
#import "Bid.h"
#import "Transform_WriteWithdraw.h"
#import "Contract.h"
@implementation StoredValue

+(StoredValue *) fromJsonDictToStoredValue:(NSDictionary*) fromDict{
    StoredValue * ret = [[StoredValue alloc] init];
    if(!(fromDict[@"EraInfo"] == nil)) {
        ret.itsType = @"EraInfo";
        EraInfo * era = [[EraInfo alloc] init];
        NSDictionary * SADict = (NSDictionary*) fromDict[@"EraInfo"];
        NSArray * listSA = (NSArray*) SADict[@"seigniorage_allocations"];
        era = [EraInfo fromJsonArrayToEraInfo:listSA];
        ret.innerValue = [[NSMutableArray alloc] init];
        [ret.innerValue addObject:era];
    } else if(!(fromDict[@"CLValue"] == nil)) {
        ret.itsType = @"CLValue";
        CLValue * clValue = [[CLValue alloc] init];
        clValue = [CLValue fromJsonDictToCLValue:fromDict[@"CLValue"]];
        ret.innerValue = [[NSMutableArray alloc] init];
        [ret.innerValue addObject:clValue];
    } else if(!(fromDict[@"Account"] == nil)) {
        ret.itsType = @"Account";
        Account * oneAccount = [[Account alloc] init];
        oneAccount = [Account fromJsonDictToAccount:fromDict[@"Account"]];
        ret.innerValue = [[NSMutableArray alloc] init];
        [ret.innerValue addObject:oneAccount];
    } else if(!(fromDict[@"ContractWasm"] == nil)) {
        ret.itsType = @"ContractWasm";
        ret.innerValue = [[NSMutableArray alloc] init];
        [ret.innerValue addObject:(NSString*) fromDict[@"ContractWasm"]];
    } else if(!(fromDict[@"ContractPackage"] == nil)) {
        ret.itsType = @"ContractPackage";
        ret.innerValue = [[NSMutableArray alloc]init];
        ContractPackage * oneCP = [[ContractPackage alloc] init];
        oneCP = [ContractPackage fromJsonDictToContractPackage:(NSDictionary *)fromDict[@"ContractPackage"]];
        [ret.innerValue addObject:oneCP];
    } else if(!(fromDict[@"Transfer"] == nil)) {
        ret.itsType = @"Transfer";
        ret.innerValue = [[NSMutableArray alloc] init];
        Transfer * oneTransfer = [[Transfer alloc] init];
        oneTransfer = [Transfer fromJsonDictToTransfer:fromDict[@"Transfer"]];
        [ret.innerValue addObject:oneTransfer];
    } else if(!(fromDict[@"DeployInfo"] == nil)) {
        ret.itsType = @"DeployInfo";
        ret.innerValue = [[NSMutableArray alloc] init];
        DeployInfo * oneDI = [[DeployInfo alloc] init];
        oneDI = [DeployInfo fromJsonDictToDeployInfo:fromDict[@"DeployInfo"]];
        [ret.innerValue addObject:oneDI];
    } else if(!(fromDict[@"Bid"] == nil)) {
        ret.itsType = @"Bid";
        ret.innerValue = [[NSMutableArray alloc] init];
        Bid * item = [[Bid alloc] init];
        item = [Bid fromJsonDictToBid:fromDict[@"Bid"]];
        [ret.innerValue addObject:item];
    } else if(!(fromDict[@"Withdraw"] == nil)) {
        ret.itsType = @"Withdraw";
        ret.innerValue = [[NSMutableArray alloc] init];
        Transform_WriteWithdraw * item = [[Transform_WriteWithdraw alloc] init];
        item = [Transform_WriteWithdraw fromJsonArrayToTransform_WriteWithdraw:(NSArray *)fromDict[@"Withdraw"]];
        [ret.innerValue addObject:item];
    }else if(!(fromDict[@"Contract"] == nil)) {
        ret.itsType = @"Contract";
        ret.innerValue = [[NSMutableArray alloc] init];
        Contract * item = [[Contract alloc] init];
        item = [Contract fromJsonDictToContact:(NSDictionary *)fromDict[@"Contract"]];
        [ret.innerValue addObject:item];
    }
    return ret;
}

-(void) logInfo {
    NSLog(@"StoredValue log info, type:%@",self.itsType);
    if ([self.itsType isEqualToString: @"EraInfo"]) {
        EraInfo * era = (EraInfo*)[self.innerValue objectAtIndex:0];
        [era logInfo];
    } else if ([self.itsType isEqualToString: @"CLValue"]) {
        CLValue * clValue = [[CLValue alloc] init];
        clValue = (CLValue*) [self.innerValue objectAtIndex:0];
        [clValue logInfo];
    }  else if ([self.itsType isEqualToString: @"Account"]) {
        Account * item = [[Account alloc] init];
        item = (Account*) [self.innerValue objectAtIndex:0];
        [item logInfo];
    }  else if ([self.itsType isEqualToString: @"ContractWasm"]) {
        NSLog(@"StoredValue of ContractWasm, value: %@",[self.innerValue objectAtIndex:0]);
    } else if ([self.itsType isEqualToString: @"ContractPackage"]) {
        ContractPackage * item = [[ContractPackage alloc] init];
        item = (ContractPackage*) [self.innerValue objectAtIndex:0];
        [item logInfo];
    } else if ([self.itsType isEqualToString: @"Transfer"]) {
        Transfer * item = [[Transfer alloc] init];
        item = (Transfer*) [self.innerValue objectAtIndex:0];
        [item logInfo];
    } else if ([self.itsType isEqualToString: @"DeployInfo"]) {
        DeployInfo * item = [[DeployInfo alloc] init];
        item = (DeployInfo*) [self.innerValue objectAtIndex:0];
        [item logInfo];
    } else if ([self.itsType isEqualToString: @"Bid"]) {
        Bid * item = [[Bid alloc] init];
        item = (Bid*) [self.innerValue objectAtIndex:0];
        [item logInfo];
    } else if ([self.itsType isEqualToString: @"Withdraw"]) {
        Transform_WriteWithdraw * item = [[Transform_WriteWithdraw alloc] init];
        item = (Transform_WriteWithdraw*) [self.innerValue objectAtIndex:0];
        [item logInfo];
    } else if ([self.itsType isEqualToString: @"Contract"]) {
        Contract * item = [[Contract alloc] init];
        item = (Contract*) [self.innerValue objectAtIndex:0];
        [item logInfo];
    }
}

@end
