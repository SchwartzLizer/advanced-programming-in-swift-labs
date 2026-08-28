import Foundation

class Dish {
    let name: String
    let price: Double

    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }

    func description() -> String {
        "\(name) costs $\(String(format: \"%.2f\", price))"
    }
}

final class AppetizerDish: Dish {
    let servingSize: Int

    init(name: String, price: Double, servingSize: Int) {
        self.servingSize = servingSize
        super.init(name: name, price: price)
    }

    override func description() -> String {
        "\(super.description()) and serves \(servingSize)"
    }
}

let appetizer = AppetizerDish(name: "Bruschetta", price: 8.50, servingSize: 2)
print(appetizer.description())
