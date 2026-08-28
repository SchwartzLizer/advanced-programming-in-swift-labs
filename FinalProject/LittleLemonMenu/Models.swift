import Foundation

enum MenuCategory: String, CaseIterable, Identifiable {
    case food = "Food"
    case drink = "Drink"
    case dessert = "Dessert"

    var id: Self { self }
}

enum Ingredient: String, CaseIterable, Identifiable {
    case spinach = "Spinach"
    case broccoli = "Broccoli"
    case carrot = "Carrot"
    case pasta = "Pasta"
    case tomatoSauce = "Tomato sauce"

    var id: Self { self }
}

enum MenuSortOption: String, CaseIterable, Identifiable {
    case mostPopular = "Most Popular"
    case price = "Price $-$$$"
    case alphabetical = "A-Z"

    var id: Self { self }
}

protocol MenuItemProtocol {
    var id: UUID { get }
    var price: Double { get }
    var title: String { get }
    var menuCategory: MenuCategory { get }
    var ordersCount: Int { get }
    var ingredients: [Ingredient] { get }
}

struct MenuItem: MenuItemProtocol, Identifiable, Equatable {
    let id: UUID
    let price: Double
    let title: String
    let menuCategory: MenuCategory
    let ordersCount: Int
    let ingredients: [Ingredient]

    init(
        id: UUID = UUID(),
        title: String,
        price: Double,
        menuCategory: MenuCategory,
        ordersCount: Int,
        ingredients: [Ingredient]
    ) {
        self.id = id
        self.title = title
        self.price = price
        self.menuCategory = menuCategory
        self.ordersCount = ordersCount
        self.ingredients = ingredients
    }
}
