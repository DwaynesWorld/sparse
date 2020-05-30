// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Sparse",
  products: [
    .library( name: "Sparse", targets: ["Sparse"]),
  ],
  dependencies: [
    .package(url: "https://github.com/JohnSundell/Files", from: "4.0.0"),
    .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
  ],
  targets: [
    .target(name: "Sparse", dependencies: ["Files", .product(name: "NIO", package: "swift-nio")]),
    .testTarget(name: "SparseTests", dependencies: ["Sparse"]),
  ]
)
