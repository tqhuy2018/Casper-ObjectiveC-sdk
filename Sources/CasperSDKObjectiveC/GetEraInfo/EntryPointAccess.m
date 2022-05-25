#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/EntryPointAccess.h>
#import <CasperSDKObjectiveC/Groups.h>
/**Class built for storing EntryPointAccess information
 */
@implementation EntryPointAccess
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to EntryPointAccess object
 */
+(EntryPointAccess*) fromJsonDictToEntryPointAccess:(NSDictionary*) fromDict {
    EntryPointAccess * ret = [[EntryPointAccess alloc] init];
    //check if type is Public
    if(!(fromDict[@"Public"] == nil)) {
        ret.is_type_public = true;
    } else { //else type is of Groups - list of Group
        ret.is_type_public = false;
        NSArray * listGroup = (NSArray*) fromDict[@"Groups"];
        int totalGroup = (int) listGroup.count;
        if(totalGroup>0) {
            ret.Groups = [[NSMutableArray alloc] init];
            for(int i = 0; i < totalGroup;i++) {
                NSString * oneGroupStr = (NSString*) [listGroup objectAtIndex:i];
                [ret.Groups addObject:oneGroupStr];
            }
        }
    }
    return ret;
}
-(void) logInfo {
    if (self.is_type_public) {
        NSLog(@"EntryPointAccess is of type Public");
    } else {
        NSLog(@"EntryPointAccess, of type Groups");
        int totalGroup = (int)self.Groups.count;
        NSLog(@"EntryPointAccess, total Group:%i",totalGroup);
        if(totalGroup >0) {
            for(int i = 0 ; i < totalGroup ; i ++) {
                NSLog(@"EntryPointAccess, group number %i, value:%@",i,(NSString*) [self.Groups objectAtIndex:i ]);
            }
        }
    }
}
@end
