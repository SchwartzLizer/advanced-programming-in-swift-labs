# Advanced Programming in Swift Labs Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build all nine accessible Coursera coding labs from Advanced Programming in Swift modules 1–4 in one reproducible repository, including an iOS Simulator-tested Little Lemon app.

**Architecture:** Module 1–3 use a Swift Package library plus independently copyable playground files. Module 4 uses a separate XcodeGen-generated iOS app with MVVM; its XCTest target compiles the exact same model and view-model sources as the app. GitHub Actions exists before behavior implementation so test-only commits can prove RED before implementation commits prove GREEN.

**Tech Stack:** Swift 5.9+, Swift Package Manager, SwiftUI, Foundation, XCTest, XcodeGen, GitHub Actions `macos-latest`.

**Spec:** `docs/superpowers/specs/2026-08-28-advanced-programming-in-swift-labs-design.md`

## Global Constraints

- Deliver nine labs: Module 1 (2), Module 2 (3), Module 3 (3), Module 4 final project (1).
- Use no third-party app/runtime dependencies. XcodeGen is allowed only as a build-time project generator.
- Keep `MenuItem.price` as `Double`; checkout prices remain separate `Int` cents.
- Preserve expected outputs: revenue `125`, checkout total `2370`, and delegate output for no driver/Bob.
- Do not claim local Swift/Xcode execution. Runtime evidence must come from macOS GitHub Actions.
- Use the original generated logo at `FinalProject/LittleLemonMenu/Resources/Assets.xcassets/LittleLemonLogo.imageset/LittleLemonLogo.png`.

---

### Task 1: Bootstrap GitHub, XcodeGen, and CI before production behavior

**Files:**
- Create: `.gitignore`
- Create: `Package.swift`
- Create: `project.yml`
- Create: `.github/workflows/swift.yml`
- Verify: `FinalProject/LittleLemonMenu/Resources/Assets.xcassets/Contents.json`
- Verify: `FinalProject/LittleLemonMenu/Resources/Assets.xcassets/LittleLemonLogo.imageset/Contents.json`
- Verify: `FinalProject/LittleLemonMenu/Resources/Assets.xcassets/LittleLemonLogo.imageset/LittleLemonLogo.png`

**Interfaces:**
- SwiftPM library target: `LabSolutions` at `Sources/LabSolutions`.
- SwiftPM test target: `LabSolutionsTests` at `Tests/LabSolutionsTests`.
- XcodeGen application target: `LittleLemonMenu`, iOS 16.0, sources and resources under `FinalProject/LittleLemonMenu`.
- XcodeGen unit-test target: `LittleLemonMenuTests`, sources under `FinalProject/LittleLemonMenuTests`, dependency on `LittleLemonMenu`.

- [ ] **Step 1: Create the approved GitHub repository through BrowserNeo.** Create public `SchwartzLizer/advanced-programming-in-swift-labs`, keep it empty, rename the local branch with `git branch -M main`, add `origin`, and push existing design/plan history with `git push -u origin main`.
- [ ] **Step 2: Add `project.yml`.** Use this target contract so XcodeGen builds app sources and tests the same module:

```yaml
name: LittleLemonMenu
options:
  deploymentTarget:
    iOS: "16.0"
settings:
  base:
    SWIFT_VERSION: "5.9"
targets:
  LittleLemonMenu:
    type: application
    platform: iOS
    sources:
      - path: FinalProject/LittleLemonMenu
        excludes:
          - Resources
    resources:
      - path: FinalProject/LittleLemonMenu/Resources
    info:
      path: FinalProject/LittleLemonMenu/Info.plist
      properties:
        CFBundleDisplayName: Little Lemon
        UILaunchScreen: {}
    settings:
      base:
        PRODUCT_BUNDLE_IDENTIFIER: com.schwartzlizer.LittleLemonMenu
        TARGETED_DEVICE_FAMILY: "1,2"
  LittleLemonMenuTests:
    type: bundle.unit-test
    platform: iOS
    sources:
      - path: FinalProject/LittleLemonMenuTests
    dependencies:
      - target: LittleLemonMenu
    settings:
      base:
        PRODUCT_BUNDLE_IDENTIFIER: com.schwartzlizer.LittleLemonMenuTests
schemes:
  LittleLemonMenu:
    build:
      targets:
        LittleLemonMenu: all
        LittleLemonMenuTests: [test]
    test:
      targets:
        - LittleLemonMenuTests
```
- [ ] **Step 3: Add CI before feature code.** Workflow triggers on `push` and `pull_request`, installs XcodeGen with Homebrew, runs `swift test`, compiles each standalone `main.swift`, runs `xcodegen generate --spec project.yml`, and selects an available iPhone simulator with:

