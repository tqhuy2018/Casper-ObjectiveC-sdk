#import <Foundation/Foundation.h>
#import "HttpHandler.h"
@implementation HttpHandler
-(void) handleRequestWithParam:(NSString*) params {
    printf("Handler request started\n");
    self.casperURL =  @"https://node-clarity-testnet.make.services/rpc";
    NSString *jsonString = @"{\"params\" : \"[]\",\"id\" : 1,\"method\":\"chain_get_state_root_hash\",\"jsonrpc\" : \"2.0\"}";
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    
    request.HTTPMethod = @"POST";
    [request setURL:[NSURL URLWithString:self.casperURL]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonData];

    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Yay, done! Check for errors in response!");

        NSHTTPURLResponse *asHTTPResponse = (NSHTTPURLResponse *) response;
        NSLog(@"The response is: %@", asHTTPResponse);
        NSDictionary *forJSONObject = [NSJSONSerialization JSONObjectWithData:data
                                                                                                        options:kNilOptions
                                                                                                                error:nil];
                                                
        NSArray *forJSONArray = [NSJSONSerialization JSONObjectWithData:data
                                                                                                        options:kNilOptions
                                                                                                          error:nil];

        NSLog(@"One of these might exist - object: %@ \n array: %@", forJSONObject, forJSONArray);
    }];
    [task resume];
    printf("Handler request end");
}
@end
