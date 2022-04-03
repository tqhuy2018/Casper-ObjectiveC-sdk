#import <Foundation/Foundation.h>
#import "JsonProof.h"
/**Class built for storing JsonProof information
 */
@implementation JsonProof
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to JsonProof object
 */
+(JsonProof*) fromJsonDictToJsonProof:(NSDictionary*) jsonDict {
    JsonProof * ret = [[JsonProof alloc] init];
    ret.signature = jsonDict[@"signature"];
    ret.public_key = jsonDict[@"public_key"];
    return ret;
}
/**This function parse the Array object (as part of the JSON object taken from server RPC method call) to get JsonProof list
 */
+(NSMutableArray*) fromJsonDictToJsonProofList:(NSArray*) jsonArray {
    NSMutableArray * ret = [[NSMutableArray alloc] init];
    for (id obj in jsonArray) {
        JsonProof * oneProof = [JsonProof fromJsonDictToJsonProof:(NSDictionary*) obj];
        [ret addObject:oneProof];
    }
    return ret;
}
@end
