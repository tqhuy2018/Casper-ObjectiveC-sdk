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
You will see some errors appear, but it is not a problem

<img width="1440" alt="Screen Shot 2022-06-03 at 11 03 01" src="https://user-images.githubusercontent.com/94465107/171783753-0ffda327-1793-4a4e-a289-19658af0af7d.png">

You need to change the structure of the files in the Package to make it a real ObjectiveC library.

First change the name of the folder "PackageToCallCasperObjectiveCSDK" to "Sources" as shown in this image:

<img width="1440" alt="Screen Shot 2022-06-03 at 11 10 14" src="https://user-images.githubusercontent.com/94465107/171784838-eee1d19e-2c01-44c8-a4ed-61c5b3d9cc4e.png">

Under the folder "Sources" create 1 folder with name "Core" by doing the 2 steps below.

Step 1: Right click on "Sources" folder and choose "New Group"

<img width="1440" alt="Screen Shot 2022-06-03 at 11 12 50" src="https://user-images.githubusercontent.com/94465107/171784896-0b55b7e1-2e23-4cfd-976f-fad79a9e0b23.png">

A new folder appears under "Sources" folder, rename it to "Core"

<img width="1440" alt="Screen Shot 2022-06-03 at 11 13 05" src="https://user-images.githubusercontent.com/94465107/171784938-f4399483-74f8-473f-89c8-463a53892493.png">
Continue to create 1 more folder with name "Public" under "Core" and 1 more folder with name "SamplePackageToCallCasperSDKObjectiveC" under "Public" folder.
Some how the structure will be like this:

<img width="1440" alt="Screen Shot 2022-06-03 at 11 18 48" src="https://user-images.githubusercontent.com/94465107/171785342-212b4adb-e3b8-45f7-8347-350a16d7e4aa.png">

Under folder "SamplePackageToCallCasperSDKObjectiveC" create new header file with name "StateRootHashHandler.h" by Right click the "SamplePackageToCallCasperSDKObjectiveC" folder add choose "New file..."

<img width="1440" alt="Screen Shot 2022-06-03 at 11 20 04" src="https://user-images.githubusercontent.com/94465107/171785627-9811cfe9-9cec-4484-8470-98afa1beb750.png">

Choose "Header file"

<img width="1440" alt="Screen Shot 2022-06-03 at 11 18 05" src="https://user-images.githubusercontent.com/94465107/171785406-be23ad6d-b16b-4ae6-a97c-b836b03dd619.png">

Give the name "StateRootHashHandler" for the header file, make sure the "Target" check boxes are all checked.

<img width="1440" alt="Screen Shot 2022-06-03 at 11 21 42" src="https://user-images.githubusercontent.com/94465107/171785754-096911b5-06ce-41e1-a882-e5e97dbeb2cc.png">

Then click "Create" button.

Enter the following content for the Header file
 
 ```ObjectiveC
#ifndef StateRootHashHandler_h
#define StateRootHashHandler_h
#import <Foundation/Foundation.h>
@interface StateRootHashHandler:NSObject
@property NSString * stateRootHash;
-(void) getStateRootHashWithCallID:(NSString*) callID;
@end
#endif 
 ```

Next step is to add an ObjectiveC file in "Core" folder.

Right click on the "Core" folder and choose "New file..."

<img width="1440" alt="Screen Shot 2022-06-03 at 11 25 39" src="https://user-images.githubusercontent.com/94465107/171786095-b7c70006-1ea9-49cd-bd50-efdc44a2de97.png">

In the next window, choose "Objective-C file"

<img width="1440" alt="Screen Shot 2022-06-03 at 11 25 56" src="https://user-images.githubusercontent.com/94465107/171786130-a24a907e-9133-46c9-ba5b-ced2c592d421.png">

Give the file a name, in this case "StateRootHashHandler"

<img width="1440" alt="Screen Shot 2022-06-03 at 11 27 34" src="https://user-images.githubusercontent.com/94465107/171786227-d7b84c28-ab94-4d05-bbae-c2622f77a5f7.png">

Then click "Next"

<img width="1440" alt="Screen Shot 2022-06-03 at 11 27 43" src="https://user-images.githubusercontent.com/94465107/171786268-a9850c56-682b-4189-8f86-1ef7a45914a0.png">

Check all the check box in the "Target" section then click "Create".

