## Usage how to

The Casper ObjectiveC SDK can be used from Project or Package writen in ObjectiveC.

### 1. Import and using Casper ObjectiveC SDK from ObjectiveC project 

Please refer to this address for a sample of 1 ObjectiveC project that calls the Casper ObjectiveC SDK.

https://github.com/hienbui9999/SampleCallToCasperObjectiveCSDK

In this project, some RPC calls are written: "chain_get_state_root_hash", "info_get_peers" and "account_put_deploy" and the code is done within "ViewController.m" file.

If you want to make a project manualy, please follow this step:

In Xcode create a new App project.

<img width="1440" alt="Screen Shot 2022-05-30 at 06 55 42" src="https://user-images.githubusercontent.com/94465107/170896777-a7662b7f-9c80-4bd2-9494-a1d9193cd0f0.png">

Choose the name and language based for the project (Of course please choose ObjectiveC as the Language)

<img width="1440" alt="Screen Shot 2022-05-30 at 06 56 39" src="https://user-images.githubusercontent.com/94465107/170896812-e54755b6-24cf-4075-9635-c317ddae7e8a.png">

When the project is opened, Add the "Casper ObjectiveC SDK" by doing this: Click on the project name and click "Package Dependencies" as the image below

<img width="1440" alt="Screen Shot 2022-05-30 at 06 59 54" src="https://user-images.githubusercontent.com/94465107/170896892-42c76bb8-e27b-4f84-86ec-9169a43c83de.png">

Hit the "+" button under the "Add packages here" region. A new window will appear.

<img width="1440" alt="Screen Shot 2022-05-30 at 07 05 53" src="https://user-images.githubusercontent.com/94465107/170896987-40f6799e-b9be-4473-8b21-5290d9126511.png">

In the left panel choose "GitHub" and in the right panel at the top enter the Casper ObjectiveC SDK on Github with this link: "https://github.com/tqhuy2018/Casper-ObjectiveC-sdk.git"

Press "Add Package" button in the bottom left region of the right panel. A new window will appear to ask you select for the library of Casper ObjectiveC SDK. Tick all the check box to load all the library if you wish to use all the function of the SDK.
If you wish to use some functions only, such as Get Block RPC, just check for "CasperSDKObjectiveC", "CasperSDKObjectiveC_CommonClasses" and "CasperSDKObjectiveC_GetBlock".Then hit the "Add Package" button.

<img width="1440" alt="Screen Shot 2022-05-30 at 07 06 34" src="https://user-images.githubusercontent.com/94465107/170897157-10aafc58-f143-4587-b051-5109ce85a621.png">

Now you can see the package is successfuly loaded into the project by looking at the "Casper-ObjectiveC-sdk" line shown in the "Package Dependencies" tab, and in the left panel you can see list of imported package for the project (ASN1, BigInt, Blake2, CasperCryptoHandlePackage, CasperSDKObjectiveC, SwiftECC)

<img width="1440" alt="Screen Shot 2022-05-30 at 07 12 06" src="https://user-images.githubusercontent.com/94465107/170897308-58e7ac62-d041-4882-a239-1d220f2adc84.png">

You are now ready to call Casper ObjectiveC SDK classes and functions.

### A sample code for calling 1 RPC method in detail

Continue with the project that you have created just above.

Note: For simplicity, all the code is done within "ViewController.m" file. The result is written in the log region, no visial interface is built. This document is just a simple guide for how to import/use the SDK in 1 code file.

For example if you want to call "chain_get_block_transfers" RPC. Follow this steps:

- Click the "ViewController.m" file in the left panel.
Add the following import lines:

 ```ObjectiveC
@import CasperSDKObjectiveC_CommonClasses;
@import CasperSDKObjectiveC_GetBlockTransfers;
```

