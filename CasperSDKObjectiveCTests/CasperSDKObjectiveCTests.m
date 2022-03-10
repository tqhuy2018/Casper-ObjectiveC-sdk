#import <XCTest/XCTest.h>
#import "HttpHandler.h"
#import "GetStateRootHash.h"
#import "GetPeerList.h"
@interface CasperSDKObjectiveCTests : XCTestCase

@end

@implementation CasperSDKObjectiveCTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    HttpHandler * httpHandler = [[HttpHandler alloc]init];
    [httpHandler handleRequestWithParam:@"This is a test"];
}
- (void) testGetPeerList {
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"document open"];
    printf("Handler request started\n");
    NSString * casperURL =  @"https://node-clarity-testnet.make.services/rpc";
    //NSString *urlString1 = @"http://myurl.com/endpoint01/push_notifications";
   /* NSDictionary *jsonBodyDict = @{@"token":postDeviceID, @"type":@"ios"};
    NSData *jsonBodyData = [NSJSONSerialization dataWithJSONObject:jsonBodyDict options:kNilOptions error:nil];*/
    // watch out: error is nil here, but you never do that in production code. Do proper checks!
    NSString *jsonString = @"{\"params\" : [],\"id\" : 1,\"method\":\"info_get_peers\",\"jsonrpc\" : \"2.0\"}";
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.HTTPMethod = @"POST";
    [request setURL:[NSURL URLWithString:casperURL]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonData];

    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [requestExpectation fulfill];
        NSLog(@"Yay, done! Check for errors in response!");

        NSHTTPURLResponse *asHTTPResponse = (NSHTTPURLResponse *) response;
      
        NSDictionary *forJSONObject = [NSJSONSerialization JSONObjectWithData:data
                                                                                                        options:kNilOptions
                                                                                                                error:nil];
        
        GetPeerList * gpl = [[GetPeerList alloc] init];
        [gpl fromJsonToPeerList : forJSONObject];
        NSLog(@"One of these might exist - object: %@ \n ", forJSONObject);

    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
           // [session closeWithCompletionHandler:nil];
        }];
    printf("Handler request end");
}
- (void) testGetStateRootHash {
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"document open"];
    printf("Handler request started\n");
    NSString * casperURL =  @"https://node-clarity-testnet.make.services/rpc";
    //NSString *urlString1 = @"http://myurl.com/endpoint01/push_notifications";
   /* NSDictionary *jsonBodyDict = @{@"token":postDeviceID, @"type":@"ios"};
    NSData *jsonBodyData = [NSJSONSerialization dataWithJSONObject:jsonBodyDict options:kNilOptions error:nil];*/
    // watch out: error is nil here, but you never do that in production code. Do proper checks!
    NSString *jsonString = @"{\"params\" : [],\"id\" : 1,\"method\":\"chain_get_state_root_hash\",\"jsonrpc\" : \"2.0\"}";
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.HTTPMethod = @"POST";
    [request setURL:[NSURL URLWithString:casperURL]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonData];

    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [requestExpectation fulfill];
        NSLog(@"Yay, done! Check for errors in response!");

        NSHTTPURLResponse *asHTTPResponse = (NSHTTPURLResponse *) response;
     
        NSDictionary *forJSONObject = [NSJSONSerialization JSONObjectWithData:data
                                                                                                        options:kNilOptions
                                                                                                                error:nil];
                                                // or
        NSArray *forJSONArray = [NSJSONSerialization JSONObjectWithData:data
                                                                                                        options:kNilOptions
                                                                                                          error:nil];
        GetStateRootHash * gsrh = [[GetStateRootHash alloc] init];
        [gsrh fromJsonToStateRootHash: forJSONObject ];
        NSLog(@"One of these might exist - object: %@ \n array: %@", forJSONObject, forJSONArray);

    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
           // [session closeWithCompletionHandler:nil];
        }];
    printf("Handler request end");
}

@end
