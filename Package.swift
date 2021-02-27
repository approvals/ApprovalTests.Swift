// swift-tools-version:5.2

import PackageDescription

let package = Package(
        name: "ApprovalTests.Swift",
        platforms: [
            .macOS(.v10_14),
        ],
        products: [
            .library(
                    name: "ApprovalTests.Swift",
                    targets: ["ApprovalTests.Swift"]),
        ],
        targets: [
            .target(
                    name: "ApprovalTests.Swift",
                    dependencies: [],
                    path: "ApprovalTests.Swift"
            ),
            .testTarget(
                    name: "ApprovalTests.SwiftTests",
                    dependencies: ["ApprovalTests.Swift"],
                    path: "ApprovalTests.SwiftTests"
            ),
        ]
)
