import XCTest
@testable import LittleLemonMenu

@MainActor
final class MenuItemTests: XCTestCase {
    func testMenuItemStoresTitleAndIngredients() {
        let item = MenuItem(
            title: "Garden Pasta",
            price: 12.50,
            menuCategory: .food,
            ordersCount: 42,
            ingredients: [.spinach, .pasta, .tomatoSauce]
        )

        XCTAssertEqual(item.title, "Garden Pasta")
        XCTAssertEqual(item.ingredients, [.spinach, .pasta, .tomatoSauce])
    }

    func testMenuItemSatisfiesProtocolValues() {
        let concreteItem = MenuItem(
            title: "Carrot Juice",
            price: 5.25,
            menuCategory: .drink,
            ordersCount: 18,
            ingredients: [.carrot]
        )
        let item: any MenuItemProtocol = concreteItem

        XCTAssertEqual(item.id, concreteItem.id)
        XCTAssertEqual(item.price, 5.25)
        XCTAssertEqual(item.title, "Carrot Juice")
        XCTAssertEqual(item.menuCategory, .drink)
        XCTAssertEqual(item.ordersCount, 18)
        XCTAssertEqual(item.ingredients, [.carrot])
    }

    func testViewModelProvidesExactCategoryCounts() {
        let viewModel = MenuViewModel()

        XCTAssertEqual(viewModel.menuItems.filter { $0.menuCategory == .food }.count, 12)
        XCTAssertEqual(viewModel.menuItems.filter { $0.menuCategory == .drink }.count, 8)
        XCTAssertEqual(viewModel.menuItems.filter { $0.menuCategory == .dessert }.count, 4)
        XCTAssertEqual(viewModel.menuItems.count, 24)
    }

    func testCategoryFilteringReturnsOnlySelectedCategories() {
        let viewModel = MenuViewModel()
        viewModel.selectedCategories = [.drink, .dessert]

        XCTAssertEqual(viewModel.filteredAndSortedItems.count, 12)
        XCTAssertTrue(
            viewModel.filteredAndSortedItems.allSatisfy {
                $0.menuCategory == .drink || $0.menuCategory == .dessert
            }
        )
    }

    func testEmptyCategorySelectionShowsAllItems() {
        let viewModel = MenuViewModel()
        viewModel.selectedCategories = []

        XCTAssertEqual(viewModel.filteredAndSortedItems.count, 24)
    }

    func testMostPopularSortUsesDescendingOrderCount() {
        let viewModel = MenuViewModel()
        viewModel.sortOption = .mostPopular

        let counts = viewModel.filteredAndSortedItems.map(\.ordersCount)
        XCTAssertEqual(counts, counts.sorted(by: >))
    }

    func testPriceSortUsesAscendingPrice() {
        let viewModel = MenuViewModel()
        viewModel.sortOption = .price

        let prices = viewModel.filteredAndSortedItems.map(\.price)
        XCTAssertEqual(prices, prices.sorted())
    }

    func testAlphabeticalSortUsesLocalizedAscendingTitles() {
        let viewModel = MenuViewModel()
        viewModel.sortOption = .alphabetical

        let titles = viewModel.filteredAndSortedItems.map(\.title)
        let expected = titles.sorted {
            $0.localizedStandardCompare($1) == .orderedAscending
        }
        XCTAssertEqual(titles, expected)
    }
}
