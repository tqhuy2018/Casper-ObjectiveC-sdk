#import <Foundation/Foundation.h>
#import "Contract.h"
#import "EntryPoint.h"
@implementation Contract
+(Contract*) fromJsonDictToContact:(NSDictionary*) fromDict {
    Contract * ret = [[Contract alloc] init];
    return ret;
}
-(void)logInfo {
    NSLog(@"Contract, contract_package_hash:%@",self.contract_package_hash);
    NSLog(@"Contract, contract_wasm_hash:%@",self.contract_wasm_hash);
    NSLog(@"Contract, protocol_version:%@",self.protocol_version);
    int totalEP = (int)self.entry_points.count;
    NSLog(@"Contract, total EntryPoint:%i",totalEP);
    if(totalEP >0) {
        for(int i = 0; i < totalEP ;i ++) {
            NSLog(@"Contract, EntryPoint number %i information",i);
            EntryPoint * ep = (EntryPoint*) [self.entry_points objectAtIndex:i];
            [ep logInfo];
        }
    }
}
@end