```sh
SIMULATOR_ID=$(xcrun simctl list devices available -j | \
  jq -r '[.devices[][] | select(.isAvailable and (.name | startswith("iPhone")))] | first | .udid')
test -n "$SIMULATOR_ID"
```

Then run:

```sh
xcodebuild -project LittleLemonMenu.xcodeproj \
  -scheme LittleLemonMenu \
  -destination "platform=iOS Simulator,id=$SIMULATOR_ID" \
  CODE_SIGNING_ALLOWED=NO test
```

- [ ] **Step 4: Ignore generated/build artifacts.** Add `.build/`, `DerivedData/`, and `LittleLemonMenu.xcodeproj/` to `.gitignore`; `project.yml` remains source of truth.
- [ ] **Step 5: Commit and push infrastructure.** Commit `ci: bootstrap Swift and XcodeGen verification`. This run may be red because feature targets are incomplete; do not count it as TDD evidence.

### Task 2: Module 1–3 tests, RED commit, and implementations

**Files:**
- Create: `Sources/LabSolutions/LabSolutions.swift`
- Create: `Tests/LabSolutionsTests/LabSolutionsTests.swift`
- Create: `Labs/Module-1/01-enums/main.swift`
- Create: `Labs/Module-1/02-sets/main.swift`
- Create: `Labs/Module-2/01-inheritance/main.swift`
- Create: `Labs/Module-2/02-protocols/main.swift`
- Create: `Labs/Module-2/03-delegation/main.swift`
- Create: `Labs/Module-3/01-error-handling/main.swift`
- Create: `Labs/Module-3/02-map-filter-reduce/main.swift`
- Create: `Labs/Module-3/03-unit-test/Checkout.swift`
- Create: `Labs/Module-3/03-unit-test/CheckoutTests.swift`

**Interfaces:**
- `Ingredient: String, CaseIterable`; `RecipeInformation.allergens(information: String)`.
- `CalculatorError.divisionByZero`; `divide(_:by:) throws -> Double`.
- `Order(price: Int, location: String)`; `totalRevenueOf(_:location:) -> Int`.
- `CheckoutItem(name: String, price: Int)`; `checkoutTotal(items:taxPercentage:) -> Int`.

- [ ] **Step 1: Write tests before implementation.** Assert enum raw/associated values, Set uniqueness/removal, `divide(10, by: 0)` throws `divisionByZero`, New York revenue equals `125`, and `[625, 850, 325, 175]` at 20% equals `2370`.
- [ ] **Step 2: Commit and push RED.** Commit only package manifest/test declarations required to express the missing behavior. Verify GitHub Actions fails for missing symbols or failed expectations and record the workflow URL.
- [ ] **Step 3: Implement minimum package behavior.** Add only code required by tests; use typed error handling, integer cents for checkout, and filter/map/reduce for revenue.
- [ ] **Step 4: Add eight standalone Module 1–3 lab deliverables.** Each file follows the accessible Coursera steps and retains required expected output.
- [ ] **Step 5: Push GREEN.** Run structural checks locally, commit `feat: add tested module lab solutions`, push, and verify `swift test` plus standalone compilation pass in GitHub Actions.

### Task 3: Final app tests, RED commit, and MVVM implementation

**Files:**
- Create: `FinalProject/LittleLemonMenuTests/MenuItemTests.swift`
- Create: `FinalProject/LittleLemonMenu/Models.swift`
- Create: `FinalProject/LittleLemonMenu/MenuViewModel.swift`
- Create: `FinalProject/LittleLemonMenu/MenuItemsView.swift`
- Create: `FinalProject/LittleLemonMenu/MenuItemsOptionView.swift`
- Create: `FinalProject/LittleLemonMenu/MenuItemDetailsView.swift`
- Create: `FinalProject/LittleLemonMenu/LittleLemonMenuApp.swift`