Then you can call the "chain_get_block_transfers" RPC method by this code

 ```ObjectiveC
GetBlockTransfersRPC * getRPC = [[GetBlockTransfersRPC alloc] init];
[getRPC initializeWithRPCURL:URL_TEST_NET];
BlockIdentifier * bi = [[BlockIdentifier alloc] init];
bi.blockType = USE_BLOCK_HASH;
[bi assignBlockHashWithParam:@"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"];
NSString * jsonString = [bi toJsonStringWithMethodName:@"chain_get_block_transfers"];
NSString * callID = @"getBlockTransfer1";
[getRPC getBlockTransfersWithJsonParam2:jsonString andCallID:callID];
 ```
 Since the POST request is asynchronous, the result will take some time to get the result. In this application a timer (NSTimer) is set to get the result when it is ready and just log it to the log screen. There is a max time of 50 seconds for waiting for the result back, defined in variable "maxCounter". It's just 1 simple way to get the result. You can implement the way to get the result back depends on how you like to handle the result (For example print it to a label or display in some region in the device screen).
 The full code for the ViewController.m file is:
 
 ```ObjectiveC
#import "ViewController.h"
@import CasperSDKObjectiveC_CommonClasses;
@import CasperSDKObjectiveC_GetBlockTransfers;

@interface ViewController ()

@end

@implementation ViewController

int counterGetBlockTransfers = 0;
int maxCounter = 50;

-(void)onTick:(NSTimer *)timer {
    GetBlockTransfersRPC * item = [[timer userInfo] objectForKey:@"param1"];
    NSString * callID = [[timer userInfo] objectForKey:@"param2"];
    if([item.rpcCallGotResult[callID] isEqualToString:RPC_VALUE_NOT_SET]) {
    } else if([item.rpcCallGotResult[callID] isEqualToString:RPC_VALUE_ERROR_OBJECT]) {
        [timer invalidate];
        timer = nil;
    } else if([item.rpcCallGotResult[callID] isEqualToString:RPC_VALUE_ERROR_NETWORK]) {
        NSLog(@"Get block transfers with network error");
        [timer invalidate];
        timer = nil;
    } else if([item.rpcCallGotResult[callID] isEqualToString:RPC_VALID_RESULT]) {
        GetBlockTransfersResult * result = [[GetBlockTransfersResult alloc] init];
        result = item.valueDict[callID];
        NSLog(@"Get result of block transfers, block hash is:%@",result.block_hash);
        [timer invalidate];
        timer = nil;
    } else {
        NSLog(@"None value above, counter:%d and value:%@",counterGetBlockTransfers,item.rpcCallGotResult[callID]);
    }
    counterGetBlockTransfers ++;
    if(counterGetBlockTransfers == maxCounter) {
        [timer invalidate];
        timer = nil;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    GetBlockTransfersRPC * getRPC = [[GetBlockTransfersRPC alloc] init];
    [getRPC initializeWithRPCURL:URL_TEST_NET];
    BlockIdentifier * bi = [[BlockIdentifier alloc] init];
    bi.blockType = USE_BLOCK_HASH;
    [bi assignBlockHashWithParam:@"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"];
    NSString * jsonString = [bi toJsonStringWithMethodName:@"chain_get_block_transfers"];
    NSString * callID = @"getBlockTransfer1";
    [getRPC getBlockTransfersWithJsonParam2:jsonString andCallID:callID];
    NSTimer * t = [NSTimer scheduledTimerWithTimeInterval: 1.0
                          target: self
                          selector:@selector(onTick:)
                                                 userInfo: @{@"param1":getRPC,@"param2":callID} repeats:YES];
}
@end
 ```
 
 To run the project, choose "Product->Run" and you will see the result in the Debug area, as shown in this image 
 
 <img width="1440" alt="Screen Shot 2022-05-30 at 22 25 50" src="https://user-images.githubusercontent.com/94465107/171023432-5b1128fb-1dc3-4390-bb08-d871107a9971.png">

 You can see in the Debug area the block_hash is printed out in the center bottom region of the image.
 
 If you can not see the Debug area, Choose "View->Debug Area->Show Debug Area" as shown in this image.
 
 <img width="1440" alt="Screen Shot 2022-05-30 at 22 27 44" src="https://user-images.githubusercontent.com/94465107/171023586-1383debb-6b77-40e1-9543-579ab24c0688.png">

This is to show that this project can call the RPC successfully.

You can download and test the full project for this sample is in this address: https://github.com/hienbui9999/SampleCasperCallObjectiveC
 
### 2. Import and using Casper ObjectiveC SDK from ObjectiveC package

In brief, this manual intend to do 2 things:

 Create 1 ObjectiveC Package that use "Casper ObjectiveC SDK" class and functions, sample code can be found at this address:
 
 https://github.com/hienbui9999/ObjectiveCPackageCallCasperSDK
 
 Create 1 ObjectiveC Project that call to that ObjectiveC Package above, sample code can be found at this address:
 
 https://github.com/hienbui9999/SampleCallToObjectiveCPackage2

Here is the detail of the work:

## I. Create a new ObjectiveC Package by doing these steps:

1. Open Xcode and choose "Create a new Xcode project" as shown in this image:

<img width="496" alt="Screen Shot 2022-06-03 at 10 25 01" src="https://user-images.githubusercontent.com/94465107/171780436-ff269a43-4c9c-42de-8db8-24aec803f6f8.png">