Add the following content to the newly created "StateRootHashHandler.m" file

 ```ObjectiveC
#import "SamplePackageToCallCasperSDKObjectiveC/StateRootHashHandler.h"
@import CasperSDKObjectiveC_CommonClasses;
@import CasperSDKObjectiveC_GetStateRootHash;
@implementation StateRootHashHandler
int counterStateRootHash = 0;
int maxCounter = 50;
-(void)onTick:(NSTimer *)timer {
    GetStateRootHashRPC * item = [[timer userInfo] objectForKey:@"param1"];
    NSString * callID = [[timer userInfo] objectForKey:@"param2"];
    if([item.valueDict[callID] isEqualToString:RPC_VALUE_NOT_SET]) {
    } else if([item.valueDict[callID] isEqualToString:RPC_VALUE_ERROR_OBJECT]) {
        NSLog(@"Get state root hash error");
        [timer invalidate];
        timer = nil;
    }else {
        NSLog(@"Find state root hash:%@",item.valueDict[callID]);
        self.stateRootHash = item.valueDict[callID];
        [timer invalidate];
        timer = nil;
    }
    counterStateRootHash ++;
    if(counterStateRootHash == maxCounter) {
        [timer invalidate];
        timer = nil;
    }
}
-(void) getStateRootHashWithCallID:(NSString*) callID {
    BlockIdentifier * bi = [[BlockIdentifier alloc] init];
    bi.blockType = USE_NONE;
    GetStateRootHashRPC * item = [[GetStateRootHashRPC alloc] init];
    [item initializeWithRPCURL:URL_TEST_NET];
    NSString * jsonString = [bi toJsonStringWithMethodName:CASPER_RPC_METHOD_GET_STATE_ROOT_HASH];
    [item getStateRootHashWithJsonParam:jsonString];
    //NSString * callID = @"getStateRootHash1";
    [item getStateRootHashWithJsonParam2:jsonString andCallID:callID];
    NSTimer * t = [NSTimer scheduledTimerWithTimeInterval: 1.0
                          target: self
                          selector:@selector(onTick:)
                                                 userInfo: @{@"param1":item,@"param2":callID} repeats:YES];
}

@end
 ```
 
 Somehow you will see some errors appear, but it is not a problem because we have not done with the setup yet.
 
 Create 1 more folder with name "Full" and add more sub folder to it with quite the same steps for "Core" folder, until you have the structure like this:(See the left panel to view the folders and files structure).
 
 <img width="1440" alt="Screen Shot 2022-06-03 at 11 51 13" src="https://user-images.githubusercontent.com/94465107/171788411-609e0d89-d245-42b9-be28-0f2587075c2f.png">

In file "GetStatusHandler.h" under folder "Full/Public/SamplePackageToCallCasperSDKObjectiveC" enter the following content:


 ```ObjectiveC
 #ifndef GetStatusHandler_h
#define GetStatusHandler_h

#import <Foundation/Foundation.h>

@interface GetStatusHandler : NSObject

-(void) sayHello;

@end
#endif
 
 ```
 
 In file "GetStatusHandler.m" under folder "Full" enter the following content:


 ```ObjectiveC
 
 #import "SamplePackageToCallCasperSDKObjectiveC/GetStatusHandler.h"
@implementation GetStatusHandler
-(void) sayHello {
    NSLog(@"Say hello again called");
}
@end

  ```
 Delete the unnecessary files and folders by selecting them, right click and choose Delete.
 
 <img width="1440" alt="Screen Shot 2022-06-03 at 11 34 36" src="https://user-images.githubusercontent.com/94465107/171787356-e56c4ff8-9fbf-4c9f-8d0d-0e12df5b2ade.png">
 
 Somehow the project now will look like the image below, still with errors.

 <img width="1440" alt="Screen Shot 2022-06-03 at 11 34 52" src="https://user-images.githubusercontent.com/94465107/171787399-c5e0dcf8-f850-4d59-8fa6-62cb477d0267.png">

Close the project and quit Xcode.

Back to the project folder, this time Double click the file "Package.swift" to open the Project again in Xcode.

<img width="975" alt="Screen Shot 2022-06-03 at 11 41 48" src="https://user-images.githubusercontent.com/94465107/171787567-8a653ddd-01ac-4b7d-9d29-ce64bd3487b4.png">

Somehow the project will be like this when it is open again.(Ofcourse without any error).

<img width="1440" alt="Screen Shot 2022-06-03 at 11 42 57" src="https://user-images.githubusercontent.com/94465107/171787633-24c2b213-9faf-4beb-9642-db152cdeb332.png">

If you can not make it, maybe you need to restart your Mac and try to Double clicke the "Package.swift" file again when the laptop is ready.

As you can see, the package is ready and there are imported package information also.

<img width="1440" alt="Screen Shot 2022-06-03 at 11 58 51" src="https://user-images.githubusercontent.com/94465107/171789450-6fd7faea-22bc-4061-8d93-e2eb662bd99d.png">


Next step is select a target for the package.

<img width="1440" alt="Screen Shot 2022-06-03 at 11 45 30" src="https://user-images.githubusercontent.com/94465107/171787939-d147af76-b1b0-4f2a-806b-84e2b3bc3369.png">

 You will see a list of devices, choose 1 device such as Ipad (8th Generation).
 
 <img width="1440" alt="Screen Shot 2022-06-03 at 11 55 36" src="https://user-images.githubusercontent.com/94465107/171788831-0d9ee2f7-3b88-4e6d-9a93-fcf9b05979ce.png">

 Now you can build the package. Hit "Product->Build"
 
 <img width="1440" alt="Screen Shot 2022-06-03 at 11 56 01" src="https://user-images.githubusercontent.com/94465107/171788898-adf047f2-3314-40ed-917b-05a9109e9fde.png">
 
 This package should be built without any error.

### Make the package callable from Github

To make the already build package above available in Github and can be call from other ObjectiveC, do the following steps:

 
 ### Package source code
 
 The sample code for the package is at this address:
 
 https://github.com/hienbui9999/ObjectiveCPackageCallCasperSDK
 
 And a sample ObjectiveC that use that Package can be found at this address:
 
 https://github.com/hienbui9999/SampleCallToObjectiveCPackage2
