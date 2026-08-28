struct Order {
    let price: Int
    let location: String
}

let orders = [
    Order(price: 50, location: "New York"),
    Order(price: 25, location: "Boston"),
    Order(price: 75, location: "New York")
]

let newYorkRevenue = orders
    .filter { $0.location == "New York" }
    .map(\.price)
    .reduce(0, +)

print(newYorkRevenue)