2. Choose "iOS->Framework" then click "Next" as shown in this image

<img width="1440" alt="Screen Shot 2022-06-03 at 10 26 53" src="https://user-images.githubusercontent.com/94465107/171780567-b653c17b-5d24-4787-a489-669ee268c13e.png">


3. Choose a name for the package, for example "PackageToCallCasperObjectiveCSDK". Make sure "Language" is "Objective-C", then click "Next", as shown in this image:

<img width="735" alt="Screen Shot 2022-05-31 at 07 30 13" src="https://user-images.githubusercontent.com/94465107/171071324-15f11ff1-b323-4d27-8c32-93d5d0a53e5c.png">

4. Choose a folder for the Package project to save, click "Create", as shown in this image

<img width="799" alt="Screen Shot 2022-05-31 at 07 30 59" src="https://user-images.githubusercontent.com/94465107/171071366-137902f8-caca-4a03-bb1a-81b95e902923.png">

5. Create the "Package.swift" file to make this package an ObjectiveC libary

Right click the project name, Choose "New file..."

<img width="1440" alt="Screen Shot 2022-06-03 at 10 52 54" src="https://user-images.githubusercontent.com/94465107/171782886-6e055996-9f21-4e09-9948-6b15dbcd0cf5.png">

Choose "Swift file" then click "Next" button

<img width="1440" alt="Screen Shot 2022-06-03 at 10 53 03" src="https://user-images.githubusercontent.com/94465107/171782980-d63d6c79-83ee-4ea8-b15a-d0d589771ce7.png">

Enter "Package" as name for the new file, tick all the checkbox for Target.

<img width="1440" alt="Screen Shot 2022-06-03 at 10 55 27" src="https://user-images.githubusercontent.com/94465107/171783034-cc680845-a8d2-4f6c-be5d-18350bf31652.png">

Then select "Create Bridging Header"

<img width="1440" alt="Screen Shot 2022-06-03 at 10 56 47" src="https://user-images.githubusercontent.com/94465107/171783158-ad55d741-a521-47df-8e42-3bbb62ef388f.png">

Copy the following content to the newly created "Package.swift" file

 ```ObjectiveC
// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "SamplePackageToCallCasperSDKObjectiveC",
    platforms: [
        .iOS(.v13), .tvOS(.v12), .watchOS(.v5), .macOS(.v10_15)
        ],
    products: [
        .library(
            name: "LibAll",
            targets: ["LibCoreTarget", "LibFullTarget"]
        ),
        .library(
            name: "LibCore",
            targets: ["LibCoreTarget"]
        ),
        .library(
            name: "LibFull",
            targets: ["LibFullTarget"]
        )
    ],
    dependencies: [
        .package(name: "CasperSDKObjectiveC", url: "https://github.com/tqhuy2018/Casper-ObjectiveC-sdk.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "LibCoreTarget",
            dependencies: ["CasperSDKObjectiveC"],
            path: "Sources/Core",
            publicHeadersPath: "Public"
        ),
        .target(
            name: "LibFullTarget",
            dependencies: ["LibCoreTarget"],
            path: "Sources/Full",
            publicHeadersPath: "Public"
        )
       
    ]
)
 ```

In the Project Navigator of the left panel click the Package name, Under Project click the Package name again, select tab "Package Dependencies" and click the "+" button, as shown in the image below.
<img width="1440" alt="Screen Shot 2022-05-31 at 07 34 55" src="https://user-images.githubusercontent.com/94465107/171071800-051cbd08-7a06-43b2-b6ae-e54ae049788e.png">

11. A new window will appear to let you select the "Casper ObjectiveC SDK"
In the left panel select "GitHub", in the top right of the window you will see a text box with prompt text "Search or Enter Package URL", as shown in this image 
<img width="1084" alt="Screen Shot 2022-05-31 at 07 56 53" src="https://user-images.githubusercontent.com/94465107/171073027-f0c92390-0e0a-4fc4-8700-cd4403e350ea.png">
Enter the link for the "Casper ObjectiveC SDK" with this value: "https://github.com/tqhuy2018/Casper-ObjectiveC-sdk.git", as shown in this image
<img width="1080" alt="Screen Shot 2022-05-31 at 08 00 02" src="https://user-images.githubusercontent.com/94465107/171073107-66a2da0b-77ba-4b8c-a614-4448addf7bc4.png">
Then click "Add Package" button.
There will be process of loading the SDK, somehow like in this image
<img width="1086" alt="Screen Shot 2022-05-31 at 08 00 50" src="https://user-images.githubusercontent.com/94465107/171073178-8059a626-1260-4007-85ff-3b07bc45af4a.png">
Then when the process of loading the SDK is ready, you will see the selection for the SDK library. 
Check all the checkbox if you wish to use all the SDK function, or if you need to use the "info_get_deploy" RPC, simply just choose the following checkbox: "CasperSDKObjectiveC", "CasperSDKObjectiveC_CommonClasses","CasperSDKObjectiveC_GetDeploy".

