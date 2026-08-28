# Advanced Programming in Swift Labs — Design Spec

Date: 2026-08-28
Status: Approved by user in chat

## Goal

Deliver all nine coding labs visible in the Coursera Advanced Programming in Swift modules 1–4, with a readable repository layout, deterministic tests for the non-UI behavior, and a macOS GitHub Actions workflow because the current Windows workspace has no Swift/Xcode toolchain.

## Scope

- Module 1: raw/associated enum values; Set operations.
- Module 2: inheritance/type casting/polymorphism; protocols; delegation.
- Module 3: throwable calculator; map/filter/reduce revenue; XCTest checkout test.
- Module 4: Little Lemon SwiftUI menu final project, including menu models, mock data, navigation/options/details views, and MenuItem tests.
- Repository documentation and CI only where needed to make the work reproducible.

Quizzes, peer-review submissions, Coursera progress changes, and any credentials are out of scope.

## Repository layout

```text
README.md
Package.swift
project.yml
Labs/
  Module-1/
    01-enums/main.swift
    02-sets/main.swift
  Module-2/
    01-inheritance/main.swift
    02-protocols/main.swift
    03-delegation/main.swift
  Module-3/
    01-error-handling/main.swift
    02-map-filter-reduce/main.swift
    03-unit-test/
      Checkout.swift
      CheckoutTests.swift
FinalProject/LittleLemonMenu/
  Models.swift
  MenuViewModel.swift
  MenuItemsView.swift
  MenuItemsOptionView.swift
  MenuItemDetailsView.swift
  LittleLemonMenuApp.swift
  Resources/Assets.xcassets/
    LittleLemonLogo.imageset/
      Contents.json
      LittleLemonLogo.png
FinalProject/LittleLemonMenuTests/
  MenuItemTests.swift
Tests/LabSolutionsTests/
  LabSolutionsTests.swift
.github/workflows/swift.yml
```

The standalone `main.swift` files mirror the Coursera exercise boundaries. Module 1–3 deterministic logic lives in a Swift Package target. The final project is a separate iOS application generated from `project.yml` with XcodeGen; its unit-test target compiles and tests the same model/view-model sources used by the app.

## Architecture

**MVVM — fit.** The final project is a small SwiftUI feature with screen-level state and no external effect orchestration. `MenuViewModel` owns menu collections and filtering/sorting state; views render state and send user actions. The labs remain intentionally direct examples rather than being forced into app-wide abstractions. This follows the Swift architecture selection guide’s default SwiftUI recommendation.

The menu model uses Foundation `UUID`, `MenuCategory`, and `Ingredient` enums. A single `MenuItem` reference type conforms to `MenuItemProtocol` and `Identifiable`. The Coursera task’s contradictory duplicate `price` bullets are resolved as one `price: Double` property. The checkout lab remains independent and stores monetary values as integer cents.

## Data flow and behavior

- `MenuItemsView` observes `MenuViewModel`, renders a `LazyVGrid`, and presents `MenuItemsOptionView` from a trailing navigation button.
- Selecting a card presents `MenuItemDetailsView` with title, category, price, ingredients, and order count.
- Options use `MenuCategory` and `MenuSortOption` enums; filtering/sorting is implemented as a useful extension while preserving the requested labels.
- Mock data contains exactly 12 food, 8 drink, and 4 dessert items.
- Error-handling lab throws a typed division-by-zero error and demonstrates `do/catch`.
- Functional-programming lab filters New York orders, maps prices, reduces to `125` using the lesson data.
- Checkout logic uses integer cents and tax percentage; the lesson example `[625, 850, 325, 175]` at 20% returns `2370`.

## Testing and verification

- Create the GitHub repository and macOS workflow before production behavior. Push test-only commits first and record the expected RED run; add implementation commits afterward and record GREEN.
- GitHub Actions installs XcodeGen, generates `LittleLemonMenu.xcodeproj`, runs `swift test`, compiles standalone lab sources, and runs `xcodebuild test` against an available iOS Simulator.
- XcodeGen is a build-time development tool only. The app has no third-party runtime dependencies.
- Before any completion claim, inspect `git diff`, run all locally available structural checks, and verify the live GitHub repository plus workflow result through BrowserOS neo.

## Risks and explicit limitations

- SwiftUI cannot be compiled on Windows without Xcode. Runtime verification therefore comes from macOS GitHub Actions and its iOS Simulator.
- The Coursera final-project task says `price` once as `Double` and later as `Int`; the implementation keeps the coherent `Double` declaration and documents the source ambiguity.
- Coursera’s final solution page is locked in the current account, so implementation follows the accessible exercise requirements and expected outputs.
- The repository uses an original generated lemon-and-leaves logo instead of copying the course logo.
