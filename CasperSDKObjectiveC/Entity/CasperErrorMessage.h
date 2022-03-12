
#ifndef CasperErrorMessage_h
#define CasperErrorMessage_h
@interface CasperErrorMessage:NSObject
@property NSString * code;
@property NSString * data;
@property NSString * message;
-(void) setupWithCode:(NSString*) eCode andData:(NSString*) eData andMessage:(NSString*) eMessage;
-(void) fromJsonToErrorObject:(NSDictionary*) jsonDictionary;
@end

#endif