<img width="1440" alt="Screen Shot 2022-05-31 at 08 02 22" src="https://user-images.githubusercontent.com/94465107/171073383-7789985b-f13b-45f1-a986-86c16bd12776.png">

Click "Add Package" button.

Wait for a while, you will see the package fully loaded in the "Package Dependencies" section, as shown in this image

<img width="376" alt="Screen Shot 2022-05-31 at 08 17 01" src="https://user-images.githubusercontent.com/94465107/171074307-27de2f0d-fe10-4cd0-a0af-acb7f56b55da.png">

13. Create a class, for example "SampleClass1.h" and "SampleClass1.m"
For example this class is for calling get_deploy RPC call, then add the following import to the file
 
 ```ObjectiveC
@import CasperSDKObjectiveC_CommonClasses;
@import CasperSDKObjectiveC_GetDeploy;
 ```
 
 The content of the "SampleClass1.h" file would be somehow like this:
 
```ObjectiveC
#ifndef SampleClass1_h
#define SampleClass1_h
#import <Foundation/Foundation.h>
//sample call to info_get_deploy
@interface SampleClass1:NSObject
-(void) getDeployWithDeployHash:(NSString*) deployHash andCallID:(NSString*) callID;
@end
#endif
 ```
 
The content of the "SampleClass1.m" file would be somehow like this:

```ObjectiveC
#import <Foundation/Foundation.h>
#import "SampleClass1.h"
@import CasperSDKObjectiveC_CommonClasses;
@import CasperSDKObjectiveC_GetDeploy;
@implementation SampleClass1
int counterGetDeploy = 0;
int maxCounter = 50;
-(void)onTickGetDeploy:(NSTimer *)timer {
    GetDeployRPC * item = [[timer userInfo] objectForKey:@"param1"];
    NSString * callID = [[timer userInfo] objectForKey:@"param2"];
    if([item.rpcCallGotResult[callID] isEqualToString:RPC_VALUE_NOT_SET]) {
    } else if([item.rpcCallGotResult[callID] isEqualToString:RPC_VALUE_ERROR_OBJECT]) {
        NSLog(@"Get deploy with parse error");
        [timer invalidate];
        timer = nil;
    } else if([item.rpcCallGotResult[callID] isEqualToString:RPC_VALUE_ERROR_NETWORK]) {
        NSLog(@"Get deploy with network error");
        [timer invalidate];
        timer = nil;
    } else if([item.rpcCallGotResult[callID] isEqualToString:RPC_VALID_RESULT]){
        GetDeployResult * getDeployResult = item.valueDict[callID];
        
        [timer invalidate];
        timer = nil;
    }
    counterGetDeploy ++;
    if(counterGetDeploy == maxCounter) {
        [timer invalidate];
        timer = nil;
    }
}
-(void) getDeployWithDeployHash:(NSString*) deployHash andCallID:(NSString *)callID {
    GetDeployRPC * getDeployRPC = [[GetDeployRPC alloc] init];
    GetDeployParams * param = [[GetDeployParams alloc] init];
    param.deploy_hash = deployHash;
    NSString * jsonString = [param generatePostParam];
    [getDeployRPC getDeployWithJsonParam2:jsonString andCallID:callID];
    NSString * callGetDeployID = @"getDeploy1";
    NSTimer * tGetDeploy = [NSTimer scheduledTimerWithTimeInterval: 1.0
                          target: self
                          selector:@selector(onTickGetDeploy:)
                                                 userInfo: @{@"param1":getDeployRPC,@"param2":callGetDeployID} repeats:YES];
}
@end

 ```
 
 This file does the task of calling "info_get_deploy" RPC from the Casper ObjectiveC SDK, which can be build without error.
 
 One sample of ObjectiveC Package that call function GetStateRootHash is at this address:
 
 https://github.com/hienbui9999/ObjectiveCPackageCallCasperSDK
 
 And a sample ObjectiveC that use that Package can be found at this address:
 
 https://github.com/hienbui9999/SampleCallToObjectiveCPackage2
