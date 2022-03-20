# CSPR-ObjectiveC-SDK

ObjectiveC SDK library for interacting with a CSPR node.

## What is CSPR-ObjectiveC-SDK?

SDK  to streamline the 3rd party ObjectiveC client integration processes. Such 3rd parties include exchanges & app developers. 

## System requirement

The SDK use ObjectiveC 2.0 and support device running IOS from 12.0, MacOS from 10.15, WatchOS from 5.3, tvOS from 12.3

## Build and test

The package can be built an tested from Xcode IDE or Terminal on MacOS

### Build and test in Xcode IDE

To test the project you need to have a Mac with Mac OS and XCode 13 or above to build and run the test.

Download or clone the code from github, then open it with Xcode.

* Configure the Minimum MacOS and IOS version for Package and Test Target:

Check your configuration is the same as below for the SDK in Xcode.

In TARGETS section of Xcode, choose "CasperSDKObjectiveC". Hit "Build Settings" tab in the Target menu, seach for "macOS Development Target", then choose "macOS 10.15" from the Dropdown list, like in this image:
<img width="1126" alt="Screen Shot 2022-03-12 at 22 09 58" src="https://user-images.githubusercontent.com/94465107/158023543-d7cdff7b-98f0-45fa-b36e-a268a78f66af.png">


In TARGETS section of Xcode, choose "CasperSDKObjectiveCTests". Hit "Build Settings" tab in the Target menu, seach for "macOS Development Target", then choose "macOS 10.15" from the Dropdown list, like in this image:

<img width="1127" alt="Screen Shot 2022-03-12 at 22 10 15" src="https://user-images.githubusercontent.com/94465107/158023549-1216b6f8-7245-4ccf-a810-6f08b5d49446.png">


* Configure "Signing & Capabilities"

The default configuration for both "CasperSDKObjectiveC" and "CasperSDKObjectiveCTests" in this section is in the image below

<img width="868" alt="Screen Shot 2022-03-12 at 22 05 01" src="https://user-images.githubusercontent.com/94465107/158023373-face5ad9-d00d-4a90-91df-828d4dfff34d.png">

<img width="866" alt="Screen Shot 2022-03-12 at 22 05 58" src="https://user-images.githubusercontent.com/94465107/158023400-c21e1b89-20c3-4533-85ec-b6aa6c4711cd.png">

In the menu bar of XCode, hit Product->Build to build the SDK.
<img width="1397" alt="Screen Shot 2022-03-12 at 22 15 08" src="https://user-images.githubusercontent.com/94465107/158023727-264cd412-762e-40de-b52b-29b0b682af94.png">


In the menu bar of XCode, hit Product->Test to test the SDK.
<img width="1406" alt="Screen Shot 2022-03-12 at 22 16 44" src="https://user-images.githubusercontent.com/94465107/158023788-ea87de66-687e-41c6-9469-78881e48f2be.png">

You will see the Log information about List Peer and State root hash for the 2 RPC method. (Press "Cmd + Shift + Y" to show the Log if you don't see it)

### Build and test in Terminal

You can check the build and test result from the "Action" section of the SDK in Github.

If you want to make it locally, you still need a Mac running MacOS 10.15 or above and then follow these steps:

1) Download or clone the SDK from Github

2) In terminal enter the folder of the SDK. Run the following commands to build or test trom the folder root of the SDK in terminal:

To build package run this command line:

```ObjectiveC
xcodebuild -scheme CasperSDKObjectiveC build
```
To test package run this command line:

```ObjectiveC
xcodebuild test -scheme CasperSDKObjectiveCTests
```



# Documentation for classes and methods

* [List of classes and methods](./Docs/Help.md#list-of-rpc-methods)

-  [Get State Root Hash](./Docs/Help.md#i-get-state-root-hash)

-  [Get Peer List](./Docs/Help.md#ii-get-peers-list)