**Interfaces:**
- `MenuCategory: String, CaseIterable` with `food`, `drink`, `dessert`.
- `Ingredient: String, CaseIterable` with `spinach`, `broccoli`, `carrot`, `pasta`, `tomatoSauce`.
- `MenuSortOption: String, CaseIterable` with labels `Most Popular`, `Price $-$$$`, `A-Z`.
- `MenuItemProtocol` requires `id: UUID`, `price: Double`, `title: String`, `menuCategory: MenuCategory`, `ordersCount: Int`, and `ingredients: [Ingredient]`.
- `@MainActor final class MenuViewModel: ObservableObject` publishes category selections, sort option, and exactly 12 food, 8 drink, 4 dessert items.

- [ ] **Step 1: Write app tests first.** Test `MenuItem` title/ingredients, protocol values, exact 12/8/4 counts, category filtering, most-popular ordering, ascending-price ordering, and localized A–Z ordering.
- [ ] **Step 2: Commit and push RED.** Commit tests without implementations, push, and verify `xcodebuild test` fails for expected missing types. Record the workflow URL.
- [ ] **Step 3: Implement one source of truth.** Add models and `MenuViewModel` only under `FinalProject/LittleLemonMenu`; app tests import the generated app module with `@testable import LittleLemonMenu`.
- [ ] **Step 4: Implement SwiftUI flow.** `MenuItemsView` owns its model with `@StateObject`, renders a `LazyVGrid`, opens options from a trailing toolbar button, and navigates to details. Options use enum-backed category/sort controls. Details show logo, title, category, price, orders count, and ingredients.
- [ ] **Step 5: Push GREEN.** Commit `feat: add Little Lemon SwiftUI final project`, push, and verify both `xcodebuild test` and simulator build pass.
- [ ] **Step 6: Capture visual evidence.** Build, install, launch, and capture the generated app using the same simulator:

```sh
xcrun simctl boot "$SIMULATOR_ID" 2>/dev/null || true
xcrun simctl bootstatus "$SIMULATOR_ID" -b
xcodebuild -project LittleLemonMenu.xcodeproj \
  -scheme LittleLemonMenu \
  -destination "platform=iOS Simulator,id=$SIMULATOR_ID" \
  -derivedDataPath DerivedData \
  CODE_SIGNING_ALLOWED=NO build
xcrun simctl install "$SIMULATOR_ID" \
  DerivedData/Build/Products/Debug-iphonesimulator/LittleLemonMenu.app
xcrun simctl launch "$SIMULATOR_ID" com.schwartzlizer.LittleLemonMenu
xcrun simctl io "$SIMULATOR_ID" screenshot little-lemon-menu.png
```

Upload `little-lemon-menu.png` with `actions/upload-artifact`.

### Task 4: Documentation and final verification

**Files:**
- Create: `README.md`
- Modify: `.github/workflows/swift.yml`

- [ ] **Step 1: Document all nine labs.** Include run instructions, expected outputs, XcodeGen setup, generated-logo attribution, the duplicate-price interpretation, and Windows/Xcode limitation.
- [ ] **Step 2: Verify repository content locally.** Run `git diff --check`, inventory files with `rg --files`, scan for placeholders, and confirm no credentials or generated Xcode project are tracked.
- [ ] **Step 3: Verify live GitHub state through BrowserNeo.** Confirm repository URL, `main` branch, commit history, README, asset, and latest workflow result.
- [ ] **Step 4: Commit final documentation.** Commit `docs: document Swift labs and verification`, push, and wait for the final green workflow before claiming completion.

---

## Plan self-review

- Final app path: XcodeGen produces a real iOS app/test project and CI executes its actual sources on an iOS Simulator.
- TDD path: GitHub/CI exists first; separate test-only and implementation commits provide RED and GREEN evidence.
- Source path: package tests cover Module 1–3; app tests cover the same models/view model compiled into the app. No duplicate final-project model target exists.
- Upload path: BrowserNeo creates/verifies the repository; local `git push` preserves commit history.
- Ambiguity path: menu `price` is `Double`; checkout cents remain independent `Int` values.
