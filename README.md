# Advanced Programming in Swift Labs

[![Swift Labs](https://github.com/SchwartzLizer/advanced-programming-in-swift-labs/actions/workflows/swift.yml/badge.svg)](https://github.com/SchwartzLizer/advanced-programming-in-swift-labs/actions/workflows/swift.yml)

Completed coding labs for Coursera's **Advanced Programming in Swift** course. The repository contains independently runnable Swift examples for Modules 1–3 and an XcodeGen-generated SwiftUI final project for Module 4.

## Lab inventory

| Module | Lab | Deliverable |
| --- | --- | --- |
| 1 | Enums: raw and associated values | `Labs/Module-1/01-enums/main.swift` |
| 1 | Sets | `Labs/Module-1/02-sets/main.swift` |
| 2 | Inheritance | `Labs/Module-2/01-inheritance/main.swift` |
| 2 | Protocols with classes | `Labs/Module-2/02-protocols/main.swift` |
| 2 | Delegation | `Labs/Module-2/03-delegation/main.swift` |
| 3 | Error handling | `Labs/Module-3/01-error-handling/main.swift` |
| 3 | Map, filter, and reduce | `Labs/Module-3/02-map-filter-reduce/main.swift` |
| 3 | Unit testing a checkout | `Labs/Module-3/03-unit-test/` |
| 4 | Little Lemon SwiftUI final project | `FinalProject/LittleLemonMenu/` |

## Expected results

- Delegate lab prints both `No driver assigned` and `Delivery started with Bob`.
- Map/filter/reduce lab calculates New York revenue as `125`.
- Checkout lab calculates `2370` cents from `[625, 850, 325, 175]` plus 20% tax.
- The final menu contains exactly 12 food, 8 drink, and 4 dessert items.
- Final-project tests cover model values, category filtering, and popular/price/A–Z sorting.

## Run Modules 1–3

Run the shared package tests:

```sh
swift test
```

Compile and run any standalone lab, for example:

```sh
swiftc Labs/Module-3/02-map-filter-reduce/main.swift -o map-filter-reduce
./map-filter-reduce
```

The course-style checkout XCTest files are in `Labs/Module-3/03-unit-test`. Equivalent behavior is also exercised by the Swift package test target so CI can verify it automatically.

## Run the Little Lemon app

Requirements:

- macOS with a current Xcode installation
- XcodeGen

Generate the project and open it:

```sh
brew install xcodegen
xcodegen generate --spec project.yml
open LittleLemonMenu.xcodeproj
```

Choose the `LittleLemonMenu` scheme and an iPhone Simulator. The generated `.xcodeproj` is intentionally ignored; `project.yml` is the source of truth.

The SwiftUI app provides:

- an adaptive menu grid;
- Food, Drink, and Dessert filters;
- Most Popular, Price $-$$$, and A–Z sorting;
- navigation to item details;
- title, category, price, order count, and ingredients for each item.

## Design decisions

The accessible course instructions list `price` twice with conflicting `Double` and `Int` types. This project keeps the final menu protocol's `price` as `Double`. The separate checkout lab stores prices as `Int` cents, avoiding floating-point currency arithmetic there.

The lemon-and-leaves logo in the asset catalog was generated specifically for this repository from an original prompt. It is not an official Coursera or Little Lemon trademark asset.

## Verification

GitHub Actions runs on macOS and:

1. runs the Swift package tests;
2. compiles every standalone `main.swift`;
3. generates the iOS project with XcodeGen;
4. runs the app XCTest target on an available iPhone Simulator;
5. builds, installs, launches, and captures a simulator screenshot as an artifact.

The commit history preserves test-first evidence:

- [Module tests RED](https://github.com/SchwartzLizer/advanced-programming-in-swift-labs/actions/runs/33190456864)
- [Final-project tests RED](https://github.com/SchwartzLizer/advanced-programming-in-swift-labs/actions/runs/33191195489)
- [Full suite GREEN](https://github.com/SchwartzLizer/advanced-programming-in-swift-labs/actions/runs/33191715087)

The repository was authored from Windows, where Xcode and the iOS Simulator are unavailable. macOS GitHub Actions is therefore the runtime/build evidence; local Windows checks cover repository structure, JSON, and Git hygiene.
