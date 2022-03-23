#import <Foundation/Foundation.h>
#import "CasperErrorMessage.h"
#import "ConstValues.h"
@implementation CasperErrorMessage
-(void) setupWithCode:(NSString*) eCode andData:(NSString*) eData andMessage:(NSString*) eMessage {
    self.code = eCode;
    self.data = eData;
    self.message = eMessage;
}
-(void) fromJsonToErrorObject:(NSDictionary*) jsonDictionary {
    self.message = CASPER_ERROR_MESSAGE_NONE;
    NSDictionary * errorJson = [jsonDictionary objectForKey:@"error"];
    if(errorJson) {
        self.code = [errorJson objectForKey:@"code"];
        self.data = [errorJson objectForKey:@"data"];
        self.message = [errorJson objectForKey:@"message"];
    } else {
        
    }
}
@end
