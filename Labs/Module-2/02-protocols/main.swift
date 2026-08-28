import Foundation

protocol MenuItemProtocol {
    var name: String { get }
    var price: Double { get }
    func itemDescription() -> String
}

final class MainDish: MenuItemProtocol {
    let name: String
    let price: Double

    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }

    func itemDescription() -> String {
        "\(name): $\(String(format: \"%.2f\", price))"
    }
}

let pasta = MainDish(name: "Pasta", price: 12.50)
print(pasta.itemDescription())
