#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/GetPeerRPC.h>
#import <CasperSDKObjectiveC/ConstValues.h>
#import <CasperSDKObjectiveC/GetPeerResult.h>
#import <CasperSDKObjectiveC/PeerEntry.h>
@implementation GetPeerRPC
-(void) initializeWithRPCURL:(NSString*) url{
    self.casperURL = url;
    self.valueDict = [[NSMutableDictionary alloc] init];
    self.rpcCallGotResult = [[NSMutableDictionary alloc] init];
}
-(void) getPeerResultWithJsonParam:(NSString*) jsonString {
    if(self.casperURL) {
        NSLog(@"Get Peer url null");
    } else {
        self.casperURL = URL_TEST_NET;
    }
    NSLog(@"URL FOR GET PEER:%@",self.casperURL);
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
        NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSDictionary * forJSONObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            CasperErrorMessage * cem = [[CasperErrorMessage alloc] init];
            [cem fromJsonToErrorObject:forJSONObject];
            //Check if result back is not error, then parse the JSON back to get corresponding object based on the RPC method all
            if(cem.message == CASPER_ERROR_MESSAGE_NONE) {
               // NSLog(@"GOT RESULT OF GET PEER, :%@",forJSONObject);
                self.rpcCallGotResult[self.callID] = RPC_VALID_RESULT;
                 GetPeerResult * gpr =  [GetPeerResult fromJsonObjToGetPeerResult:forJSONObject];
                self.valueDict[self.callID] = gpr;
                
                NSInteger totalPeer = [gpr.PeersMap count];
                NSInteger  counter = 1;
                NSLog(@"List 10 first peer for call ID:%@",self.callID);
                for (int i = 0 ; i < 10;i ++) {
                    PeerEntry * pe = [[PeerEntry alloc] init];
                    pe = [gpr.PeersMap objectAtIndex:i];
                    NSLog(@"Peer number %lu address:%@ and node id:%@",counter,pe.address,pe.nodeID);
                }
                
            } else {
                NSLog(@"Error caught with error message:%@ and error code:%@",cem.message,cem.code);
                self.rpcCallGotResult[self.callID] = RPC_VALUE_ERROR_OBJECT;
            }
        } else {
            NSLog(@"Error http request");
            self.rpcCallGotResult[self.callID] = RPC_VALUE_ERROR_NETWORK;
        }
       }];
    [task resume];
}
-(void) getPeerResultWithJsonParam2:(NSString*) jsonString andCallID:(NSString*) callID {
    self.rpcCallGotResult[callID] = RPC_VALUE_NOT_SET;
    if(self.casperURL) {
        NSLog(@"Get peer with url:%@",self.casperURL);
    } else {
        self.casperURL = URL_TEST_NET;
    }
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
        NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSDictionary * forJSONObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            CasperErrorMessage * cem = [[CasperErrorMessage alloc] init];
            [cem fromJsonToErrorObject:forJSONObject];
            //Check if result back is not error, then parse the JSON back to get corresponding object based on the RPC method all
            if(cem.message == CASPER_ERROR_MESSAGE_NONE) {
                NSLog(@"GOT RESULT OF GET PEER, :%@",forJSONObject);
                GetPeerResult * gpr =  [GetPeerResult fromJsonObjToGetPeerResult:forJSONObject];
                self.valueDict[callID] = gpr;
                self.rpcCallGotResult[callID] = RPC_VALID_RESULT;
            } else {
                NSLog(@"GOt error get peer");
                self.rpcCallGotResult[callID] = RPC_VALUE_ERROR_OBJECT;
            }
        } else {
            NSLog(@"GOt error network get peer");
            self.rpcCallGotResult[callID] = RPC_VALUE_ERROR_NETWORK;
        }
       }];
    [task resume];
}
@end
