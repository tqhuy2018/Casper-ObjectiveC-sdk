// swift-tools-version:5.1

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
            path: "CasperSDKObjectiveC",
            exclude: [
            ],
            cSettings: [
            ]
        )
    ]
)
