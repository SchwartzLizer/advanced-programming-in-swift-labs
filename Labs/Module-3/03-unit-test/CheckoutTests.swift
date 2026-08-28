import XCTest

final class CheckoutTests: XCTestCase {
    func testCheckoutTotalIncludesTwentyPercentTax() {
        let items = [
            CheckoutItem(name: "Pasta", price: 625),
            CheckoutItem(name: "Burger", price: 850),
            CheckoutItem(name: "Salad", price: 325),
            CheckoutItem(name: "Water", price: 175)
        ]

        XCTAssertEqual(checkoutTotal(items: items, taxPercentage: 20), 2_370)
    }
}
