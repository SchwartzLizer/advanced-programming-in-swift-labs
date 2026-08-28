// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "AdvancedProgrammingInSwiftLabs",
    products: [
        .library(name: "LabSolutions", targets: ["LabSolutions"])
    ],
    targets: [
        .target(
            name: "LabSolutions",
            path: "Sources/LabSolutions"
        ),
        .testTarget(
            name: "LabSolutionsTests",
            dependencies: ["LabSolutions"],
            path: "Tests/LabSolutionsTests"
        )
    ]
)
