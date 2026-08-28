struct CheckoutItem: Equatable {
    let name: String
    let price: Int
}

func checkoutTotal(items: [CheckoutItem], taxPercentage: Int) -> Int {
    let subtotal = items.map(\.price).reduce(0, +)
    return subtotal + subtotal * taxPercentage / 100
}
