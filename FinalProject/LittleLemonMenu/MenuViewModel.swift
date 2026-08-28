import Combine
import Foundation

@MainActor
final class MenuViewModel: ObservableObject {
    @Published var selectedCategories: Set<MenuCategory>
    @Published var sortOption: MenuSortOption
    @Published private(set) var menuItems: [MenuItem]

    init(
        selectedCategories: Set<MenuCategory> = Set(MenuCategory.allCases),
        sortOption: MenuSortOption = .mostPopular,
        menuItems: [MenuItem] = MenuViewModel.makeMenuItems()
    ) {
        self.selectedCategories = selectedCategories
        self.sortOption = sortOption
        self.menuItems = menuItems
    }

    var filteredAndSortedItems: [MenuItem] {
        let filteredItems = selectedCategories.isEmpty
            ? menuItems
            : menuItems.filter { selectedCategories.contains($0.menuCategory) }

        switch sortOption {
        case .mostPopular:
            return filteredItems.sorted {
                if $0.ordersCount == $1.ordersCount {
                    return isTitleOrderedBefore($0.title, $1.title)
                }
                return $0.ordersCount > $1.ordersCount
            }
        case .price:
            return filteredItems.sorted {
                if $0.price == $1.price {
                    return isTitleOrderedBefore($0.title, $1.title)
                }
                return $0.price < $1.price
            }
        case .alphabetical:
            return filteredItems.sorted {
                isTitleOrderedBefore($0.title, $1.title)
            }
        }
    }

    private func isTitleOrderedBefore(_ first: String, _ second: String) -> Bool {
        first.localizedStandardCompare(second) == .orderedAscending
    }

    private static func makeMenuItems() -> [MenuItem] {
        let foodItems = [
            MenuItem(title: "Garden Pasta", price: 12.50, menuCategory: .food, ordersCount: 96, ingredients: [.pasta, .spinach, .tomatoSauce]),
            MenuItem(title: "Broccoli Pasta", price: 13.25, menuCategory: .food, ordersCount: 72, ingredients: [.pasta, .broccoli, .tomatoSauce]),
            MenuItem(title: "Spinach Pasta", price: 11.75, menuCategory: .food, ordersCount: 88, ingredients: [.pasta, .spinach]),
            MenuItem(title: "Carrot Pasta", price: 10.95, menuCategory: .food, ordersCount: 45, ingredients: [.pasta, .carrot, .tomatoSauce]),
            MenuItem(title: "Little Lemon Pasta", price: 14.50, menuCategory: .food, ordersCount: 110, ingredients: [.pasta, .spinach, .broccoli, .tomatoSauce]),
            MenuItem(title: "Tomato Pasta", price: 10.50, menuCategory: .food, ordersCount: 63, ingredients: [.pasta, .tomatoSauce]),
            MenuItem(title: "Green Bowl", price: 9.75, menuCategory: .food, ordersCount: 78, ingredients: [.spinach, .broccoli, .carrot]),
            MenuItem(title: "Spinach Salad", price: 8.50, menuCategory: .food, ordersCount: 92, ingredients: [.spinach, .carrot]),
            MenuItem(title: "Broccoli Salad", price: 8.95, menuCategory: .food, ordersCount: 54, ingredients: [.broccoli, .carrot]),
            MenuItem(title: "Vegetable Plate", price: 11.25, menuCategory: .food, ordersCount: 40, ingredients: [.spinach, .broccoli, .carrot]),
            MenuItem(title: "Pasta Primavera", price: 13.75, menuCategory: .food, ordersCount: 84, ingredients: [.pasta, .spinach, .broccoli, .carrot]),
            MenuItem(title: "Tomato Garden Bowl", price: 9.50, menuCategory: .food, ordersCount: 58, ingredients: [.spinach, .carrot, .tomatoSauce])
        ]

        let drinkItems = [
            MenuItem(title: "Carrot Juice", price: 5.25, menuCategory: .drink, ordersCount: 81, ingredients: [.carrot]),
            MenuItem(title: "Green Juice", price: 5.75, menuCategory: .drink, ordersCount: 75, ingredients: [.spinach, .broccoli]),
            MenuItem(title: "Spinach Smoothie", price: 6.25, menuCategory: .drink, ordersCount: 67, ingredients: [.spinach]),
            MenuItem(title: "Garden Blend", price: 6.50, menuCategory: .drink, ordersCount: 61, ingredients: [.spinach, .broccoli, .carrot]),
            MenuItem(title: "Broccoli Boost", price: 5.95, menuCategory: .drink, ordersCount: 34, ingredients: [.broccoli]),
            MenuItem(title: "Carrot Cooler", price: 4.95, menuCategory: .drink, ordersCount: 70, ingredients: [.carrot]),
            MenuItem(title: "Little Lemon Green", price: 6.75, menuCategory: .drink, ordersCount: 89, ingredients: [.spinach, .carrot]),
            MenuItem(title: "Vegetable Refresher", price: 5.50, menuCategory: .drink, ordersCount: 48, ingredients: [.broccoli, .carrot])
        ]

        let dessertItems = [
            MenuItem(title: "Carrot Bite", price: 6.50, menuCategory: .dessert, ordersCount: 77, ingredients: [.carrot]),
            MenuItem(title: "Garden Sweet", price: 7.25, menuCategory: .dessert, ordersCount: 52, ingredients: [.carrot, .spinach]),
            MenuItem(title: "Little Lemon Treat", price: 7.75, menuCategory: .dessert, ordersCount: 94, ingredients: [.carrot]),
            MenuItem(title: "Sweet Green Cup", price: 6.95, menuCategory: .dessert, ordersCount: 43, ingredients: [.spinach, .carrot])
        ]

        return foodItems + drinkItems + dessertItems
    }
}

typealias MenuViewViewModel = MenuViewModel
