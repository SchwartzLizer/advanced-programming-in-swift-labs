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
Tests/LabSolutionsTests/
  LabSolutionsTests.swift
.github/workflows/swift.yml
```

The standalone `main.swift` files mirror the Coursera exercise boundaries. Shared deterministic logic lives in a Swift Package target so it can be tested and reused without copying implementation across tests. The final project keeps SwiftUI presentation files separate from model/view-model state.

## Architecture

**MVVM — fit.** The final project is a small SwiftUI feature with screen-level state and no external effect orchestration. `MenuViewModel` owns menu collections and filtering/sorting state; views render state and send user actions. The labs remain intentionally direct examples rather than being forced into app-wide abstractions. This follows the Swift architecture selection guide’s default SwiftUI recommendation.

The menu model uses Foundation `UUID`, `MenuCategory`, and `Ingredient` enums. A single `MenuItem` reference type conforms to `MenuItemProtocol` and `Identifiable`, resolving the Coursera task’s contradictory duplicate `price` requirements as `price: Double { get set }` plus `priceInCents: Int { get set }`. This choice is documented in the README and tested.

## Data flow and behavior

- `MenuItemsView` observes `MenuViewModel`, renders a `LazyVGrid`, and presents `MenuItemsOptionView` from a trailing navigation button.
- Selecting a card presents `MenuItemDetailsView` with title, category, price, ingredients, and order count.
- Options use `MenuCategory` and `MenuSortOption` enums; filtering/sorting is implemented as a useful extension while preserving the requested labels.
- Mock data contains exactly 12 food, 8 drink, and 4 dessert items.
- Error-handling lab throws a typed division-by-zero error and demonstrates `do/catch`.
- Functional-programming lab filters New York orders, maps prices, reduces to `125` using the lesson data.
- Checkout logic uses integer cents and tax percentage; the lesson example `[625, 850, 325, 175]` at 20% returns `2370`.

## Testing and verification

- Write tests before production implementations for package logic and menu behavior. On this Windows host, local Swift execution is unavailable; the red/green evidence will be recorded by the macOS CI workflow after the repository is pushed.
- GitHub Actions runs `swift test` on `macos-latest` and syntax-checks each standalone lab source with the Swift compiler available on that runner.
- Before any completion claim, inspect `git diff`, run all locally available structural checks, and verify the live GitHub repository plus workflow result through BrowserOS neo.

## Risks and explicit limitations

- SwiftUI cannot be compiled on Windows without Xcode. The source will be complete, but local UI runtime verification is not possible in this workspace.
- The Coursera final-project task says `price` once as `Double` and later as `Int`; the separate `priceInCents` property preserves both concepts without an impossible duplicate Swift declaration.
- Coursera’s final solution page is locked in the current account, so implementation follows the accessible exercise requirements and expected outputs.

