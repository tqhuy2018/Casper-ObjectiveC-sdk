# CSPR-ObjectiveC-SDK

ObjectiveC SDK library for interacting with a CSPR node.

## What is CSPR-ObjectiveC-SDK?

SDK  to streamline the 3rd party ObjectiveC client integration processes. Such 3rd parties include exchanges & app developers. 

## System requirement

The SDK use ObjectiveC 2.0 and support device running IOS from 11.0, MacOS from 10.15, WatchOS from 5.3, tvOS from 12.3

## Build and test

To test the project you need to have a Mac with Mac OS and XCode 13 or above to build and run the test.

Download or clone the code from github, then open it with Xcode.

* Configure the Minimum MacOS and IOS version for Package and Test Target:

In TARGETS section of Xcode, choose "CasperSDKObjectiveC". Hit "Build Settings" tab in the Target menu, seach for "macOS Development Target", then choose "macOS 10.15" from the Dropdown list, like in this image:
<img width="1129" alt="Screen Shot 2022-03-12 at 22 08 09" src="https://user-images.githubusercontent.com/94465107/158023467-81e5f205-a791-4278-927c-ce0294eae84b.png">

In TARGETS section of Xcode, choose "CasperSDKObjectiveCTests". Hit "Build Settings" tab in the Target menu, seach for "macOS Development Target", then choose "macOS 10.15" from the Dropdown list, like in this image:

<img width="1125" alt="Screen Shot 2022-03-12 at 22 07 59" src="https://user-images.githubusercontent.com/94465107/158023480-01fa56f1-1692-4adc-9548-45c93701ec21.png">

* Configure "Signing & Capabilities"

The default configuration for both "CasperSDKObjectiveC" and "CasperSDKObjectiveCTests" in this section is in the image below

<img width="868" alt="Screen Shot 2022-03-12 at 22 05 01" src="https://user-images.githubusercontent.com/94465107/158023373-face5ad9-d00d-4a90-91df-828d4dfff34d.png">

<img width="866" alt="Screen Shot 2022-03-12 at 22 05 58" src="https://user-images.githubusercontent.com/94465107/158023400-c21e1b89-20c3-4533-85ec-b6aa6c4711cd.png">

In the menu bar of XCode, hit Product->Build to build the SDK.

In the menu bar of XCode, hit Product->Test to test the SDK.

# Documentation for classes and methods

* [List of classes and methods](./Docs/Help.md#list-of-rpc-methods)

-  [Get State Root Hash](./Docs/Help.md#i-get-state-root-hash)

-  [Get Peer List](./Docs/Help.md##ii-get-peers-list)
