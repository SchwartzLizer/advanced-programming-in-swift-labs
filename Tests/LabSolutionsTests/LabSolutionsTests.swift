import XCTest
@testable import LabSolutions

final class LabSolutionsTests: XCTestCase {
    func testIngredientRawValuesAndCases() {
        XCTAssertEqual(Ingredient.spinach.rawValue, "Spinach")
        XCTAssertEqual(Ingredient.broccoli.rawValue, "Broccoli")
        XCTAssertEqual(Ingredient.carrot.rawValue, "Carrot")
        XCTAssertEqual(Ingredient.pasta.rawValue, "Pasta")
        XCTAssertEqual(Ingredient.allCases.count, 4)
    }

    func testRecipeInformationStoresAssociatedAllergenValue() {
        let information = RecipeInformation.allergens(information: "Peanuts")

        guard case let .allergens(value) = information else {
            return XCTFail("Expected allergen information")
        }

        XCTAssertEqual(value, "Peanuts")
    }

    func testSetKeepsUniqueValuesAndSupportsRemoval() {
        var reservations: Set<String> = ["Alice", "Bob", "Alice"]

        XCTAssertEqual(reservations.count, 2)
        reservations.remove("Bob")
        XCTAssertEqual(reservations, ["Alice"])
    }

    func testDivideReturnsQuotient() throws {
        XCTAssertEqual(try divide(10, by: 2), 5)
    }

    func testDivideByZeroThrowsTypedError() {
        XCTAssertThrowsError(try divide(10, by: 0)) { error in
            XCTAssertEqual(error as? CalculatorError, .divisionByZero)
        }
    }

    func testNewYorkRevenueUsesFilterMapReduce() {
        let orders = [
            Order(price: 50, location: "New York"),
            Order(price: 25, location: "Boston"),
            Order(price: 75, location: "New York")
        ]

        XCTAssertEqual(totalRevenueOf(orders, location: "New York"), 125)
    }

    func testCheckoutTotalIncludesTaxUsingIntegerCents() {
        let items = [
            CheckoutItem(name: "Pasta", price: 625),
            CheckoutItem(name: "Burger", price: 850),
            CheckoutItem(name: "Salad", price: 325),
            CheckoutItem(name: "Water", price: 175)
        ]

        XCTAssertEqual(checkoutTotal(items: items, taxPercentage: 20), 2_370)
    }
}
