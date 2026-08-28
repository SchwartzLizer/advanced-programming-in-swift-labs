public enum Ingredient: String, CaseIterable {
    case spinach = "Spinach"
    case broccoli = "Broccoli"
    case carrot = "Carrot"
    case pasta = "Pasta"
}

public enum RecipeInformation {
    case allergens(information: String)
}

public enum CalculatorError: Error, Equatable {
    case divisionByZero
}

public func divide(_ dividend: Double, by divisor: Double) throws -> Double {
    guard divisor != 0 else {
        throw CalculatorError.divisionByZero
    }

    return dividend / divisor
}

public struct Order: Equatable {
    public let price: Int
    public let location: String

    public init(price: Int, location: String) {
        self.price = price
        self.location = location
    }
}

public func totalRevenueOf(_ orders: [Order], location: String) -> Int {
    orders
        .filter { $0.location == location }
        .map(\.price)
        .reduce(0, +)
}

public struct CheckoutItem: Equatable {
    public let name: String
    public let price: Int

    public init(name: String, price: Int) {
        self.name = name
        self.price = price
    }
}

public func checkoutTotal(
    items: [CheckoutItem],
    taxPercentage: Int
) -> Int {
    let subtotal = items.map(\.price).reduce(0, +)
    let tax = subtotal * taxPercentage / 100
    return subtotal + tax
}
