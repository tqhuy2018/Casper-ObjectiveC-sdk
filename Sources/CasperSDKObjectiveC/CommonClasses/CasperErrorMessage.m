#import <Foundation/Foundation.h>
#import "CasperSDKObjectiveC/CasperErrorMessage.h"
#import "CasperSDKObjectiveC/ConstValues.h"
/**
 This class hold information of error that could be thrown from the server when call the RPC method
 Each error hold the information of error code, error data and error message
 This class is used in HttpHandler class when parse the JSON back from the server as result from RPC call.
 If the error is caught, then just throw the error.
 If no error is caught, then the JSON will be parsed to correspoding result, such as state_root_hash or peer list or deploy ...
 */
@implementation CasperErrorMessage

///This function build up the CasperErrorMessage object with given data of error code, error data, error message
-(void) setupWithCode:(NSString*) eCode andData:(NSString*) eData andMessage:(NSString*) eMessage {
    self.code = eCode;
    self.data = eData;
    self.message = eMessage;
}

///This function build up the CasperErrorMessage object from the JSON data taken back from server when call for an RPC method
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
