import Foundation
import PackageDescription
let package = Package(
    name: "CasperSDKObjectiveC",
    products: [
        .library(name: "CasperSDKObjectiveC", targets: ["CasperSDKObjectiveC"])
    ],
    targets: [
        .target(
            name: "CasperSDKObjectiveC",
            path: "Framework",
            exclude: [
                "CasperSDKObjectiveCTests/GetStateRootHashTest.m",
                "CasperSDKObjectiveCTests/GetPeerResultTest.m",
                "CasperSDKObjectiveCTests/GetStatusTest.m",
                "CasperSDKObjectiveCTests/GetBlockTransfersResultTest.m",
                "CasperSDKObjectiveCTests/GetBlockTest.m"
            ],
            cSettings: [
                .headerSearchPath("UI"),
            ]
        )
    ]
)
